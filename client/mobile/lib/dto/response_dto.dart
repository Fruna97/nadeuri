import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_dto.freezed.dart';
part 'response_dto.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class ResponseDto<T> with _$ResponseDto<T> {
  const factory ResponseDto({required String message, T? data}) = _ResponseDto;

  factory ResponseDto.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$ResponseDtoFromJson(json, fromJsonT);

  static Map<String, List<String>>? dataFromFieldValidation(Object? data) {
    if (data == null) return null;

    final Map<String, List<String>> deserializedData = <String, List<String>>{};

    if (data is! Map<String, dynamic>) throw FormatException("응답 형식이 유효하지 않습니다");

    for (final entry in data.entries) {
      final (key, value) = (entry.key, entry.value);

      if (value is! List<dynamic>) throw FormatException("응답 형식이 유효하지 않습니다");

      final List<String> messages = <String>[];
      for (final message in value) {
        if (message is! String) throw FormatException("응답 형식이 유효하지 않습니다");

        messages.add(message);
      }
      deserializedData[key] = messages;
    }

    return deserializedData;
  }

  static Map<String, String>? dataFromTokens(Object? data) {
    return Map<String, String>.from(data as Map);
  }
}
