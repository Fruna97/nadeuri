import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/sign_in_request/sign_in_request.dart';
import 'package:mobile/data/service/model/sign_in_response/sign_in_response.dart';
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/utils/result.dart';

class ApiClient {
  final String _host;
  final int _port;
  final Map<String, String> _baseHeaders;
  final FlutterSecureStorage _flutterSecureStorage;

  ApiClient({
    required String host,
    required int port,
    required Map<String, String> baseHeaders,
    required FlutterSecureStorage flutterSecureStorage,
  }) : _host = host,
       _port = port,
       _baseHeaders = baseHeaders,
       _flutterSecureStorage = flutterSecureStorage;

  Future<Result<void>> signUp(SignUpRequest signUpRequest) async {
    final String endpoint = "/member/signup";
    final http.Response? response;
    try {
      response = await http
          .post(Uri.parse("$_host:$_port$endpoint"), headers: _baseHeaders, body: jsonEncode(signUpRequest.toJson()))
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              return http.Response(
                jsonEncode({"message": "타임아웃", "data": null}),
                HttpStatus.requestTimeout,
                headers: {"content-type": "application/json;charset=UTF-8"},
              );
            },
          );
    } catch (e) {
      log(e.toString());
      return Result.error(ApiError.unknownError());
    }

    final int statusCode = response.statusCode;
    final dynamic decodedBody = jsonDecode(response.body);
    final String? message = decodedBody["message"];
    log("Sign-Up response summary (StatusCode: $statusCode, Message: $message)");

    if (statusCode == HttpStatus.ok) {
      return Result.ok(null);
    }

    Map<String, dynamic>? data = decodedBody["data"];
    data ??= <String, dynamic>{};
    data["runtimeType"] = switch (statusCode) {
      HttpStatus.requestTimeout => "requestTimeout",
      HttpStatus.conflict => "duplicateEmail",
      HttpStatus.unprocessableEntity => "validationError",
      _ => "unknownError",
    };
    final ApiError apiError = ApiError.fromJson(data);
    return Result.error(apiError);
  }

  Future<Result<SignInResponse>> signIn(SignInRequest signInRequest) async {
    final String endpoint = "/member/signin";
    final http.Response? response;
    try {
      response = await http
          .post(Uri.parse("$_host:$_port$endpoint"), headers: _baseHeaders, body: jsonEncode(signInRequest.toJson()))
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              return http.Response(
                jsonEncode({"message": "타임아웃", "data": null}),
                HttpStatus.requestTimeout,
                headers: {"content-type": "application/json;charset=UTF-8"},
              );
            },
          );
    } catch (e) {
      log(e.toString());
      return Result.error(ApiError.unknownError());
    }

    final int statusCode = response.statusCode;
    final dynamic decodedBody = jsonDecode(response.body);
    final String? message = decodedBody["message"];
    log("Sign-In response summary (StatusCode: $statusCode, Message: $message)");

    if (statusCode == HttpStatus.ok) {
      final Map<String, dynamic> data = decodedBody["data"];
      final SignInResponse signInResponse = SignInResponse.fromJson(data);
      return Result.ok(signInResponse);
    }

    Map<String, dynamic>? data = decodedBody["data"];
    data ??= <String, dynamic>{};
    data["runtimeType"] = switch (statusCode) {
      HttpStatus.unauthorized => "unauthorized",
      HttpStatus.requestTimeout => "requestTimeout",
      HttpStatus.unprocessableEntity => "validationError",
      _ => "unknownError",
    };
    final ApiError apiError = ApiError.fromJson(data);
    return Result.error(apiError);
  }
}
