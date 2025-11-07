package com.github.fruna97.nadeuri.domain.auth.service;

import java.util.Optional;
import java.util.UUID;
import org.springframework.security.core.Authentication;
import com.github.fruna97.nadeuri.domain.auth.dto.TokenResponse;

enum TokenType {
    ACCESS, REFRESH
}

public interface JwtService {

    String createAccessToken(UUID uuid);

    String createAndSaveRefreshToken(UUID uuid);

    Optional<Authentication> getAuthenticationFromAccessToken(String accessToken);

    TokenResponse reissueToken(String refreshToken);

    void deleteRefreshToken(UUID uuid);
}
