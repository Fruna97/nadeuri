import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan.freezed.dart';
part 'plan.g.dart';

@freezed
abstract class Plan with _$Plan {
  const factory Plan({
    String? uuid,
    required String title,
    String? googlePlacesId,
    required bool allDay,
    required DateTime startAt,
    required DateTime endAt,
    required String nadeuriUuid,
  }) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}
