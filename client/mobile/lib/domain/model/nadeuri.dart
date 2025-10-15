import 'package:freezed_annotation/freezed_annotation.dart';

part 'nadeuri.freezed.dart';
part 'nadeuri.g.dart';

@freezed
abstract class Nadeuri with _$Nadeuri {
  const factory Nadeuri({
    required String? title
  }) = _Nadeuri;

  factory Nadeuri.fromJson(Map<String, dynamic> json) => _$NadeuriFromJson(json);
}