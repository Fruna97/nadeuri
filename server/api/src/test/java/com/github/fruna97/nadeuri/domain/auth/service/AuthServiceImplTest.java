package com.github.fruna97.nadeuri.domain.auth.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import java.util.UUID;
import org.assertj.core.api.ThrowableAssert.ThrowingCallable;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import com.github.fruna97.nadeuri.domain.auth.dto.SignInRequest;
import com.github.fruna97.nadeuri.domain.auth.dto.TokenResponse;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@ExtendWith(MockitoExtension.class)
class AuthServiceImplTest {

    @Mock
    private PrincipalDetails principalDetails;

    @Mock
    private Authentication authentication;

    @Mock
    private AuthenticationManager authenticationManager;

    @Mock
    private JwtService jwtService;

    @InjectMocks
    private AuthServiceImpl authServiceImpl;

    @Test
    void signIn() {
        // Given
        String email = "test_email@test.com";
        String password = "test_password";
        SignInRequest signInRequest = SignInRequest.builder()
                .email(email)
                .password(password).build();

        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(principalDetails);
        when(principalDetails.getUuid()).thenReturn(UUID.randomUUID());
        when(jwtService.createAccessToken(any(UUID.class))).thenReturn("test_access_token");
        when(jwtService.createAndSaveRefreshToken(any(UUID.class))).thenReturn("test_refreshToken_token");

        // When
        TokenResponse result = authServiceImpl.signIn(signInRequest);

        // Then
        assertThat(result.getAccessToken()).isNotEmpty(); // Access Token이 발급되었는지
        assertThat(result.getRefreshToken()).isNotEmpty(); // Refresh Token이 발급되었는지
    }

    @Test
    void signIn_유효하지않은회원() {
        // Given
        String email = "test_email@test.com";
        String password = "test_password";
        SignInRequest signInRequest = SignInRequest.builder()
                .email(email)
                .password(password).build();

        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenThrow(new BadCredentialsException("자격 증명에 실패하였습니다."));

        // When
        ThrowingCallable signInWithInvalidCredentials = () -> authServiceImpl.signIn(signInRequest);

        // Then
        assertThatThrownBy(signInWithInvalidCredentials).isInstanceOf(AuthenticationException.class); // 인증 예외를 throw 하는지
    }

}
