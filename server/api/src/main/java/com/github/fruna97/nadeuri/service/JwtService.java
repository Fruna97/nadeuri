package com.github.fruna97.nadeuri.service;

import java.util.Optional;
import com.auth0.jwt.interfaces.DecodedJWT;

public interface JwtService {

    String createAccessToken(String email);

    String createAndSaveRefreshToken(String email);

    /**
     * 주어진 JWT를 검증
     * 
     * @param jwt 검증이 필요한 토큰
     * @return 토큰이 검증되었다면 DecodedJWT 반환. 검증되지 않았다면 {@literal Optional#empty()} 반환.
     */
    Optional<DecodedJWT> verifyToken(String jwt);

    void deleteRefreshToken(String email);
}
