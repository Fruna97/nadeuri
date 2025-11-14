// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberApiModel _$MemberApiModelFromJson(Map<String, dynamic> json) =>
    _MemberApiModel(
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$MemberApiModelToJson(_MemberApiModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'email': instance.email,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
    };
