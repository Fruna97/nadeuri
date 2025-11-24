import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/data/service/model/member/member_api_model.dart';
import 'package:mobile/domain/model/nadeuri/nadeuri.dart';

part 'nadeuri_api_model.freezed.dart';
part 'nadeuri_api_model.g.dart';

@freezed
abstract class NadeuriApiModel with _$NadeuriApiModel {
  const NadeuriApiModel._();

  const factory NadeuriApiModel({
    String? uuid,
    required String title,
    required List<MemberApiModel> members
  }) = _NadeuriApiModel;

  factory NadeuriApiModel.fromJson(Map<String, dynamic> json) => _$NadeuriApiModelFromJson(json);

  static NadeuriApiModel fromNadeuri(Nadeuri nadeuri) {
    return NadeuriApiModel(
      uuid: nadeuri.uuid,
      title: nadeuri.title,
      members: nadeuri.members.map((member) => MemberApiModel.fromMember(member)).toList(),
    );
  }

  Nadeuri toNadeuri() {
    return Nadeuri(
      uuid: uuid,
      title: title,
      members: members.map((memberApiModel) => memberApiModel.toMember()).toList(),
    );
  }
}
