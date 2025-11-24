import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/domain/model/member/member.dart';

part 'member_api_model.freezed.dart';
part 'member_api_model.g.dart';

@freezed
abstract class MemberApiModel with _$MemberApiModel {
  const MemberApiModel._();

  const factory MemberApiModel({
    required String uuid,
    required String email,
    String? nickname,
    String? profileImageUrl,
  }) = _MemberApiModel;

  factory MemberApiModel.fromJson(Map<String, dynamic> json) => _$MemberApiModelFromJson(json);

  static MemberApiModel fromMember(Member member) {
    return MemberApiModel(
      uuid: member.uuid,
      email: member.email,
      nickname: member.nickname,
      profileImageUrl: member.profileImageUrl,
    );
  }

  Member toMember() {
    return Member(uuid: uuid, email: email, nickname: nickname, profileImageUrl: profileImageUrl);
  }
}
