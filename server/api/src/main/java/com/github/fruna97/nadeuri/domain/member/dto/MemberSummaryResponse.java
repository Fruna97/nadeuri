package com.github.fruna97.nadeuri.domain.member.dto;

import java.util.UUID;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class MemberSummaryResponse {

    private UUID uuid;
    private String email;
    private String nickname;
    private String profileImageUrl;

    public static MemberSummaryResponse from(Member member) {
        return MemberSummaryResponse.builder()
                .uuid(member.getUuid())
                .email(member.getEmail())
                .nickname(member.getNickname())
                .profileImageUrl(member.getProfileImageUrl()).build();
    }
}
