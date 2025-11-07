package com.github.fruna97.nadeuri.security.filter;

import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;
import java.io.IOException;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpHeaders;
import org.springframework.mock.web.MockFilterChain;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import com.github.fruna97.nadeuri.domain.auth.service.JwtService;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import jakarta.servlet.ServletException;

@ExtendWith(MockitoExtension.class)
class JwtAuthorizationFilterTest {

    @Mock
    private JwtService jwtService;

    @InjectMocks
    private JwtAuthorizationFilter jwtAuthorizationFilter;

    @BeforeEach
    void beforeEach() {
        SecurityContextHolder.clearContext();
    }

    @Test
    void doFilterInternal() throws IOException, ServletException {
        // Given
        String accessToken = "test_access_token";
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader(HttpHeaders.AUTHORIZATION, "Bearer "  + accessToken);
        MockHttpServletResponse response = new MockHttpServletResponse();
        MockFilterChain filterChain = new MockFilterChain();

        PrincipalDetails principalDetails =
                new PrincipalDetails(0L, UUID.randomUUID(), "test_email@test.com", "test_password");
        Authentication authentication =
                new UsernamePasswordAuthenticationToken(principalDetails, null, null);
        when(jwtService.getAuthenticationFromAccessToken(accessToken))
                .thenReturn(Optional.of(authentication));

        // When
        jwtAuthorizationFilter.doFilter(request, response, filterChain);

        // Then
        assertTrue(SecurityContextHolder.getContext().getAuthentication().isAuthenticated()); // 인증헤더가 정상일 때 [SecurityContext]에 정상적인 인증정보를 설정하는지
    }

    @Test
    void doFilterInternal_빈인증헤더() throws IOException, ServletException {
        // Given
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();
        MockFilterChain filterChain = new MockFilterChain();

        // When
        jwtAuthorizationFilter.doFilter(request, response, filterChain);

        // Then
        assertNull(SecurityContextHolder.getContext().getAuthentication()); // 인증헤더가 비어있을 때 [SecurityContext]의 인증정보가 null인지
    }

    @Test
    void doFilterInternal_올바르지않은인증헤더() throws IOException, ServletException {
        // Given
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader(HttpHeaders.AUTHORIZATION, "invalid_header");
        MockHttpServletResponse response = new MockHttpServletResponse();
        MockFilterChain filterChain = new MockFilterChain();

        // When
        jwtAuthorizationFilter.doFilter(request, response, filterChain);

        // Then
        assertNull(SecurityContextHolder.getContext().getAuthentication()); // 인증헤더가 올바르지 않을 때 [SecurityContext]의 인증정보가 null인지
    }

    @Test
    void doFilterInternal_유효하지않은토큰() throws IOException, ServletException {
        // Given
        String accessToken = "invalid_test_access_token";
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader(HttpHeaders.AUTHORIZATION, "Bearer "  + accessToken);
        MockHttpServletResponse response = new MockHttpServletResponse();
        MockFilterChain filterChain = new MockFilterChain();

        when(jwtService.getAuthenticationFromAccessToken(accessToken))
                .thenReturn(Optional.empty());

        // When
        jwtAuthorizationFilter.doFilter(request, response, filterChain);

        // Then
        assertNull(SecurityContextHolder.getContext().getAuthentication()); // [jwtService.getAuthenticationFromAccessToken]가 인증정보를 반환하지 않을 때 [SecurityContext]의 인증정보가 null인지
    }
}
