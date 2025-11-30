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
    required String planTitle,
    String? googlePlacesId,
    double? latitude,
    double? longitude,
    required DateTime startAt,
    required DateTime endAt,
    required String nadeuriUuid,
  }) = _PlanApiModel;

  factory PlanApiModel.fromJson(Map<String, dynamic> json) => _$PlanApiModelFromJson(json);

  static PlanApiModel fromPlan(Plan plan) {
    return PlanApiModel(
      uuid: plan.uuid,
      planTitle: plan.planTitle,
      googlePlacesId: plan.googlePlacesId,
      latitude: plan.latitude,
      longitude: plan.longitude,
      startAt: plan.startAt,
      endAt: plan.endAt,
      nadeuriUuid: plan.nadeuriUuid,
    );
  }

  Plan toPlan() {
    return Plan(
      uuid: uuid,
      planTitle: planTitle,
      googlePlacesId: googlePlacesId,
      latitude: latitude,
      longitude: longitude,
      startAt: startAt,
      endAt: endAt,
      nadeuriUuid: nadeuriUuid,
    );
  }
}
