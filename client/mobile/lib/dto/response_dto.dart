import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_dto.freezed.dart';
part 'response_dto.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class ResponseDto<T> with _$ResponseDto<T> {
  const factory ResponseDto({required String message, T? data}) = _ResponseDto;

  factory ResponseDto.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$ResponseDtoFromJson(json, fromJsonT);

  static Map<String, List<String>>? dataFromFieldValidationError(Object? data) {
    final dataWip = Map<String, dynamic>.from(data as Map);
    return dataWip.map((k, v) => MapEntry(k, List<String>.from(v as List)));
  }

  static Map<String, String>? dataFromTokens(Object? data) {
    return Map<String, String>.from(data as Map);
  }
}
