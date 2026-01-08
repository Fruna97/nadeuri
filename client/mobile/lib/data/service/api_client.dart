import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/service/interceptor/token_interceptor.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/data/service/model/member/member_api_model.dart';
import 'package:mobile/data/service/model/nadeuri/nadeuri_api_model.dart';
import 'package:mobile/data/service/model/nadeuri/update_nadeuri_api_model.dart';
import 'package:mobile/data/service/model/sign_in_request/sign_in_request.dart';
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/data/service/model/token/token_api_model.dart';
import 'package:mobile/utils/result.dart';

enum RequestMethod { signUp, getMyProfile, signIn, postNadeuri, getNadeuri, getParticipatingNadeuris, putNadeuri }

class ApiClient {
  final String _logTag = "ApiClient";
  final Duration _connectTimeout = Duration(seconds: 5);
  final Duration _receiveTimeout = Duration(seconds: 5);

  late final Dio _dioWithoutToken;
  late final Dio _dioWithToken;

  ApiClient({
    required String host,
    required int port,
    required Map<String, String> baseHeaders,
    required FlutterSecureStorage flutterSecureStorage,
  }) {
    _dioWithoutToken = Dio(
      BaseOptions(
        baseUrl: "$host:$port",
        headers: baseHeaders,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
      ),
    );
    final TokenInterceptor tokenInterceptor = TokenInterceptor(
      flutterSecureStorage: flutterSecureStorage,
      dioWithoutTokenInterceptor: _dioWithoutToken,
    );
    _dioWithToken = Dio(
      BaseOptions(
        baseUrl: "$host:$port",
        headers: baseHeaders,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
      ),
    )..interceptors.add(tokenInterceptor);
  }

  Future<Result<void>> signUp(SignUpRequest signUpRequest) async {
    final String endpoint = "/member/signup";
    return await _requestAndParse<void>(
      RequestMethod.signUp,
      () => _dioWithoutToken.post(endpoint, data: signUpRequest.toJson()),
      null,
    );
  }

  Future<Result<MemberApiModel>> getMyProfile() async {
    final String endpoint = "/member";
    return await _requestAndParse<MemberApiModel>(
      RequestMethod.getMyProfile,
      () => _dioWithToken.get(endpoint),
      (data) => MemberApiModel.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<Result<TokenApiModel>> signIn(SignInRequest signInRequest) async {
    final String endpoint = "/auth/signin";
    return await _requestAndParse<TokenApiModel>(
      RequestMethod.signIn,
      () => _dioWithoutToken.post(endpoint, data: signInRequest.toJson()),
      (data) => TokenApiModel.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<Result<NadeuriApiModel>> postNadeuri(NadeuriApiModel nadeuriApiModel) async {
    final String endpoint = "/nadeuri";
    return await _requestAndParse<NadeuriApiModel>(
      RequestMethod.postNadeuri,
      () => _dioWithToken.post(endpoint, data: nadeuriApiModel.toJson()),
      (data) => NadeuriApiModel.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<Result<NadeuriApiModel>> getNadeuri(String uuid) async {
    final String endpoint = "/nadeuri/$uuid";
    return await _requestAndParse(
      RequestMethod.getNadeuri,
      () => _dioWithToken.get(endpoint),
      (data) => NadeuriApiModel.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<Result<List<NadeuriApiModel>>> getParticipatingNadeuris() async {
    final String endpoint = "/nadeuri/participating";
    return await _requestAndParse<List<NadeuriApiModel>>(
      RequestMethod.getParticipatingNadeuris,
      () => _dioWithToken.get(endpoint),
      (data) {
        return (data as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((element) => NadeuriApiModel.fromJson(element))
            .toList();
      },
    );
  }

  Future<Result<NadeuriApiModel>> putNadeuri(String uuid, UpdateNadeuriApiModel updateNadeuriApiModel) async {
    final String endpoint = "/nadeuri/$uuid";
    return await _requestAndParse<NadeuriApiModel>(
      RequestMethod.putNadeuri,
      () => _dioWithToken.put(endpoint, data: updateNadeuriApiModel.toJson()),
      (data) => NadeuriApiModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// HTTP 요청을 보내고 응답을 받아, 응답 본문의 데이터를 파싱.
  ///
  /// [requestMethod]는 응답 오류 시, 오류 정보 파싱을 위해 사용됨.
  ///
  /// 클래스에 선언된 [Dio] 객체의 HTTP 메서드를 [dioRequest] 콜백으로 전달하여 사용.
  ///
  /// 요청 성공 시 JSON 본문 [data] 키에 담긴 값을 파싱하기 위해 [parser]를 지정할 수 있음.
  /// 받을 데이터가 없는 경우 [parser]를 [null]로, 제네릭 [T]를 [void]로 지정해야함.
  Future<Result<T>> _requestAndParse<T>(
    RequestMethod requestMethod,
    Future<Response> Function() dioRequest,
    T Function(dynamic data)? parser,
  ) async {
    try {
      final Response response = await dioRequest();

      final int statusCode = response.statusCode!;
      final Map<String, dynamic> body = response.data as Map<String, dynamic>;
      final String message = body["message"];
      final dynamic data = body["data"];
      log("응답 요약 (${requestMethod.name}): (StatusCode: $statusCode, Message: $message)", name: _logTag);

      final T? result = parser != null ? parser(data) : null;

      return Result.ok(result as T);
    } on DioException catch (e) {
      log("처리된 예외 발생 (${requestMethod.name})", name: _logTag);
      log("예외 정보 (${requestMethod.name}): $e", name: _logTag);
      return _handleOnDioException(e, requestMethod);
    } catch (e, s) {
      log("처리되지 않은 예외 발생 (${requestMethod.name})", name: _logTag);
      log("예외 정보 (${requestMethod.name}): $e", name: _logTag);
      log("Stack trace (${requestMethod.name}): $s", name: _logTag);
      return Result.error(ApiError.unknownError());
    }
  }

  Result<T> _handleOnDioException<T>(DioException e, RequestMethod requestMethod) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return Result.error(ApiError.requestTimeout());
    }

    final exception = e.error;
    if (exception is TokenNotFound) {
      return Result.error(LocalError.tokenNotFound(tokenType: exception.tokenType));
    }

    final Response? response = e.response;
    if (response == null) {
      return Result.error(ApiError.unknownError());
    }

    final int statusCode = response.statusCode!;
    final dynamic body = response.data;
    final String? message = body["message"];
    log("응답 메시지 (${requestMethod.name}): $message", name: _logTag);

    Map<String, dynamic> data;
    if (statusCode == HttpStatus.unprocessableEntity) {
      // 요청 본문 Validation 오류인 경우 [info] 키로 한번 더 감싸서 파싱
      data = {"info": body["data"]};
    } else {
      data = body["data"] ?? <String, dynamic>{};
    }

    data["runtimeType"] = switch (requestMethod) {
      RequestMethod.signUp => switch (statusCode) {
        HttpStatus.conflict => "duplicateEmail",
        HttpStatus.unprocessableEntity => "validationError",
        _ => "unknownError",
      },
      RequestMethod.getMyProfile => switch (statusCode) {
        HttpStatus.unauthorized => "unauthorized",
        _ => "unknownError",
      },
      RequestMethod.signIn => switch (statusCode) {
        HttpStatus.unauthorized => "unauthorized",
        HttpStatus.unprocessableEntity => "validationError",
        _ => "unknownError",
      },
      RequestMethod.postNadeuri => switch (statusCode) {
        HttpStatus.unauthorized => "unauthorized",
        HttpStatus.unprocessableEntity => "validationError",
        _ => "unknownError",
      },
      RequestMethod.getNadeuri => switch (statusCode) {
        HttpStatus.unauthorized => "unauthorized",
        HttpStatus.notFound => "notFound",
        _ => "unknownError",
      },
      RequestMethod.getParticipatingNadeuris => switch (statusCode) {
        HttpStatus.unauthorized => "unauthorized",
        _ => "unknownError",
      },
      RequestMethod.putNadeuri => switch (statusCode) {
        HttpStatus.unauthorized => "unauthorized",
        HttpStatus.notFound => "notFound",
        HttpStatus.unprocessableEntity => "validationError",
        _ => "unknownError",
      },
    };
    final ApiError apiError = ApiError.fromJson(data);
    return Result.error(apiError);
  }
}
