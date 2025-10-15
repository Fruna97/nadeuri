import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository/nadeuri_repository.dart';
import 'package:mobile/domain/model/nadeuri.dart';
import 'package:mobile/utils/command.dart';
import 'package:mobile/utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  final String _logTag = "HomeViewModel";

  final NadeuriRepository _nadeuriRepository;
  late final Command0<List<Nadeuri>> load;

  List<Nadeuri> _nadeuris = [];

  HomeViewModel({required NadeuriRepository nadeuriRepository}) : _nadeuriRepository = nadeuriRepository {
    load = Command0<List<Nadeuri>>(_load)..execute();
  }

  List<Nadeuri> get nadeuris => _nadeuris;

  Future<Result<List<Nadeuri>>> _load() async {
    final Result<List<Nadeuri>> result = await _nadeuriRepository.getParticipatingNadeuris();

    switch (result) {
      case Ok<List<Nadeuri>> _:
        _nadeuris = result.value;
        log("Nadeuri 로드 완료", name: _logTag);
      case Error<List<Nadeuri>> _:
        log("Nadeuri 로드 실패", name: _logTag);
    }

    notifyListeners();

    return result;
  }
}
