import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/domain/model/place/place.dart';

part 'place_dto.freezed.dart';
part 'place_dto.g.dart';

@freezed
abstract class PlaceDto with _$PlaceDto {
  const PlaceDto._();

  const factory PlaceDto({
    required String id,
    String? displayName,
    String? formattedAddress,
    required double latitude,
    required double longitude,
    String? primaryTypeDisplayName
  }) = _PlaceDto;

  factory PlaceDto.fromJson(Map<String, dynamic> json) => _$PlaceDtoFromJson(json);

  Place toPlace() {
    return Place(
      id: id,
      displayName: displayName,
      formattedAddress: formattedAddress,
      latitude: latitude,
      longitude: longitude,
      primaryTypeDisplayName: primaryTypeDisplayName
    );
  }
}
