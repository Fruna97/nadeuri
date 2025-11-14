package com.github.fruna97.nadeuri.domain.nadeuri.dto;

import java.util.List;
import java.util.UUID;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ParticipatingNadeuriResponse {

    private UUID uuid;
    private String title;
    private List<MemberSummaryResponse> members;
}
