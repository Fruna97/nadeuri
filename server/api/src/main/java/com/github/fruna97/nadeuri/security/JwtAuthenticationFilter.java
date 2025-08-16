package com.github.fruna97.nadeuri.security;

import java.io.IOException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.dto.SignInDto;
import com.github.fruna97.nadeuri.service.JwtService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JwtAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

    private final JwtService jwtService;

    public JwtAuthenticationFilter(String defaultFilterProcessesUrl, AuthenticationManager authenticationManager, JwtService jwtService) {
        super(defaultFilterProcessesUrl, authenticationManager);
        this.jwtService = jwtService;
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException {

        try {
            final ObjectMapper deserializer = new ObjectMapper();
            final SignInDto signInDto = deserializer.readValue(request.getInputStream(), SignInDto.class);

            UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(
                    signInDto.getEmail(), signInDto.getPassword());

            return super.getAuthenticationManager()
                    .authenticate(usernamePasswordAuthenticationToken);
        } catch (IOException e) {
            throw new BadCredentialsException("요청이 유효하지 않습니다.");
        }
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
            Authentication authResult) throws IOException, ServletException {

        PrincipalDetails principalDetails = (PrincipalDetails) authResult.getPrincipal();

        String accessToken = jwtService.createAccessToken(principalDetails.getUsername());
        response.addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken);

        ResponseDto<Void> responseDto = ResponseDto.<Void>builder()
                .message("성공적으로 로그인이 됐습니다.")
                .data(null)
                .build();
        final ObjectMapper serializer = new ObjectMapper();
        response.getWriter().write(serializer.writeValueAsString(responseDto));
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
    }

    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException failed) throws IOException, ServletException {
        log.warn(failed.getMessage());

        String message;

        if (failed instanceof BadCredentialsException)
            message = failed.getMessage();
        else
            message = "이메일 또는 비밀번호가 유효하지 않습니다.";

        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

        ResponseDto<Void> responseDto = ResponseDto.<Void>builder()
                .message(message)
                .data(null)
                .build();
        final ObjectMapper serializer = new ObjectMapper();
        response.getWriter().write(serializer.writeValueAsString(responseDto));
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
    }
}
