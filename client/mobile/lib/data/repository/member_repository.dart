import 'dart:developer';

import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/data/service/model/member/member_api_model.dart';
import 'package:mobile/data/service/model/sign_up_request/sign_up_request.dart';
import 'package:mobile/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberRepository {
  final String _logTag = "MemberRepository";

  final ApiClient _apiClient;
  final SharedPreferencesWithCache _prefsWithCache;

  MemberRepository({required ApiClient apiClient, required SharedPreferencesWithCache prefsWithCache})
    : _apiClient = apiClient,
      _prefsWithCache = prefsWithCache;

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

  Future<Result<void>> getMyProfile() async {
    final Result<MemberApiModel> result = await _apiClient.getMyProfile();
    switch (result) {
      case Ok<MemberApiModel> _:
        log("Result is Ok", name: _logTag);
        await _prefsWithCache.setString("profile.email", result.value.email);
        await _prefsWithCache.setString("profile.nickname", result.value.nickname ?? "");
        await _prefsWithCache.setString("profile.profileImgUrl", result.value.profileImageUrl ?? "");
        log("Profile 저장 완료", name: _logTag);
      case Error<MemberApiModel> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is Unauthorized", name: _logTag);
          case RequestTimeout _:
            log("Result is RequestTimeout", name: _logTag);
          case UnknownError _:
            log("Result is UnknownError", name: _logTag);
          case TokenNotFound _:
            log("Result is TokenNotFound", name: _logTag);
        }
    }

    return Result.ok(null);
  }
}
