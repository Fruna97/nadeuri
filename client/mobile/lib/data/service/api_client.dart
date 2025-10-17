import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/service/interceptor/token_interceptor.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/data/service/model/nadeuri/nadeuri_api_model.dart';
import 'package:mobile/data/service/model/sign_in_request/sign_in_request.dart';
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/data/service/model/token/token_api_model.dart';
import 'package:mobile/utils/result.dart';

enum RequestMethod { signUp, signIn, getParticipatingNadeuris, postNadeuri }

class ApiClient {
  final String _logTag = "ApiClient";
  final Duration connectTimeout = Duration(seconds: 5);
  final Duration receiveTimeout = Duration(seconds: 5);

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
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
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
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      ),
    )..interceptors.add(tokenInterceptor);
  }

  Future<Result<void>> signUp(SignUpRequest signUpRequest) async {
    final String endpoint = "/member/signup";
    try {
      final Response response = await _dioWithoutToken.post(endpoint, data: signUpRequest.toJson());
      final int statusCode = response.statusCode!;
      final dynamic body = response.data;
      final String? message = body["message"];
      log("${RequestMethod.signUp.name} response summary (StatusCode: $statusCode, Message: $message)", name: _logTag);

      return Result.ok(null);
    } on DioException catch (e) {
      log("Handled Exception (${RequestMethod.signUp.name}): $e", name: _logTag);
      return _handleOnDioException<void>(e, RequestMethod.signUp);
    } catch (e, s) {
      log("Unhandled Exception (${RequestMethod.signUp.name}): $e\n$s", name: _logTag);
      return Result.error(ApiError.unknownError());
    }
  }

  Future<Result<TokenApiModel>> signIn(SignInRequest signInRequest) async {
    final String endpoint = "/member/signin";
    try {
      final Response response = await _dioWithoutToken.post(endpoint, data: signInRequest.toJson());
      final int statusCode = response.statusCode!;
      final dynamic body = response.data;
      final String? message = body["message"];
      log("${RequestMethod.signIn.name} response summary (StatusCode: $statusCode, Message: $message)", name: _logTag);

      final Map<String, dynamic> data = body["data"];
      final TokenApiModel signInResponse = TokenApiModel.fromJson(data);
      return Result.ok(signInResponse);
    } on DioException catch (e) {
      log("Handled Exception (${RequestMethod.signIn.name}): $e", name: _logTag);
      return _handleOnDioException<TokenApiModel>(e, RequestMethod.signIn);
    } catch (e, s) {
      log("Unhandled Exception (${RequestMethod.signIn.name}): $e\n$s", name: _logTag);
      return Result.error(ApiError.unknownError());
    }
  }

  Future<Result<List<NadeuriApiModel>>> getParticipatingNadeuris() async {
    final String endpoint = "/nadeuri/participating";
    try {
      final Response response = await _dioWithToken.get(endpoint);
      final int statusCode = response.statusCode!;
      final dynamic body = response.data;
      final String? message = body["message"];
      log(
        "${RequestMethod.getParticipatingNadeuris.name} response summary (StatusCode: $statusCode, Message: $message)",
        name: _logTag,
      );

      final List<dynamic> data = body["data"];
      final List<NadeuriApiModel> nadeuriApiModels = data
          .cast<Map<String, dynamic>>()
          .map((nadeuriApiModel) => NadeuriApiModel.fromJson(nadeuriApiModel))
          .toList();
      return Result.ok(nadeuriApiModels);
    } on DioException catch (e) {
      log("Handled Exception (${RequestMethod.getParticipatingNadeuris.name}): $e", name: _logTag);
      return _handleOnDioException<List<NadeuriApiModel>>(e, RequestMethod.getParticipatingNadeuris);
    } catch (e, s) {
      log("Unhandled Exception (${RequestMethod.getParticipatingNadeuris.name}): $e\n$s", name: _logTag);
      return Result.error(ApiError.unknownError());
    }
  }

  Future<Result<void>> postNadeuri(NadeuriApiModel nadeuriApiModel) async {
    final String endpoint = "/nadeuri";
    try {
      final Response response = await _dioWithToken.post(endpoint, data: nadeuriApiModel.toJson());
      final int statusCode = response.statusCode!;
      final dynamic body = response.data;
      final String? message = body["message"];
      log(
        "${RequestMethod.postNadeuri.name} response summary (StatusCode: $statusCode, Message: $message)",
        name: _logTag,
      );
      return Result.ok(null);
    } on DioException catch (e) {
      log("Handled Exception (${RequestMethod.postNadeuri.name}): $e", name: _logTag);
      return _handleOnDioException(e, RequestMethod.postNadeuri);
    } catch (e, s) {
      log("Unhandled Exception (${RequestMethod.postNadeuri.name}): $e\n$s", name: _logTag);
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

    Map<String, dynamic> data;
    if (statusCode == HttpStatus.unprocessableEntity) {
      data = {"info": body["data"]};
    } else {
      data = body["data"] ?? <String, dynamic>{};
    }

    switch (requestMethod) {
      case RequestMethod.signUp:
        data["runtimeType"] = switch (statusCode) {
          HttpStatus.conflict => "duplicateEmail",
          HttpStatus.unprocessableEntity => "validationError",
          _ => "unknownError",
        };
      case RequestMethod.signIn:
        data["runtimeType"] = switch (statusCode) {
          HttpStatus.unauthorized => "unauthorized",
          HttpStatus.unprocessableEntity => "validationError",
          _ => "unknownError",
        };
      case RequestMethod.getParticipatingNadeuris:
        data["runtimeType"] = switch (statusCode) {
          HttpStatus.unauthorized => "unauthorized",
          _ => "unknownError",
        };
      case RequestMethod.postNadeuri:
        data["runtimeType"] = switch (statusCode) {
          HttpStatus.unauthorized => "unauthorized",
          HttpStatus.unprocessableEntity => "validationError",
          _ => "unknownError",
        };
        break;
    }
    final ApiError apiError = ApiError.fromJson(data);
    return Result.error(apiError);
  }
}
