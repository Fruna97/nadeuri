import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/sign_in_request/sign_in_request.dart';
import 'package:mobile/data/service/model/token/token_api_model.dart';
import 'package:mobile/utils/result.dart';

class AuthRepository {
  final String _logTag = "AuthRepository";

  final ApiClient _apiClient;
  final FlutterSecureStorage _flutterSecureStorage;

  AuthRepository({required ApiClient apiClient, required FlutterSecureStorage flutterSecureStorage})
    : _apiClient = apiClient,
      _flutterSecureStorage = flutterSecureStorage;

  Future<Result<void>> signIn({required String email, required String password}) async {
    SignInRequest signInRequest = SignInRequest(email: email, password: password);

    final Result<TokenApiModel> result = await _apiClient.signIn(signInRequest);
    switch (result) {
      case Ok<TokenApiModel> _:
        log("Result is Ok", name: _logTag);
        TokenApiModel value = result.value;
        await _flutterSecureStorage.write(key: "access_token", value: value.accessToken);
        await _flutterSecureStorage.write(key: "refresh_token", value: value.refreshToken);
        log("Access Token, Refresh Token 저장 완료", name: _logTag);
      case Error<TokenApiModel> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is Unauthorized", name: _logTag);
          case RequestTimeout _:
            log("Result is RequestTimeout", name: _logTag);
          case ValidationError _:
            log("Result is ValidationError: $error", name: _logTag);
          case UnknownError _:
            log("Result is UnknownError", name: _logTag);
        }
    }
    return result;
  }
}
