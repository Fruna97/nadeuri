package com.github.fruna97.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import java.time.Duration;
import java.util.Date;
import java.util.Optional;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.github.fruna97.nadeuri.repository.MemoryRefreshTokenRepository;
import com.github.fruna97.nadeuri.repository.RefreshTokenRepository;

class JwtServiceImplTest {

    JwtService jwtService;
    RefreshTokenRepository refreshTokenRepository;

    private final String secretKey = "test_secret_key";
    private final Duration accessTokenDuration = Duration.ofMinutes(30);
    private final Duration refreshTokenDuration = Duration.ofDays(3);

    @BeforeEach
    void beforeEach() {
        refreshTokenRepository = new MemoryRefreshTokenRepository();
        jwtService = new JwtServiceImpl(secretKey, accessTokenDuration, refreshTokenDuration, refreshTokenRepository);
    }

    @AfterEach
    void afterEach() {
        if (refreshTokenRepository instanceof MemoryRefreshTokenRepository) {
            MemoryRefreshTokenRepository.clear();
        }
    }

    @Test
    void createAccessToken() {
        // given
        String email = "test_email@test.com";

        // when
        String accessToken = jwtService.createAccessToken(email);

        // then
        assertThat(accessToken).isNotEmpty();
        assertThatCode(() -> 
            JWT.require(Algorithm.HMAC512(secretKey)).build().verify(accessToken)
        ).doesNotThrowAnyException();
    }

    @Test
    void createAndSaveRefreshToken() {
        // given
        String email = "test_email@test.com";

        // when
        String refreshToken = jwtService.createAndSaveRefreshToken(email);

        // then
        assertThat(refreshToken).isNotEmpty();
        assertThatCode(() -> 
            JWT.require(Algorithm.HMAC512(secretKey)).build().verify(refreshToken)
        ).doesNotThrowAnyException();

        Optional<String> savedRefreshToken = refreshTokenRepository.findByEmail(email);
        assertThat(savedRefreshToken)
                .isPresent()
                .get()
                .isEqualTo(refreshToken);
    }

    @Test
    void deleteRefreshToken() {
        // given
        String email = "test_email@test.com";
        String refreshToken = "test_token";
        refreshTokenRepository.save(email, refreshToken, refreshTokenDuration);

        // when
        jwtService.deleteRefreshToken(email);

        // then
        assertThat(refreshTokenRepository.findByEmail(email)).isNotPresent();
    }

    @Test
    void verifyToken_유효토큰() {
        // given
        String email = "test_email@test.com";
        String validToken = JWT.create()
                .withClaim("email", email)
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));

        // when
        Optional<DecodedJWT> verifiedToken = jwtService.verifyToken(validToken);

        // then
        assertThat(verifiedToken).isPresent();
        assertThat(verifiedToken.get().getClaim("email").asString()).isEqualTo(email);
    }

    @Test
    void verifyToken_만료토큰() {
        // given
        String email = "test_email@test.com";
        String expiredToken = JWT.create()
                .withClaim("email", email)
                .withExpiresAt(new Date(System.currentTimeMillis() - 3600))
                .sign(Algorithm.HMAC512(secretKey));

        // when
        Optional<DecodedJWT> verifiedToken = jwtService.verifyToken(expiredToken);

        // then
        assertThat(verifiedToken).isNotPresent();
    }

    @Test
    void verifyToken_위변조토큰() {
        // given
        String email = "test_email@test.com";
        String validToken = JWT.create()
                .withClaim("email", email)
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));
        String tamperedToken = validToken + "tempering";

        // when
        Optional<DecodedJWT> verifiedToken = jwtService.verifyToken(tamperedToken);

        // then
        assertThat(verifiedToken).isNotPresent();
    }
}
