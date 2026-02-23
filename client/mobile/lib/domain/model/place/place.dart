import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.freezed.dart';

@freezed
abstract class Place with _$Place {
  const factory Place({
    required String id,
    String? displayName,
    String? formattedAddress,
    required double latitude,
    required double longitude,
    String? primaryTypeDisplayName
  }) = _Place;
}