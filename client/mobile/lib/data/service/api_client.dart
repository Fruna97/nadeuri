import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/sign_in_request/sign_in_request.dart';
import 'package:mobile/data/service/model/sign_in_response/sign_in_response.dart';
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/utils/result.dart';

enum RequestMethod { signUp, signIn }

class ApiClient {
  final FlutterSecureStorage _flutterSecureStorage;
  late final Dio _dioWithoutToken;

  final Duration connectTimeout = Duration(seconds: 5);
  final Duration receiveTimeout = Duration(seconds: 5);

  ApiClient({
    required String host,
    required int port,
    required Map<String, String> baseHeaders,
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage {
    _dioWithoutToken = Dio(
      BaseOptions(
        baseUrl: "$host:$port",
        headers: baseHeaders,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      ),
    );
  }

  Future<Result<void>> signUp(SignUpRequest signUpRequest) async {
    final String endpoint = "/member/signup";
    try {
      final Response response = await _dioWithoutToken.post(endpoint, data: signUpRequest.toJson());
      final int statusCode = response.statusCode!;
      final dynamic body = response.data;
      final String? message = body["message"];
      log("${RequestMethod.signUp.name} response summary (StatusCode: $statusCode, Message: $message)");

      return Result.ok(null);
    } on DioException catch (e) {
      return _handleOnDioException<void>(e, RequestMethod.signUp);
    } catch (e) {
      log(e.toString());
      return Result.error(ApiError.unknownError());
    }
  }

  Future<Result<SignInResponse>> signIn(SignInRequest signInRequest) async {
    final String endpoint = "/member/signin";
    try {
      final Response response = await _dioWithoutToken.post(endpoint, data: signInRequest.toJson());
      final int statusCode = response.statusCode!;
      final dynamic body = response.data;
      final String? message = body["message"];
      log("${RequestMethod.signIn.name} response summary (StatusCode: $statusCode, Message: $message)");

      final Map<String, dynamic> data = body["data"];
      final SignInResponse signInResponse = SignInResponse.fromJson(data);
      return Result.ok(signInResponse);
    } on DioException catch (e) {
      return _handleOnDioException<SignInResponse>(e, RequestMethod.signIn);
    } catch (e) {
      log(e.toString());
      return Result.error(ApiError.unknownError());
    }
  }

  Result<T> _handleOnDioException<T>(DioException e, RequestMethod requestMethod) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return Result.error(ApiError.requestTimeout());
    }

    final Response? response = e.response;
    if (response == null) {
      return Result.error(ApiError.unknownError());
    }

    final int statusCode = response.statusCode!;
    final dynamic body = response.data;
    final String? message = body["message"];
    log("${requestMethod.name} response summary (StatusCode: $statusCode, Message: $message)");

    Map<String, dynamic>? data = body["data"];
    data ??= <String, dynamic>{};

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
    }
    final ApiError apiError = ApiError.fromJson(data);
    return Result.error(apiError);
  }
}
