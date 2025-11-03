package com.github.fruna97.nadeuri.domain.member.service;

import java.util.Optional;
import java.util.UUID;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.github.fruna97.nadeuri.domain.member.dto.TokenResponse;

public interface JwtService {

    String createAccessToken(UUID uuid);

    String createAndSaveRefreshToken(UUID uuid);

    /**
     * 주어진 JWT를 검증
     * 
     * @param jwt 검증이 필요한 토큰
     * @return 토큰이 검증되었다면 DecodedJWT 반환. 검증되지 않았다면 {@literal Optional#empty()} 반환.
     */
    Optional<DecodedJWT> verifyToken(String jwt);

    TokenResponse reissueToken(String refreshToken);

    void deleteRefreshToken(UUID uuid);
}
