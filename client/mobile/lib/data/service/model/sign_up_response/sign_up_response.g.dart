// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registered _$RegisteredFromJson(Map<String, dynamic> json) =>
    Registered($type: json['runtimeType'] as String?);

Map<String, dynamic> _$RegisteredToJson(Registered instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

RequestTimeout _$RequestTimeoutFromJson(Map<String, dynamic> json) =>
    RequestTimeout($type: json['runtimeType'] as String?);

Map<String, dynamic> _$RequestTimeoutToJson(RequestTimeout instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

DuplicateEmailError _$DuplicateEmailErrorFromJson(Map<String, dynamic> json) =>
    DuplicateEmailError($type: json['runtimeType'] as String?);

Map<String, dynamic> _$DuplicateEmailErrorToJson(
  DuplicateEmailError instance,
) => <String, dynamic>{'runtimeType': instance.$type};

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
