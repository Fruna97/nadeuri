import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/domain/model/plan/plan.dart';

part 'plan_api_model.freezed.dart';
part 'plan_api_model.g.dart';

@freezed
abstract class PlanApiModel with _$PlanApiModel {
  const PlanApiModel._();

  const factory PlanApiModel({
    String? uuid,
    required String title,
    String? googlePlacesId,
    required bool allDay,
    required DateTime startAt,
    required DateTime endAt,
    required String nadeuriUuid,
  }) = _PlanApiModel;

  factory PlanApiModel.fromJson(Map<String, dynamic> json) => _$PlanApiModelFromJson(json);

  static PlanApiModel fromPlan(Plan plan) {
    return PlanApiModel(
      uuid: plan.uuid,
      title: plan.title,
      googlePlacesId: plan.googlePlacesId,
      allDay: plan.allDay,
      startAt: plan.startAt,
      endAt: plan.endAt,
      nadeuriUuid: plan.nadeuriUuid,
    );
  }

  Plan toPlan() {
    return Plan(
      uuid: uuid,
      title: title,
      googlePlacesId: googlePlacesId,
      allDay: allDay,
      startAt: startAt,
      endAt: endAt,
      nadeuriUuid: nadeuriUuid,
    );
  }
}
