import 'package:freezed_annotation/freezed_annotation.dart';

part 'nadeuri_api_model.freezed.dart';
part 'nadeuri_api_model.g.dart';

@freezed
abstract class NadeuriApiModel with _$NadeuriApiModel {
  const factory NadeuriApiModel({
    required String? title
  }) = _NadeuriApiModel;

  factory NadeuriApiModel.fromJson(Map<String, dynamic> json) => _$NadeuriApiModelFromJson(json);
}