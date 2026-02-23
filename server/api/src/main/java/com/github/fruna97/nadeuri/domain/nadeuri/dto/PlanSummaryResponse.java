package com.github.fruna97.nadeuri.domain.nadeuri.dto;

import java.time.LocalDateTime;
import java.util.UUID;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Plan;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class PlanSummaryResponse {

    private UUID uuid;

    private String title;

    private String googlePlacesId;

    private boolean allDay;

    private LocalDateTime startAt;

    private LocalDateTime endAt;

    private UUID nadeuriUuid;

    public static PlanSummaryResponse fromEntity(Plan plan) {
        return PlanSummaryResponse.builder()
                .uuid(plan.getUuid())
                .title(plan.getTitle())
                .googlePlacesId(plan.getGooglePlacesId())
                .allDay(plan.isAllDay())
                .startAt(plan.getStartAt())
                .endAt(plan.getEndAt())
                .nadeuriUuid(plan.getNadeuri().getUuid()).build();
    }
}
