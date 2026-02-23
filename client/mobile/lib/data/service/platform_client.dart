import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mobile/data/service/model/place/place_dto.dart';
import 'package:mobile/data/service/model/search_by_text_request/search_by_text_request.dart';
import 'package:mobile/utils/result.dart';

class PlatformClient {
  final String _logTag = "PlatformClient";

  final MethodChannel _methodChannel;

  PlatformClient({required MethodChannel methodChannel}) : _methodChannel = methodChannel;

  Future<Result<List<PlaceDto>>> searchByText(SearchByTextRequest searchByTextRequest) async {
    String? searchByTextResult;
    try {
      searchByTextResult = await _methodChannel.invokeMethod<String>("searchByText", {
        "textQuery": searchByTextRequest.textQuery,
        "latitude": searchByTextRequest.latitude,
        "longitude": searchByTextRequest.longitude,
      });
    } on Exception catch (e) {
      log("MethodChannel 호출 실패: $e", name: _logTag);
      return Result.error(e);
    }

    if (searchByTextResult == null) {
      return Result.ok(List.empty());
    }

    List<PlaceDto> places = [];
    List<dynamic> jsonPlaces = jsonDecode(searchByTextResult);
    for (var element in jsonPlaces) {
      /// 파싱이 불가능한 장소 데이터는 버림
      final PlaceDto placeDto;
      try {
        placeDto = PlaceDto.fromJson(element as Map<String, dynamic>);
        places.add(placeDto);
      } on Exception catch (e) {
        log("Deserialize 실패 (파싱 정보: $element, 오류: $e)", name: _logTag);
      }
    }
    return Result.ok(places);
  }
}
