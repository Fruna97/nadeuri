import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/data/service/model/sign_up_response/sign_up_response.dart';
import 'package:mobile/result.dart';

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

  Future<Result<SignUpResponse>> signUp(SignUpRequest signUpRequest) async {
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
      return Result.error(SignUpResponse.unknownError());
    }

    final int statusCode = response.statusCode;
    final dynamic decodedBody = jsonDecode(response.body);
    final String? message = decodedBody["message"];
    Map<String, dynamic>? data = decodedBody["data"];
    log("Response summary (StatusCode: $statusCode, Message: $message)");

    data ??= <String, dynamic>{};
    data["runtimeType"] = switch (statusCode) {
      HttpStatus.ok => "registered",
      HttpStatus.requestTimeout => "requestTimeoutError",
      HttpStatus.conflict => "duplicateEmailError",
      HttpStatus.unprocessableEntity => "validationError",
      _ => "unknownError",
    };
    final SignUpResponse signUpResponse = SignUpResponse.fromJson(data);

    if (signUpResponse is Registered) {
      return Result.ok(signUpResponse);
    } else {
      return Result.error(signUpResponse);
    }
  }
}
