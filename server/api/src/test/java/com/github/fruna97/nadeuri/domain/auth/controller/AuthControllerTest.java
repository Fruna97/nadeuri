package com.github.fruna97.nadeuri.domain.auth.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.auth.dto.SignInRequest;
import com.github.fruna97.nadeuri.domain.auth.dto.TokenResponse;
import com.github.fruna97.nadeuri.domain.auth.service.AuthService;
import com.github.fruna97.nadeuri.domain.auth.service.JwtService;

@ExtendWith(MockitoExtension.class)
class AuthControllerTest {

    @Mock
    private AuthService authService;

    @Mock
    private JwtService jwtService;

    @InjectMocks
    private AuthController authController;

    @Captor
    private ArgumentCaptor<String> refreshTokenCaptor;

    @Test
    void signIn() {
        // Given
        String email = "test_email@test.com";
        String password = "test_password";
        SignInRequest signInRequest = SignInRequest.builder()
                .email(email)
                .password(password).build();
        
        TokenResponse tokenResponse = TokenResponse.builder()
                .accessToken("test_access_token")
                .refreshToken("test_refresh_token").build();
        when(authService.signIn(signInRequest)).thenReturn(tokenResponse); 

        // When
        ResponseEntity<ResponseDto<TokenResponse>> result = authController.signIn(signInRequest);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환하는지
        ResponseDto<TokenResponse> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getData()).isEqualTo(tokenResponse); // 응답 본문의 데이터가 [AuthService.signIn]이 반환한 [TokenResponse]와 동일한지
    }


    @Test
    void signIn_로그인실패() {
        // Given
        String email = "wrong_email@test.com";
        String password = "wrong_password";
        SignInRequest signInRequest = SignInRequest.builder()
                .email(email)
                .password(password).build();
        
        when(authService.signIn(signInRequest)).thenThrow(new BadCredentialsException("자격 증명에 실패하였습니다."));

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> authController.signIn(signInRequest)); // [AuthService.signIn]에서 발생한 인증 예외를 그대로 전파하는지
    }

    @Test
    void reissueToken() {
        // Given
        TokenResponse tokenResponse = TokenResponse.builder()
                .accessToken("new_test_access_token")
                .refreshToken("new_test_refresh_token").build();

        String refreshToken = "test_refresh_token";
        String authorizationHeader = "Bearer " + refreshToken;

        when(jwtService.reissueToken(refreshToken)).thenReturn(tokenResponse);

        // When
        ResponseEntity<ResponseDto<TokenResponse>> result = authController.reissueToken(authorizationHeader);

        // Then
        verify(jwtService).reissueToken(refreshTokenCaptor.capture()); // [JwtService.reissueToken] 메서드를 호출하는지
        assertThat(refreshTokenCaptor.getValue()).isEqualTo(refreshToken); // [JwtService.reissueToken]의 인자에 "Bearer "를 제거한 토큰 문자열만 전달하는지

        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환하는지
        ResponseDto<TokenResponse> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getData()).isEqualTo(tokenResponse); // 응답 본문의 데이터가 [JwtService.reissueToken]가 반환한 [TokenResponse]와 동일한지
    }

    @Test
    void reissueToken_빈인증헤더() {
        // Given        
        String authorizationHeader = null;

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            authController.reissueToken(authorizationHeader);
        }); // 인증헤더가 비어있을 때 인증 예외를 throw 하는지
    }

    @Test
    void reissueToken_올바르지않은인증헤더() {
        // Given        
        String authorizationHeader = "invalid_header";

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            authController.reissueToken(authorizationHeader);
        }); // 인증헤더가 올바르지 않을 때 인증 예외를 throw 하는지
    }

    @Test
    void reissueToken_유효하지않은토큰() {
        // Given        
        String refreshToken = "invalid_test_refresh_token";
        String authorizationHeader = "Bearer " + refreshToken;

        when(jwtService.reissueToken(refreshToken)).thenThrow(new BadCredentialsException("자격 증명에 실패하였습니다."));

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            authController.reissueToken(authorizationHeader);
        }); // [JwtService.reissueToken]에서 발생한 인증 예외를 그대로 전파하는지
    }
}
