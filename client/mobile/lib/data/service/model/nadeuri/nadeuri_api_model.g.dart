// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nadeuri_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NadeuriApiModel _$NadeuriApiModelFromJson(Map<String, dynamic> json) =>
    _NadeuriApiModel(
      uuid: json['uuid'] as String?,
      title: json['title'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => MemberApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NadeuriApiModelToJson(_NadeuriApiModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'members': instance.members,
    };
