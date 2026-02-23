import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/domain/model/plan/plan.dart';

part 'update_plan_api_model.freezed.dart';
part 'update_plan_api_model.g.dart';

@freezed
abstract class UpdatePlanApiModel with _$UpdatePlanApiModel {
  const UpdatePlanApiModel._();

  const factory UpdatePlanApiModel({
    required String title,
    String? googlePlacesId,
    required bool allDay,
    required DateTime startAt,
    required DateTime endAt,
  }) = _UpdatePlanApiModel;

  factory UpdatePlanApiModel.fromJson(Map<String, dynamic> json) => _$UpdatePlanApiModelFromJson(json);

  static UpdatePlanApiModel fromPlan(Plan plan) {
    return UpdatePlanApiModel(
      title: plan.title,
      googlePlacesId: plan.googlePlacesId,
      allDay: plan.allDay,
      startAt: plan.startAt,
      endAt: plan.endAt,
    );
  }
}
