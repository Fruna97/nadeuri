package com.github.fruna97.nadeuri.domain.nadeuri.dto;

import java.time.LocalDateTime;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class UpdatePlanRequest {

    @NotNull
    @Size(max = 100)
    private String title;

    private String googlePlacesId;

    private Double latitude;

    private Double longitude;

    @NotNull
    private Boolean allDay;

    @NotNull
    private LocalDateTime startAt;

    @NotNull
    private LocalDateTime endAt;
}
