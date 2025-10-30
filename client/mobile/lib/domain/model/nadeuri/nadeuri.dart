import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/domain/model/member/member.dart';

part 'nadeuri.freezed.dart';
part 'nadeuri.g.dart';

@freezed
abstract class Nadeuri with _$Nadeuri {
  const factory Nadeuri({
    String? title,
    List<Member>? members
  }) = _Nadeuri;

  factory Nadeuri.fromJson(Map<String, dynamic> json) => _$NadeuriFromJson(json);
}
