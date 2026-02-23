// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceDto _$PlaceDtoFromJson(Map<String, dynamic> json) => _PlaceDto(
  id: json['id'] as String,
  displayName: json['displayName'] as String?,
  formattedAddress: json['formattedAddress'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  primaryTypeDisplayName: json['primaryTypeDisplayName'] as String?,
);

Map<String, dynamic> _$PlaceDtoToJson(_PlaceDto instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'formattedAddress': instance.formattedAddress,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'primaryTypeDisplayName': instance.primaryTypeDisplayName,
};
