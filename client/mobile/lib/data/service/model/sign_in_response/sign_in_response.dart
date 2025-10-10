import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_response.freezed.dart';
part 'sign_in_response.g.dart';

@freezed
abstract class SignInResponse with _$SignInResponse {
  const factory SignInResponse.authenticated({
    required String accessToken,
    required String refreshToken
  }) = Authenticated;

  const factory SignInResponse.unAuthorized() = UnAuthorized;

  const factory SignInResponse.requestTimeoutError() = RequestTimeout;

  const factory SignInResponse.validationError({
    required List<String>? email,
    required List<String>? password,
  }) = ValidationError;

  const factory SignInResponse.unknownError() = UnknownError;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);
}
