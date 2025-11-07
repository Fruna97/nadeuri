package com.github.fruna97.nadeuri.domain.auth.service;

import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import com.github.fruna97.nadeuri.domain.auth.dto.SignInRequest;
import com.github.fruna97.nadeuri.domain.auth.dto.TokenResponse;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@Service
public class AuthServiceImpl implements AuthService {

    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    @Autowired
    public AuthServiceImpl(AuthenticationManager authenticationManager, JwtService jwtService) {
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
    }

    @Override
    public TokenResponse signIn(SignInRequest signInRequest) {
        String email = signInRequest.getEmail();
        String password = signInRequest.getPassword();

        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(email, password);
        Authentication authentication = authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
        UUID uuid = principalDetails.getUuid();

        String accessToken = jwtService.createAccessToken(uuid);
        String refreshToken = jwtService.createAndSaveRefreshToken(uuid);

        return TokenResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken).build();
    }
}
