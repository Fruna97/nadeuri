// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nadeuri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Nadeuri _$NadeuriFromJson(Map<String, dynamic> json) => _Nadeuri(
  title: json['title'] as String?,
  members: (json['members'] as List<dynamic>?)
      ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NadeuriToJson(_Nadeuri instance) => <String, dynamic>{
  'title': instance.title,
  'members': instance.members,
};
