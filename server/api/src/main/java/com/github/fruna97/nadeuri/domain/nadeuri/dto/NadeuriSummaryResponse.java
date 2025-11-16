package com.github.fruna97.nadeuri.domain.nadeuri.dto;

import java.util.List;
import java.util.UUID;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class NadeuriSummaryResponse {

    private UUID uuid;
    private String title;
    private List<MemberSummaryResponse> members;

    public static NadeuriSummaryResponse fromEntity(Nadeuri nadeuri) {
        return NadeuriSummaryResponse.builder()
                .uuid(nadeuri.getUuid())
                .title(nadeuri.getTitle())
                .members(nadeuri.getMembers().stream()
                        .map(MemberSummaryResponse::fromEntity).toList()).build();
    }
}
