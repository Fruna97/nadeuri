package com.github.fruna97.nadeuri.domain.auth.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.auth.dto.SignInRequest;
import com.github.fruna97.nadeuri.domain.auth.dto.TokenResponse;
import com.github.fruna97.nadeuri.domain.auth.service.AuthService;
import com.github.fruna97.nadeuri.domain.auth.service.JwtService;
import jakarta.validation.Valid;

@RestController
public class AuthController {

    private final AuthService authService;
    private final JwtService jwtService;

    @Autowired
    public AuthController(AuthService authService, JwtService jwtService) {
        this.authService = authService;
        this.jwtService = jwtService;
    }

    @PostMapping("/auth/signin")
    public ResponseEntity<ResponseDto<TokenResponse>> signIn(@RequestBody @Valid SignInRequest signInRequest) {
        TokenResponse tokenResponse = authService.signIn(signInRequest);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<TokenResponse>builder()
                        .message("성공적으로 로그인이 되었습니다.")
                        .data(tokenResponse)
                        .build());
    }

    @PostMapping("/auth/reissue-token")
    public ResponseEntity<ResponseDto<TokenResponse>> reissueToken(@RequestHeader(value = HttpHeaders.AUTHORIZATION, required = false) String authorizationHeader) {
        if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }
        String refreshToken = authorizationHeader.replace("Bearer ", "");

        TokenResponse tokenResponse = jwtService.reissueToken(refreshToken);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<TokenResponse>builder()
                        .message("토큰이 재발급 되었습니다.")
                        .data(tokenResponse)
                        .build());
    }
}
