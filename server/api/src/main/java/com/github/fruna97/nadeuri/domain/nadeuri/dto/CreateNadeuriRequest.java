package com.github.fruna97.nadeuri.domain.nadeuri.dto;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class CreateNadeuriRequest {

    @Size(max = 100)
    private String title;
}
