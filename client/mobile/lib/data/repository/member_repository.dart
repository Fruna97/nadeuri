import 'dart:developer';

import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/utils/result.dart';

class MemberRepository {
  final String _logTag = "MemberRepository";

  final ApiClient _apiClient;

  MemberRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<void>> signUp({required String email, required String password, required String nickname}) async {
    SignUpRequest signUpRequest = SignUpRequest(email: email, password: password, nickname: nickname);

    final Result<void> result = await _apiClient.signUp(signUpRequest);
    switch (result) {
      case Ok _:
        log("Result is Ok", name: _logTag);
      case Error _:
        Exception error = result.error;
        switch (error) {
          case RequestTimeout _:
            log("Result is RequestTimeout", name: _logTag);
          case DuplicateEmail _:
            log("Result is DuplicateEmail", name: _logTag);
          case ValidationError _:
            log("Result is ValidationError: $error", name: _logTag);
          case UnknownError _:
            log("Result is UnknownError", name: _logTag);
        }
    }
    return result;
  }
}
