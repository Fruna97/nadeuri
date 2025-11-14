// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenApiModel _$TokenApiModelFromJson(Map<String, dynamic> json) =>
    _TokenApiModel(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$TokenApiModelToJson(_TokenApiModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
