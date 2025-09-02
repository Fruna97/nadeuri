// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ValidationErrorData _$ValidationErrorDataFromJson(
  Map<String, dynamic> json,
) => _ValidationErrorData(
  email: (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
  password:
      (json['password'] as List<dynamic>?)?.map((e) => e as String).toList(),
  nickname:
      (json['nickname'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ValidationErrorDataToJson(
  _ValidationErrorData instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'nickname': instance.nickname,
};
