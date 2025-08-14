package com.github.fruna97.nadeuri.service;

import java.time.Duration;
import java.util.Date;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.github.fruna97.nadeuri.repository.RefreshTokenRepository;

@Service
public class JwtServiceImpl implements JwtService {

    private final String secretKey;
    private final Duration accessTokenDuration;
    private final Duration refreshTokenDuration;
    private final RefreshTokenRepository refreshTokenRepository;

    @Autowired
    public JwtServiceImpl(@Value("${jwt.secret}") String secretKey,
            @Value("${jwt.access-token-duration}") Duration accessTokenDuration,
            @Value("${jwt.refresh-token-duration}") Duration refreshTokenDuration,
            RefreshTokenRepository refreshTokenRepository) {
        this.secretKey = secretKey;
        this.accessTokenDuration = accessTokenDuration;
        this.refreshTokenDuration = refreshTokenDuration;
        this.refreshTokenRepository = refreshTokenRepository;
    }

    @Override
    public String createAccessToken(String email) {
        return JWT.create()
                .withIssuer("nadeuri-api")
                .withClaim("email", email)
                .withExpiresAt(new Date(System.currentTimeMillis() + (accessTokenDuration.toMillis())))
                .sign(Algorithm.HMAC512(secretKey));
    }

    @Override
    public String createAndSaveRefreshToken(String email) {
        String jwt = JWT.create()
                .withIssuer("nadeuri-api")
                .withClaim("email", email)
                .withExpiresAt(new Date(System.currentTimeMillis() + (refreshTokenDuration.toMillis())))
                .sign(Algorithm.HMAC512(secretKey));

        return refreshTokenRepository.save(email, jwt, refreshTokenDuration);
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
    public void deleteRefreshToken(String email) {
        refreshTokenRepository.deleteByEmail(email);        
    }
}
