import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/sign_in_request/sign_in_request.dart';
import 'package:mobile/data/service/model/sign_in_response/sign_in_response.dart';
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/utils/result.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final FlutterSecureStorage _flutterSecureStorage;

  AuthRepository({required ApiClient apiClient, required FlutterSecureStorage flutterSecureStorage})
    : _apiClient = apiClient,
      _flutterSecureStorage = flutterSecureStorage;

  Future<Result<void>> signUp({required String email, required String password, required String nickname}) async {
    SignUpRequest signUpRequest = SignUpRequest(email: email, password: password, nickname: nickname);

    final Result<void> result = await _apiClient.signUp(signUpRequest);
    switch (result) {
      case Ok _:
        log("Result is Ok");
      case Error _:
        Exception error = result.error;
        switch (error) {
          case RequestTimeout _:
            log("Result is RequestTimeout");
          case DuplicateEmail _:
            log("Result is DuplicateEmail");
          case ValidationError _:
            log("Result is ValidationError: $error");
          case UnknownError _:
            log("Result is UnknownError");
        }
    }
    return result;
  }

  Future<Result<SignInResponse>> signIn({required String email, required String password}) async {
    SignInRequest signInRequest = SignInRequest(email: email, password: password);

    final Result<SignInResponse> result = await _apiClient.signIn(signInRequest);
    switch (result) {
      case Ok<SignInResponse> _:
        SignInResponse value = result.value;
        log("Result is Ok: $value");
        await _flutterSecureStorage.write(key: "access_token", value: value.accessToken);
        await _flutterSecureStorage.write(key: "refresh_token", value: value.refreshToken);
      case Error<SignInResponse> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is UnAuthorized");
          case RequestTimeout _:
            log("Result is RequestTimeout");
          case ValidationError _:
            log("Result is ValidationError: $error");
          case UnknownError _:
            log("Result is UnknownError");
        }
    }
    return result;
  }
}
