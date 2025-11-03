package com.github.fruna97.nadeuri.domain.nadeuri.dto;

import java.util.List;
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

    private String title;
    private List<MemberSummaryResponse> members;
}
