import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_by_text_request.freezed.dart';
part 'search_by_text_request.g.dart';

@Freezed(toJson: true, fromJson: false)
abstract class SearchByTextRequest with _$SearchByTextRequest {
  const factory SearchByTextRequest({
    required String textQuery,
    double? latitude,
    double? longitude
  }) = _SearchByTextRequest;
}