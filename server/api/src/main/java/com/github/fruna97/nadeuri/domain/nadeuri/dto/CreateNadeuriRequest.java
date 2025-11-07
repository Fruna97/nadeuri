package com.github.fruna97.nadeuri.domain.nadeuri.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class CreateNadeuriRequest {

    private String title;
}
