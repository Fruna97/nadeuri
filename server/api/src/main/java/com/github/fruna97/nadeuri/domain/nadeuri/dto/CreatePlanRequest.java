package com.github.fruna97.nadeuri.domain.nadeuri.dto;

import java.time.LocalDateTime;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Plan;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class CreatePlanRequest {

    private String title;

    private String googlePlacesId;

    @NotNull
    private Boolean allDay;

    @NotNull
    private LocalDateTime startAt;

    @NotNull
    private LocalDateTime endAt;

    public Plan toEntity(Nadeuri nadeuri) {
        return Plan.builder()
                .title(title)
                .googlePlacesId(googlePlacesId)
                .allDay(allDay)
                .startAt(startAt)
                .endAt(endAt)
                .nadeuri(nadeuri).build();
    }
}
