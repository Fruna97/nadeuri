import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
abstract class ApiError with _$ApiError implements Exception {
  const factory ApiError.unauthorized() = Unauthorized;

  const factory ApiError.requestTimeout() = RequestTimeout;

  const factory ApiError.duplicateEmail() = DuplicateEmail;

  const factory ApiError.validationError({
    required Map<String, List<String>> info
  }) = ValidationError;

  const factory ApiError.unknownError() = UnknownError;

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);
}