package com.github.fruna97.nadeuri.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ParticipatingNadeuriDto {

    private String title;
    private List<MemberSummaryResponse> members;
}
