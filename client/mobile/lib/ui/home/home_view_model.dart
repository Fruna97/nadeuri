import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository/member_repository.dart';
import 'package:mobile/data/repository/nadeuri_repository.dart';
import 'package:mobile/domain/model/member/member.dart';
import 'package:mobile/domain/model/nadeuri/nadeuri.dart';
import 'package:mobile/utils/command.dart';
import 'package:mobile/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  final String _logTag = "HomeViewModel";

  final MemberRepository _memberRepository;
  final NadeuriRepository _nadeuriRepository;
  final SharedPreferencesWithCache _prefsWithCache;

  late final Command0 load;
  late final Command1<void, String> createNadeuri;

  bool isRefreshing = false;
  List<Nadeuri> _nadeuris = [];

  HomeViewModel({
    required MemberRepository memberRepository,
    required NadeuriRepository nadeuriRepository,
    required SharedPreferencesWithCache prefsWithCache,
  }) : _memberRepository = memberRepository,
       _nadeuriRepository = nadeuriRepository,
       _prefsWithCache = prefsWithCache {
    load = Command0(_load)..execute();
    createNadeuri = Command1<void, String>(_createNadeuri);
  }

  List<Nadeuri> get nadeuris => _nadeuris;

  Future<Result> _load() async {
    final Result<List<Nadeuri>> nadeurisResult = await _nadeuriRepository.getParticipatingNadeuris();
    switch (nadeurisResult) {
      case Ok<List<Nadeuri>> _:
        _nadeuris = nadeurisResult.value;
        log("Nadeuri 로드 완료", name: _logTag);
      case Error<List<Nadeuri>> _:
        log("Nadeuri 로드 실패", name: _logTag);
        return nadeurisResult;
    }

    final Result memberResult = await _memberRepository.getMyProfile();
    switch (memberResult) {
      case Ok _:
        log("Member 프로필 로드 완료", name: _logTag);
      case Error _:
        log("Member 프로필 로드 실패", name: _logTag);
        return memberResult;
    }

    notifyListeners();
    return memberResult;
  }

  Future<Result> _createNadeuri(String title) async {
    List<Nadeuri> oldNadeuris = _nadeuris;

    // Optimistic 상태 반영
    String? profileImgUrl = _prefsWithCache.getString("profile.profileImgUrl");
    Nadeuri nadeuri = Nadeuri(
      title: title,
      members: <Member>[Member(uuid: "uuid", email: "email", profileImageUrl: profileImgUrl)],
    );
    _nadeuris = [nadeuri, ..._nadeuris];
    notifyListeners();

    final Result result = await _nadeuriRepository.createNadeuri(nadeuri);
    switch (result) {
      case Ok _:
        break;
      case Error _:
        _nadeuris = oldNadeuris;
        notifyListeners();
    }

    return result;
  }
}
