import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_data.freezed.dart';
part 'token_data.g.dart';

@freezed
abstract class TokenData with _$TokenData {
  const factory TokenData({
    String? accessToken, 
    String? refreshToken
  }) = _TokenData;

  factory TokenData.fromJson(Map<String, dynamic> json) => _$TokenDataFromJson(json);
}
