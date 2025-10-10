import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/data/service/model/sign_in_request/sign_in_request.dart';
import 'package:mobile/data/service/model/sign_in_response/sign_in_response.dart';
import 'package:mobile/data/service/model/sign_in_response/sign_in_response.dart' as sign_in_response;
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/data/service/model/sign_up_response/sign_up_response.dart';
import 'package:mobile/data/service/model/sign_up_response/sign_up_response.dart' as sign_up_response;
import 'package:mobile/result.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final FlutterSecureStorage _flutterSecureStorage;

  AuthRepository({required ApiClient apiClient, required FlutterSecureStorage flutterSecureStorage})
    : _apiClient = apiClient,
      _flutterSecureStorage = flutterSecureStorage;

  Future<Result<SignUpResponse>> signUp({
    required String email,
    required String password,
    required String nickname,
  }) async {
    SignUpRequest signUpRequest = SignUpRequest(email: email, password: password, nickname: nickname);

    final Result<SignUpResponse> result = await _apiClient.signUp(signUpRequest);
    switch (result) {
      case Ok<SignUpResponse> _:
        log("Result is Ok");
      case Error<SignUpResponse> _:
        SignUpResponse error = result.error;
        switch (error) {
          case sign_up_response.RequestTimeout _:
            log("Result is RequestTimeout");
          case sign_up_response.DuplicateEmailError _:
            log("Result is DuplicateEmailError");
          case sign_up_response.ValidationError _:
            log("Result is ValidationError: $error");
          case sign_up_response.UnknownError _:
            log("Result is UnknownError");
        }
    }
    return result;
  }

  Future<Result<SignInResponse>> signIn({
    required String email,
    required String password,
  }) async {
    SignInRequest signInRequest = SignInRequest(email: email, password: password);

    final Result<SignInResponse> result = await _apiClient.signIn(signInRequest);
    switch (result) {
      case Ok<SignInResponse> _:
        Authenticated value = result.value as sign_in_response.Authenticated;
        log("Result is Ok: $value");
        await _flutterSecureStorage.write(key: "access_token", value: value.accessToken);
        await _flutterSecureStorage.write(key: "refresh_token", value: value.refreshToken);
      case Error<SignInResponse> _:
        SignInResponse error = result.error;
        switch (error) {
          case sign_in_response.UnAuthorized _:
            log("Result is UnAuthorized");
          case sign_in_response.RequestTimeout _:
            log("Result is RequestTimeout");
          case sign_in_response.ValidationError _:
            log("Result is ValidationError: $error");
          case sign_in_response.UnknownError _:
            log("Result is UnknownError");
        }
    }
    return result;
  }
}
