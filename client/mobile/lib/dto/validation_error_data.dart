import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_error_data.freezed.dart';
part 'validation_error_data.g.dart';

@freezed
abstract class ValidationErrorData with _$ValidationErrorData {
  const factory ValidationErrorData({
    List<String>? email, 
    List<String>? password, 
    List<String>? nickname
  }) = _ValidationErrorData;

  factory ValidationErrorData.fromJson(Map<String, dynamic> json) => _$ValidationErrorDataFromJson(json);
}
