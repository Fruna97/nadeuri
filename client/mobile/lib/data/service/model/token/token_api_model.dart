import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_api_model.freezed.dart';
part 'token_api_model.g.dart';

@freezed
abstract class TokenApiModel with _$TokenApiModel {
  const factory TokenApiModel({
    String? accessToken,
    String? refreshToken
  }) = _TokenApiModel;

  factory TokenApiModel.fromJson(Map<String, dynamic> json) => _$TokenApiModelFromJson(json);
}
