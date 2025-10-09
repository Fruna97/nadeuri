import 'dart:developer';

import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/data/service/model/sign_up_response/sign_up_response.dart';
import 'package:mobile/result.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository({required ApiClient apiClient}) : _apiClient = apiClient;

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
          case RequestTimeout _:
            log("Result is RequestTimeout");
          case DuplicateEmailError _:
            log("Result is DuplicateEmailError");
          case ValidationError _:
            log("Result is ValidationError: $error");
          case UnknownError _:
            log("Result is UnknownError");
        }
    }
    return result;
  }
}
