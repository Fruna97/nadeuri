import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository/nadeuri_repository.dart';
import 'package:mobile/domain/model/place/place.dart';
import 'package:mobile/utils/command.dart';
import 'package:mobile/utils/result.dart';

class SelectPlaceViewModel extends ChangeNotifier {
  final String _logTag = "SelectPlaceViewModel";

  final NadeuriRepository _nadeuriRepository;

  late final Command1<void, (String, double?, double?)> textSearch;

  List<Place> _places = [];

  SelectPlaceViewModel({required NadeuriRepository nadeuriRepository}) : _nadeuriRepository = nadeuriRepository {
    textSearch = Command1<void, (String, double?, double?)>(_textSearch);
  }

  List<Place> get places => _places;

  Future<Result> _textSearch((String textQuery, double? latitude, double? longitude) textSearchRequest) async {
    final (String textQuery, double? latitude, double? longitude) = textSearchRequest;

    _places.clear();

    final Result<List<Place>> result = await _nadeuriRepository.textSearch(textQuery, latitude, longitude);
    switch (result) {
      case Ok<List<Place>> _:
        log("TextSearch 성공: ${result.value}", name: _logTag);
        _places = result.value;
      case Error<List<Place>> _:
        log("TextSearch 실패: ${result.error}", name: _logTag);
    }
    notifyListeners();
    return result;
  }

  void clearPlace() {
    places.clear();
    notifyListeners();
  }
}
