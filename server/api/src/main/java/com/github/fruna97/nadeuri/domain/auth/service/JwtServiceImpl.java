package com.github.fruna97.nadeuri.domain.auth.service;

import java.time.Duration;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.github.fruna97.nadeuri.domain.auth.dto.TokenResponse;
import com.github.fruna97.nadeuri.domain.auth.repository.RefreshTokenRepository;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class JwtServiceImpl implements JwtService {

    private final String secretKey;
    private final Duration accessTokenDuration;
    private final Duration refreshTokenDuration;
    private final RefreshTokenRepository refreshTokenRepository;
    private final MemberRepository memberRepository;
    private final JWTVerifier jwtVerifier;

    @Autowired
    public JwtServiceImpl(@Value("${jwt.secret}") String secretKey,
            @Value("${jwt.access-token-duration}") Duration accessTokenDuration,
            @Value("${jwt.refresh-token-duration}") Duration refreshTokenDuration,
            RefreshTokenRepository refreshTokenRepository, 
            MemberRepository memberRepository) {
        this.secretKey = secretKey;
        this.accessTokenDuration = accessTokenDuration;
        this.refreshTokenDuration = refreshTokenDuration;
        this.refreshTokenRepository = refreshTokenRepository;
        this.memberRepository = memberRepository;
        this.jwtVerifier = JWT.require(Algorithm.HMAC512(secretKey)).build();
    }

    @Override
    public String createAccessToken(UUID uuid) {
        return JWT.create()
                .withIssuer("nadeuri-api")
                .withSubject(uuid.toString())
                .withClaim("type", TokenType.ACCESS.name())
                .withExpiresAt(new Date(System.currentTimeMillis() + (accessTokenDuration.toMillis())))
                .sign(Algorithm.HMAC512(secretKey));
    }

    @Override
    public String createAndSaveRefreshToken(UUID uuid) {
        String jwt = JWT.create()
                .withIssuer("nadeuri-api")
                .withSubject(uuid.toString())
                .withClaim("type", TokenType.REFRESH.name())
                .withExpiresAt(new Date(System.currentTimeMillis() + (refreshTokenDuration.toMillis())))
                .sign(Algorithm.HMAC512(secretKey));

        return refreshTokenRepository.save(uuid, jwt, refreshTokenDuration);
    }

    /**
     * 아래의 과정으로 Access Token의 유효성을 검증하여 인증정보를 반환.<p>
     * 1. 토큰 검증<p>
     * 2. 토큰 유형 검증<p>
     * 3. 토큰 정보 기반 회원 조회<p>
     * 
     * @param accessToken 검증할 Access Token
     * @return 유효하지 않으면 빈 {@code Optional} 반환. 유효하면 토큰에 담긴 UUID 반환.
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<Authentication> getAuthenticationFromAccessToken(String accessToken) {
        Optional<UUID> uuid = verifyTokenAndGetUuid(accessToken, TokenType.ACCESS);
        if (uuid.isEmpty()) {
            return Optional.empty();
        }

        Optional<Member> member = memberRepository.findByUuid(uuid.get());
        if (member.isEmpty()) {
            log.warn("존재하지 않는 회원의 Access Token 요청 발생 : " + uuid.toString());
            return Optional.empty();
        }

        PrincipalDetails principalDetails = new PrincipalDetails(member.get());
        // 임의로 인증된 객체 생성
        // 권장 생성 방식은 아니지만, 앞전의 AccessToken 유효성 검증을 근거로 둠
        Authentication authentication = new UsernamePasswordAuthenticationToken(principalDetails, null, null);
        return Optional.of(authentication);
    }

    @Override
    @Transactional(readOnly = true)
    public TokenResponse reissueToken(String refreshToken) {
        UUID uuid = validateRefreshTokenAndGetUuid(refreshToken)
                .orElseThrow(() -> new BadCredentialsException("자격 증명에 실패하였습니다."));

        String newAccessToken = createAccessToken(uuid);
        String newRefreshToken = createAndSaveRefreshToken(uuid);

        return TokenResponse.builder()
                .accessToken(newAccessToken)
                .refreshToken(newRefreshToken).build();
    }

    @Override
    public void deleteRefreshToken(UUID uuid) {
        refreshTokenRepository.deleteByUuid(uuid);        
    }

    private Optional<UUID> verifyTokenAndGetUuid(String jwt, TokenType expectedType) {
        DecodedJWT decodedJwt;
        try {
            decodedJwt = jwtVerifier.verify(jwt);
        } catch (JWTVerificationException e) {
            return Optional.empty();
        }

        String tokenType = decodedJwt.getClaim("type").asString();
        if (tokenType == null || !tokenType.equals(expectedType.name())) {
            return Optional.empty();
        }

        return Optional.of(UUID.fromString(decodedJwt.getSubject()));
    }

    /**
     * 아래의 과정으로 Refresh Token의 유효성을 검증하여 UUID 반환.<p>
     * 1. 토큰 검증<p>
     * 2. 토큰 유형 검증<p>
     * 3. 토큰 정보 기반 Refresh Token 조회 및 비교<p>
     * 4. 토큰 정보 기반 회원 조회<p>
     * 
     * @param refreshToken 검증할 Refresh Token
     * @return 유효하지 않으면 빈 {@code Optional} 반환. 유효하면 토큰에 담긴 UUID 반환.
     */
    private Optional<UUID> validateRefreshTokenAndGetUuid(String refreshToken) {
        Optional<UUID> uuid = verifyTokenAndGetUuid(refreshToken, TokenType.REFRESH);
        if (uuid.isEmpty()) {
            return Optional.empty();
        }

        Optional<String> savedRefreshToken = refreshTokenRepository.findByUuid(uuid.get());
        if (savedRefreshToken.isEmpty()) {
            return Optional.empty();
        }

        if (!savedRefreshToken.get().equals(refreshToken)) {
            return Optional.empty();
        }

        Optional<Member> member = memberRepository.findByUuid(uuid.get());
        if (member.isEmpty()) {
            log.warn("존재하지 않는 회원의 Refresh Token 요청 발생 : " + uuid.get().toString());
            return Optional.empty();
        }

        return Optional.of(uuid.get());
    }
}
