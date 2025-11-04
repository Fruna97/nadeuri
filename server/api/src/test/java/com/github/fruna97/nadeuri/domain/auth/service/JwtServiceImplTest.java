package com.github.fruna97.nadeuri.domain.auth.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import static org.mockito.Mockito.when;
import java.time.Duration;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.github.fruna97.nadeuri.domain.auth.dto.TokenResponse;
import com.github.fruna97.nadeuri.domain.auth.repository.MemoryRefreshTokenRepository;
import com.github.fruna97.nadeuri.domain.auth.repository.RefreshTokenRepository;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;

@ExtendWith(MockitoExtension.class)
class JwtServiceImplTest {

    JwtService jwtService;

    RefreshTokenRepository refreshTokenRepository;

    @Mock
    MemberRepository memberRepository;

    private final String secretKey = "test_secret_key";
    private final Duration accessTokenDuration = Duration.ofMinutes(30);
    private final Duration refreshTokenDuration = Duration.ofDays(3);

    @BeforeEach
    void beforeEach() {
        refreshTokenRepository = new MemoryRefreshTokenRepository();
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
        // Given
        UUID uuid = UUID.randomUUID();

        // When
        String accessToken = jwtService.createAccessToken(uuid);

        // Then
        assertThat(accessToken).isNotEmpty(); // Access Token이 생성되었는지
        assertThatCode(() -> {
            DecodedJWT verifiedToken = JWT.require(Algorithm.HMAC512(secretKey)).build().verify(accessToken);
            if (!verifiedToken.getClaim("type").asString().equals("access")) throw new Exception();
        }).doesNotThrowAnyException(); // 토큰이 유효한지
    }

    @Test
    void createAndSaveRefreshToken() {
        // Given
        UUID uuid = UUID.randomUUID();

        // When
        String refreshToken = jwtService.createAndSaveRefreshToken(uuid);

        // Then
        assertThat(refreshToken).isNotEmpty(); // Refresh Token이 생성되었는지
        assertThatCode(() -> {
            DecodedJWT verifiedToken = JWT.require(Algorithm.HMAC512(secretKey)).build().verify(refreshToken);
            if (!verifiedToken.getClaim("type").asString().equals("refresh")) throw new Exception();
        }).doesNotThrowAnyException(); // 토큰이 유효한지

        Optional<String> savedRefreshToken = refreshTokenRepository.findByUuid(uuid);
        assertThat(savedRefreshToken)
                .isPresent() // 토큰이 저장되었는지
                .get()
                .isEqualTo(refreshToken); // 저장된 토큰이 생성한 토큰과 일치하는지
    }

    @Test
    void verifyToken_유효토큰() {
        // Given
        UUID uuid = UUID.randomUUID();
        String validToken = JWT.create()
                .withSubject(uuid.toString())
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));

        // When
        Optional<DecodedJWT> verifiedToken = jwtService.verifyToken(validToken);

        // Then
        assertThat(verifiedToken).isPresent(); // 유효한 토큰을 제대로 검증했는지
        assertThat(verifiedToken.get().getSubject()).isEqualTo(uuid.toString()); // 복호화한 토큰에 정상적인 UUID가 담겨있는지
    }

    @Test
    void verifyToken_만료토큰() {
        // Given
        UUID uuid = UUID.randomUUID();
        String expiredToken = JWT.create()
                .withSubject(uuid.toString())
                .withExpiresAt(new Date(System.currentTimeMillis() - 3600))
                .sign(Algorithm.HMAC512(secretKey));

        // When
        Optional<DecodedJWT> verifiedToken = jwtService.verifyToken(expiredToken);

        // Then
        assertThat(verifiedToken).isNotPresent(); // 유효하지 않은 토큰을 제대로 검증했는지
    }

    @Test
    void verifyToken_위변조토큰() {
        // Given
        UUID uuid = UUID.randomUUID();
        String validToken = JWT.create()
                .withSubject(uuid.toString())
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));
        String tamperedToken = validToken + "tempering";

        // When
        Optional<DecodedJWT> verifiedToken = jwtService.verifyToken(tamperedToken);

        // Then
        assertThat(verifiedToken).isNotPresent(); // 유효하지 않은 토큰을 제대로 검증했는지
    }

    @Test
    void reissueToken() {
        // Given
        UUID uuid = UUID.randomUUID();
        Member member = Member.builder()
                .email("test_email")
                .password("test_password")
                .uuid(uuid)
                .build();
        when(memberRepository.findByUuid(uuid)).thenReturn(Optional.of(member));

        String refreshToken = JWT.create()
                .withSubject(uuid.toString())
                .withClaim("type", "refresh")
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));
        refreshTokenRepository.save(uuid, refreshToken, refreshTokenDuration);

        // When
        TokenResponse result = jwtService.reissueToken(refreshToken);

        // Then
        assertThat(result.getAccessToken()).isNotEmpty(); // Access Token이 발급되었는지
        assertThat(result.getRefreshToken()).isNotEmpty(); // Refresh Token이 발급되었는지
        Optional<String> savedRefreshToken = refreshTokenRepository.findByUuid(uuid);
        assertThat(result.getRefreshToken()).isEqualTo(savedRefreshToken.get()); // 재발급된 Refresh Token이 정확히 저장되었는지
    }

    @Test
    void deleteRefreshToken() {
        // Given
        UUID uuid = UUID.randomUUID();
        String refreshToken = "test_token";
        refreshTokenRepository.save(uuid, refreshToken, refreshTokenDuration);

        // When
        jwtService.deleteRefreshToken(uuid);

        // Then
        assertThat(refreshTokenRepository.findByUuid(uuid)).isNotPresent(); // UUID에 해당하는 RefreshToken을 정상적으로 제거했는지
    }
}
