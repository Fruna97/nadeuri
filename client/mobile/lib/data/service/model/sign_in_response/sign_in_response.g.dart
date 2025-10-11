// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authenticated _$AuthenticatedFromJson(Map<String, dynamic> json) =>
    Authenticated(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$AuthenticatedToJson(Authenticated instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'runtimeType': instance.$type,
    };

UnAuthorized _$UnAuthorizedFromJson(Map<String, dynamic> json) =>
    UnAuthorized($type: json['runtimeType'] as String?);

Map<String, dynamic> _$UnAuthorizedToJson(UnAuthorized instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

RequestTimeout _$RequestTimeoutFromJson(Map<String, dynamic> json) =>
    RequestTimeout($type: json['runtimeType'] as String?);

Map<String, dynamic> _$RequestTimeoutToJson(RequestTimeout instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

ValidationError _$ValidationErrorFromJson(Map<String, dynamic> json) =>
    ValidationError(
      email: (json['email'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      password: (json['password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'runtimeType': instance.$type,
    };

UnknownError _$UnknownErrorFromJson(Map<String, dynamic> json) =>
    UnknownError($type: json['runtimeType'] as String?);

Map<String, dynamic> _$UnknownErrorToJson(UnknownError instance) =>
    <String, dynamic>{'runtimeType': instance.$type};
