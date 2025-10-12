// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unauthorized _$UnauthorizedFromJson(Map<String, dynamic> json) =>
    Unauthorized($type: json['runtimeType'] as String?);

Map<String, dynamic> _$UnauthorizedToJson(Unauthorized instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

RequestTimeout _$RequestTimeoutFromJson(Map<String, dynamic> json) =>
    RequestTimeout($type: json['runtimeType'] as String?);

Map<String, dynamic> _$RequestTimeoutToJson(RequestTimeout instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

DuplicateEmail _$DuplicateEmailFromJson(Map<String, dynamic> json) =>
    DuplicateEmail($type: json['runtimeType'] as String?);

Map<String, dynamic> _$DuplicateEmailToJson(DuplicateEmail instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

ValidationError _$ValidationErrorFromJson(Map<String, dynamic> json) =>
    ValidationError(
      email: (json['email'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      password: (json['password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      nickname: (json['nickname'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'nickname': instance.nickname,
      'runtimeType': instance.$type,
    };

UnknownError _$UnknownErrorFromJson(Map<String, dynamic> json) =>
    UnknownError($type: json['runtimeType'] as String?);

Map<String, dynamic> _$UnknownErrorToJson(UnknownError instance) =>
    <String, dynamic>{'runtimeType': instance.$type};
