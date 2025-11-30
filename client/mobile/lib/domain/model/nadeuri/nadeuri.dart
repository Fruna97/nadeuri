import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/domain/model/member/member.dart';
import 'package:mobile/domain/model/plan/plan.dart';

part 'nadeuri.freezed.dart';
part 'nadeuri.g.dart';

@freezed
abstract class Nadeuri with _$Nadeuri {
  const factory Nadeuri({
    String? uuid,
    required String title,
    required List<Member> members,
    required List<Plan> plans,
  }) = _Nadeuri;

  factory Nadeuri.fromJson(Map<String, dynamic> json) => _$NadeuriFromJson(json);
}
