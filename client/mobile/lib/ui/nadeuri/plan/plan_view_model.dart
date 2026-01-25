import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/repository/nadeuri_repository.dart';
import 'package:mobile/domain/model/plan/plan.dart';
import 'package:mobile/utils/command.dart';
import 'package:mobile/utils/result.dart';

class PlanViewModel extends ChangeNotifier {
  final String _logTag = "PlanViewModel";

  final bool _isNewPlan;

  final NadeuriRepository _nadeuriRepository;

  late final Command0 createPlan;
  late final Command0 updatePlan;

  Plan _plan;

  PlanViewModel.create({required NadeuriRepository nadeuriRepository, required String nadeuriUuid})
    : _isNewPlan = true,
      _nadeuriRepository = nadeuriRepository,
      _plan = Plan(
        title: "",
        allDay: false,
        startAt: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour + 1),
        endAt: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour + 2),
        nadeuriUuid: nadeuriUuid,
      ) {
    createPlan = Command0(_createPlan);
    updatePlan = Command0(_updatePlan);
  }

  PlanViewModel.edit({required NadeuriRepository nadeuriRepository, required Plan plan})
    : _isNewPlan = false,
      _nadeuriRepository = nadeuriRepository,
      _plan = plan {
    createPlan = Command0(_createPlan);
    updatePlan = Command0(_updatePlan);
  }

  bool get isNewPlan => _isNewPlan;
  Plan get plan => _plan;
  Command0 get command => _isNewPlan ? createPlan : updatePlan;

  Future<Result> _createPlan() async {
    Result<Plan> result = await _nadeuriRepository.createPlan(plan);

    switch (result) {
      case Ok<Plan> _:
        log("Plan 생성 성공", name: _logTag);
      case Error<Plan> _:
        log("Plan 생성 실패", name: _logTag);
    }
    return result;
  }

  Future<Result> _updatePlan() async {
    Result<Plan> result = await _nadeuriRepository.updatePlan(plan);

    switch (result) {
      case Ok<Plan> _:
        log("Plan 갱신 성공", name: _logTag);
      case Error<Plan> _:
        log("Plan 갱신 실패", name: _logTag);
    }
    return result;
  }

  void updateTitle(String newTitle) {
    _plan = _plan.copyWith(title: newTitle);

    notifyListeners();
  }

  void updateGooglePlacesId(String? newGooglePlacesId) {
    _plan = _plan.copyWith(googlePlacesId: newGooglePlacesId);

    notifyListeners();
  }

  void updateLatitude(double? newLatitude) {
    _plan = _plan.copyWith(latitude: newLatitude);

    notifyListeners();
  }

  void updateLongitude(double? newLongitude) {
    _plan = _plan.copyWith(longitude: newLongitude);

    notifyListeners();
  }

  void updateAllDay(bool newAllDay) {
    _plan = _plan.copyWith(allDay: newAllDay);

    notifyListeners();
  }

  void updateStartAt(DateTime newStartAt) {
    if (_plan.endAt.isBefore(newStartAt) || _plan.endAt.isAtSameMomentAs(newStartAt)) {
      _plan = _plan.copyWith(startAt: newStartAt, endAt: newStartAt.add(const Duration(hours: 1)));
    } else {
      _plan = _plan.copyWith(startAt: newStartAt);
    }

    notifyListeners();
  }

  void updateEndAt(DateTime newEndAt) {
    if (newEndAt.isBefore(_plan.startAt) || newEndAt.isAtSameMomentAs(_plan.startAt)) {
      _plan = _plan.copyWith(startAt: newEndAt.subtract(const Duration(hours: 1)), endAt: newEndAt);
    } else {
      _plan = _plan.copyWith(endAt: newEndAt);
    }

    notifyListeners();
  }
}
