// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Member _$MemberFromJson(Map<String, dynamic> json) => _Member(
  uuid: json['uuid'] as String,
  email: json['email'] as String,
  nickname: json['nickname'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$MemberToJson(_Member instance) => <String, dynamic>{
  'uuid': instance.uuid,
  'email': instance.email,
  'nickname': instance.nickname,
  'profileImageUrl': instance.profileImageUrl,
};
