import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_response.freezed.dart';
part 'sign_in_response.g.dart';

@freezed
abstract class SignInResponse with _$SignInResponse {
  const factory SignInResponse({
    required String accessToken,
    required String refreshToken
  }) = _SignInResponse;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);
}
