import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository/nadeuri_repository.dart';
import 'package:mobile/domain/model/nadeuri/nadeuri.dart';
import 'package:mobile/utils/command.dart';
import 'package:mobile/utils/result.dart';

class NadeuriDetailsViewModel extends ChangeNotifier {
  final String _logTag = "NadeuriDetailsViewModel";

  final NadeuriRepository _nadeuriRepository;

  late final Command0 load;
  late final Command1<void, (String,)> updateNadeuri;

  Nadeuri _nadeuri;

  NadeuriDetailsViewModel({required Nadeuri nadeuri, required NadeuriRepository nadeuriRepository})
    : _nadeuri = nadeuri,
      _nadeuriRepository = nadeuriRepository {
    load = Command0(_load)..execute();
    updateNadeuri = Command1(_updateNadeuri);
  }

  Nadeuri get nadeuri => _nadeuri;

  Future<Result> _load() async {
    Result<Nadeuri> result = await _nadeuriRepository.getNadeuri(nadeuri.uuid!);
    switch (result) {
      case Ok<Nadeuri> _:
        _nadeuri = result.value;
        log("Nadeuri 조회 완료: ${_nadeuri}", name: _logTag);
        notifyListeners();
      case Error<Nadeuri> _:
        log("Nadeuri 조회 실패", name: _logTag);
    }
    return result;
  }

  Future<Result> _updateNadeuri((String title,) updateInfo) async {
    final (title,) = updateInfo;

    Result<Nadeuri> result = await _nadeuriRepository.updateNadeuri(nadeuri.uuid!, title);
    switch (result) {
      case Ok<Nadeuri> _:
        _nadeuri = result.value;
        log("Nadeuri 업데이트 완료: ${_nadeuri}", name: _logTag);
      case Error<Nadeuri> _:
        log("Nadeuri 업데이트 실패", name: _logTag);
    }
    notifyListeners();
    return result;
  }
}
