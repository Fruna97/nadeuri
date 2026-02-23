import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_dto.freezed.dart';
part 'place_dto.g.dart';

@freezed
abstract class PlaceDto with _$PlaceDto {
  const factory PlaceDto({
    required String id,
    String? displayName,
    String? formattedAddress,
    required double latitude,
    required double longitude,
    String? primaryTypeDisplayName
  }) = _PlaceDto;

  factory PlaceDto.fromJson(Map<String, dynamic> json) => _$PlaceDtoFromJson(json);
}
