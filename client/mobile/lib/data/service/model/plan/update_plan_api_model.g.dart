// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_plan_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdatePlanApiModel _$UpdatePlanApiModelFromJson(Map<String, dynamic> json) =>
    _UpdatePlanApiModel(
      title: json['title'] as String,
      googlePlacesId: json['googlePlacesId'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
    );

Map<String, dynamic> _$UpdatePlanApiModelToJson(_UpdatePlanApiModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'googlePlacesId': instance.googlePlacesId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
    };
