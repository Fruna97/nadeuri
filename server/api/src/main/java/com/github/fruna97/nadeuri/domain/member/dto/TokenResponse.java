package com.github.fruna97.nadeuri.domain.member.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class TokenResponse {

    private String accessToken;
    private String refreshToken;
}
