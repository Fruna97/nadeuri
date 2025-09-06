package com.github.fruna97.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import java.time.Duration;
import java.util.Date;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.repository.MemberRepository;
import com.github.fruna97.nadeuri.repository.MemoryMemberRepository;
import com.github.fruna97.nadeuri.repository.MemoryRefreshTokenRepository;
import com.github.fruna97.nadeuri.repository.RefreshTokenRepository;

class JwtServiceImplTest {

    JwtService jwtService;
    RefreshTokenRepository refreshTokenRepository;
    MemberRepository memberRepository;

    private final String secretKey = "test_secret_key";
    private final Duration accessTokenDuration = Duration.ofMinutes(30);
    private final Duration refreshTokenDuration = Duration.ofDays(3);

    @BeforeEach
    void beforeEach() {
        refreshTokenRepository = new MemoryRefreshTokenRepository();
        memberRepository = new MemoryMemberRepository();
        jwtService = new JwtServiceImpl(secretKey, accessTokenDuration, refreshTokenDuration, refreshTokenRepository, memberRepository);
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
        UUID uuid = UUID.randomUUID();

        // when
        String accessToken = jwtService.createAccessToken(uuid);

        // then
        assertThat(accessToken).isNotEmpty();
        assertThatCode(() -> {
            DecodedJWT verifiedToken = JWT.require(Algorithm.HMAC512(secretKey)).build().verify(accessToken);
            if (!verifiedToken.getClaim("type").asString().equals("access")) throw new Exception();
        }).doesNotThrowAnyException();
    }

    @Test
    void createAndSaveRefreshToken() {
        // given
        UUID uuid = UUID.randomUUID();

        // when
        String refreshToken = jwtService.createAndSaveRefreshToken(uuid);

        // then
        assertThat(refreshToken).isNotEmpty();
        assertThatCode(() -> {
            DecodedJWT verifiedToken = JWT.require(Algorithm.HMAC512(secretKey)).build().verify(refreshToken);
            if (!verifiedToken.getClaim("type").asString().equals("refresh")) throw new Exception();
        }).doesNotThrowAnyException();

        Optional<String> savedRefreshToken = refreshTokenRepository.findByUuid(uuid);
        assertThat(savedRefreshToken)
                .isPresent()
                .get()
                .isEqualTo(refreshToken);
    }

    @Test
    void verifyToken_유효토큰() {
        // given
        UUID uuid = UUID.randomUUID();
        String validToken = JWT.create()
                .withSubject(uuid.toString())
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));

        // when
        Optional<DecodedJWT> verifiedToken = jwtService.verifyToken(validToken);

        // then
        assertThat(verifiedToken).isPresent();
        assertThat(verifiedToken.get().getSubject()).isEqualTo(uuid.toString());
    }

    @Test
    void verifyToken_만료토큰() {
        // given
        UUID uuid = UUID.randomUUID();
        String expiredToken = JWT.create()
                .withSubject(uuid.toString())
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
        UUID uuid = UUID.randomUUID();
        String validToken = JWT.create()
                .withSubject(uuid.toString())
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));
        String tamperedToken = validToken + "tempering";

        // when
        Optional<DecodedJWT> verifiedToken = jwtService.verifyToken(tamperedToken);

        // then
        assertThat(verifiedToken).isNotPresent();
    }

    @Test
    void reissueToken() {
        // given
        Member member = memberRepository.save(Member.builder()
                .email("test_email@test.com")
                .password("test_password")
                .build());
        UUID uuid = member.getUuid();

        String refreshToken = JWT.create()
                .withSubject(uuid.toString())
                .withClaim("type", "refresh")
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));
        refreshTokenRepository.save(uuid, refreshToken, refreshTokenDuration);

        // when
        Map<String, String> reissuedToken = jwtService.reissueToken(refreshToken);

        // then
        assertThat(reissuedToken).containsKeys("accessToken", "refreshToken");

        String reissuedRefreshToken = reissuedToken.get("refreshToken");
        Optional<String> savedRefreshToken = refreshTokenRepository.findByUuid(uuid);
        assertThat(savedRefreshToken).get()
                .isEqualTo(reissuedRefreshToken)
                .isNotEqualTo(refreshToken);
    }

    @Test
    void deleteRefreshToken() {
        // given
        UUID uuid = UUID.randomUUID();
        String refreshToken = "test_token";
        refreshTokenRepository.save(uuid, refreshToken, refreshTokenDuration);

        // when
        jwtService.deleteRefreshToken(uuid);

        // then
        assertThat(refreshTokenRepository.findByUuid(uuid)).isNotPresent();
    }
}
