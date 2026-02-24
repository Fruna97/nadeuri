package com.github.fruna97.nadeuri.domain.auth.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import static org.junit.jupiter.api.Assertions.assertThrows;
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
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
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

    private final String secretKey = "test_secret_key";
    private final Duration accessTokenDuration = Duration.ofMinutes(30);
    private final Duration refreshTokenDuration = Duration.ofDays(3);

    private RefreshTokenRepository refreshTokenRepository;

    @Mock
    private MemberRepository memberRepository;

    private JwtService jwtService;

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
        String result = jwtService.createAccessToken(uuid);

        // Then
        assertThat(result).isNotEmpty(); // 토큰이 생성되었는지
        assertThatCode(() -> {
            DecodedJWT verifiedToken = JWT.require(Algorithm.HMAC512(secretKey)).build().verify(result); // 생성된 토큰이 검증에 문제가 없는지
            if (!verifiedToken.getClaim("type").asString().equals(TokenType.ACCESS.name())) throw new Exception(); // 생성된 토큰의 유형이 Access 인지
        }).doesNotThrowAnyException();
    }

    @Test
    void createAndSaveRefreshToken() {
        // Given
        UUID uuid = UUID.randomUUID();

        // When
        String result = jwtService.createAndSaveRefreshToken(uuid);

        // Then
        assertThat(result).isNotEmpty(); // 토큰이 생성되었는지
        assertThatCode(() -> {
            DecodedJWT verifiedToken = JWT.require(Algorithm.HMAC512(secretKey)).build().verify(result); // 생성된 토큰이 검증에 문제가 없는지
            if (!verifiedToken.getClaim("type").asString().equals(TokenType.REFRESH.name())) throw new Exception(); // 생성된 토큰의 유형이 Refresh 인지
        }).doesNotThrowAnyException();

        Optional<String> savedRefreshToken = refreshTokenRepository.findByUuid(uuid);
        assertThat(savedRefreshToken)
                .isPresent().get() // Refresh Token 저장소에 토큰이 저장되었는지
                .isEqualTo(result); // 저장된 토큰이 생성한 토큰과 일치하는지
    }

    @Test
    void getAuthenticationFromAccessToken() {
        // Given
        UUID memberUuid = UUID.randomUUID();
        String accessToken = JWT.create()
                .withSubject(memberUuid.toString())
                .withClaim("type", TokenType.ACCESS.name())
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));

        // When
        Optional<Authentication> result = jwtService.getAuthenticationFromAccessToken(accessToken);

        // Then
        assertThat(result).isNotEmpty(); // 유효한 토큰에 대해 인증정보를 담아 반환하는지
    }

    @Test
    void getAuthenticationFromAccessToken_만료토큰() {
        // Given
        UUID memberUuid = UUID.randomUUID();
        String accessToken = JWT.create()
                .withSubject(memberUuid.toString())
                .withClaim("type", TokenType.ACCESS.name())
                .withExpiresAt(new Date(System.currentTimeMillis() - 3600))
                .sign(Algorithm.HMAC512(secretKey));

        // When
        Optional<Authentication> result = jwtService.getAuthenticationFromAccessToken(accessToken);

        // Then
        assertThat(result).isEmpty(); // 만료된 토큰에 대해 인증정보를 담지 않고 반환하는지
    }

    @Test
    void getAuthenticationFromAccessToken_위변조토큰() {
        // Given
        UUID memberUuid = UUID.randomUUID();
        String accessToken = JWT.create()
                .withSubject(memberUuid.toString())
                .withClaim("type", TokenType.ACCESS.name())
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));
        String tamperedToken = accessToken + "tempering";

        // When
        Optional<Authentication> result = jwtService.getAuthenticationFromAccessToken(tamperedToken);

        // Then
        assertThat(result).isEmpty(); // 위변조 토큰에 대해 인증정보를 담지 않고 반환하는지
    }

    @Test
    void getAuthenticationFromAccessToken_유형이다른토큰() {
        // Given
        UUID memberUuid = UUID.randomUUID();
        String accessToken = JWT.create()
                .withSubject(memberUuid.toString())
                .withClaim("type", TokenType.REFRESH.name())
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));

        // When
        Optional<Authentication> result = jwtService.getAuthenticationFromAccessToken(accessToken);

        // Then
        assertThat(result).isEmpty(); // 유형이 다른 토큰에 대해 인증정보를 담지 않고 반환하는지
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
                .withClaim("type", TokenType.REFRESH.name())
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
    void reissueToken_만료토큰() {
        // Given
        UUID uuid = UUID.randomUUID();
        String refreshToken = JWT.create()
                .withSubject(uuid.toString())
                .withClaim("type", "refresh")
                .withExpiresAt(new Date(System.currentTimeMillis() - 3600))
                .sign(Algorithm.HMAC512(secretKey));
        refreshTokenRepository.save(uuid, refreshToken, refreshTokenDuration);

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            jwtService.reissueToken(refreshToken);
        }); // 만료된 토큰에 대해 인증 예외가 발생하는지
    }

    @Test
    void reissueToken_위변조토큰() {
        // Given
        UUID uuid = UUID.randomUUID();
        String refreshToken = JWT.create()
                .withSubject(uuid.toString())
                .withClaim("type", "refresh")
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));
        refreshTokenRepository.save(uuid, refreshToken, refreshTokenDuration);
        String tamperedToken = refreshToken + "tempering";

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            jwtService.reissueToken(tamperedToken);
        }); // 위변조 토큰에 대해 인증 예외가 발생하는지
    }

    @Test
    void reissueToken_저장소에없는토큰() {
        // Given
        UUID uuid = UUID.randomUUID();
        String refreshToken = JWT.create()
                .withSubject(uuid.toString())
                .withClaim("type", "refresh")
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            jwtService.reissueToken(refreshToken);
        }); // Refresh Token 저장소에 존재하지 않는 토큰에 대해 인증 예외가 발생하는지
    }

    @Test
    void reissueToken_존재하지않는회원() {
        // Given
        UUID uuid = UUID.randomUUID();
        when(memberRepository.findByUuid(uuid)).thenReturn(Optional.empty());

        String refreshToken = JWT.create()
                .withSubject(uuid.toString())
                .withClaim("type", TokenType.REFRESH.name())
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600))
                .sign(Algorithm.HMAC512(secretKey));
        refreshTokenRepository.save(uuid, refreshToken, refreshTokenDuration);

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            jwtService.reissueToken(refreshToken);
        }); // 존재하지 않는 회원 UUID를 담은 토큰에 대해 인증 예외가 발생하는지
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
