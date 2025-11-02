package com.github.fruna97.nadeuri.domain.member.service;

import java.time.Duration;
import java.util.Date;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Service;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.domain.member.repository.RefreshTokenRepository;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class JwtServiceImpl implements JwtService {

    private final String secretKey;
    private final Duration accessTokenDuration;
    private final Duration refreshTokenDuration;
    private final RefreshTokenRepository refreshTokenRepository;
    private final MemberRepository memberRepository;

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
    }

    @Override
    public String createAccessToken(UUID uuid) {
        return JWT.create()
                .withIssuer("nadeuri-api")
                .withSubject(uuid.toString())
                .withClaim("type", "access")
                .withExpiresAt(new Date(System.currentTimeMillis() + (accessTokenDuration.toMillis())))
                .sign(Algorithm.HMAC512(secretKey));
    }

    @Override
    public String createAndSaveRefreshToken(UUID uuid) {
        String jwt = JWT.create()
                .withIssuer("nadeuri-api")
                .withSubject(uuid.toString())
                .withClaim("type", "refresh")
                .withExpiresAt(new Date(System.currentTimeMillis() + (refreshTokenDuration.toMillis())))
                .sign(Algorithm.HMAC512(secretKey));

        return refreshTokenRepository.save(uuid, jwt, refreshTokenDuration);
    }

    @Override
    public Optional<DecodedJWT> verifyToken(String jwt) {
        JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC512(secretKey)).build();

        try {
            DecodedJWT decodedJwt = jwtVerifier.verify(jwt);
            return Optional.ofNullable(decodedJwt);
        } catch (JWTVerificationException e) {
            return Optional.ofNullable(null);
        }
    }

    @Override
    public Map<String, String> reissueToken(String refreshToken) {
        DecodedJWT verifiedToken = verifyToken(refreshToken)
                .orElseThrow(() -> new BadCredentialsException("자격 증명에 실패하였습니다."));

        String tokenType = verifiedToken.getClaim("type").asString();
        if (!tokenType.equals("refresh")) {
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        UUID uuid = UUID.fromString(verifiedToken.getSubject());
        String savedToken = refreshTokenRepository.findByUuid(uuid)
                .orElseThrow(() -> new BadCredentialsException("자격 증명에 실패하였습니다."));

        if (!savedToken.equals(refreshToken)) {
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        memberRepository.findByUuid(uuid)
                .orElseThrow(() -> {
                    log.warn("존재하지 않는 회원의 JWT 요청이 발생 : " + uuid.toString());
                    return new BadCredentialsException("자격 증명에 실패하였습니다.");
                });

        String newAccessToken = createAccessToken(uuid);
        String newRefreshToken = createAndSaveRefreshToken(uuid);

        return Map.of("accessToken", newAccessToken, 
                "refreshToken", newRefreshToken);
    }

    @Override
    public void deleteRefreshToken(UUID uuid) {
        refreshTokenRepository.deleteByUuid(uuid);        
    }
}
