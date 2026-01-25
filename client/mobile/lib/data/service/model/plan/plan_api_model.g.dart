// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanApiModel _$PlanApiModelFromJson(Map<String, dynamic> json) =>
    _PlanApiModel(
      uuid: json['uuid'] as String?,
      title: json['title'] as String,
      googlePlacesId: json['googlePlacesId'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      allDay: json['allDay'] as bool,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      nadeuriUuid: json['nadeuriUuid'] as String,
    );

Map<String, dynamic> _$PlanApiModelToJson(_PlanApiModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'googlePlacesId': instance.googlePlacesId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'allDay': instance.allDay,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'nadeuriUuid': instance.nadeuriUuid,
    };
