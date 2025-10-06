import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_response.freezed.dart';
part 'sign_up_response.g.dart';

@freezed
abstract class SignUpResponse with _$SignUpResponse {
  const factory SignUpResponse.registered() = Registered;

  const factory SignUpResponse.validationError({
    required List<String>? email,
    required List<String>? password,
    required List<String>? nickname,
  }) = ValidationError;

  const factory SignUpResponse.duplicateEmailError() = DuplicateEmailError;

  const factory SignUpResponse.unknownError() = UnknownError;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);
}
