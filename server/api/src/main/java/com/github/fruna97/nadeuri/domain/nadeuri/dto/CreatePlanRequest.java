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

    private String planTitle;

    private String googlePlacesId;

    private double latitude;

    private double longitude;

    @NotNull
    private LocalDateTime startAt;

    @NotNull
    private LocalDateTime endAt;

    public Plan toEntity(Nadeuri nadeuri) {
        return Plan.builder()
                .planTitle(planTitle)
                .googlePlacesId(googlePlacesId)
                .latitude(latitude)
                .longitude(longitude)
                .startAt(startAt)
                .endAt(endAt)
                .nadeuri(nadeuri).build();
    }
}
