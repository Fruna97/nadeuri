package com.github.fruna97.nadeuri;

import java.io.IOException;
import java.util.Date;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.dto.SignInDto;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class JwtAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

    public JwtAuthenticationFilter(String defaultFilterProcessesUrl, AuthenticationManager authenticationManager) {
        super(defaultFilterProcessesUrl, authenticationManager);
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
            e.printStackTrace();
        }

        return null;
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
            Authentication authResult) throws IOException, ServletException {

        PrincipalDetails principalDetails = (PrincipalDetails) authResult.getPrincipal();

        String jwt = JWT.create()
                .withIssuer("nadeuri-api")
                .withClaim("email", principalDetails.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis() + (1000 * 60 * 60)))
                .sign(Algorithm.HMAC512("nadeuri")); // TODO: 하드코딩한 비밀키 수정

        response.addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + jwt);
    }

    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException failed) throws IOException, ServletException {

        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

        ResponseDto<Void> responseDto = ResponseDto.<Void>builder()
                .message("이메일 또는 비밀번호가 유효하지 않습니다.")
                .data(null)
                .build();
        final ObjectMapper serializer = new ObjectMapper();
        response.getWriter().write(serializer.writeValueAsString(responseDto));
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
    }
}
