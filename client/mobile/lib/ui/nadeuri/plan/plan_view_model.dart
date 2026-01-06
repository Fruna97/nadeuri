import 'package:flutter/foundation.dart';
import 'package:mobile/domain/model/plan/plan.dart';

class PlanViewModel extends ChangeNotifier {
  final bool _isNew;
  Plan _plan;

  PlanViewModel.create()
    : _isNew = true,
      _plan = Plan(
        title: "",
        startAt: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour + 1),
        endAt: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour + 2),
        nadeuriUuid: "",
      );

  PlanViewModel.edit({required Plan plan}) : _isNew = false, _plan = plan;

  bool get isNewPlan => _isNew;
  Plan get plan => _plan;

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
