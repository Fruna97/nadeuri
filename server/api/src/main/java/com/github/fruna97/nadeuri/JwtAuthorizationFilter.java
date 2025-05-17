package com.github.fruna97.nadeuri;

import java.io.IOException;
import java.util.Optional;

import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.repository.MemberRepository;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JwtAuthorizationFilter extends OncePerRequestFilter {

    private final MemberRepository memberRepository;

    public JwtAuthorizationFilter(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String jwtHeader = request.getHeader(HttpHeaders.AUTHORIZATION);

        if (jwtHeader == null || !jwtHeader.startsWith("Bearer")) {
            chain.doFilter(request, response);
            return;
        }

        try {
            String jwt = jwtHeader.replace("Bearer ", "");
            String email = JWT.require(Algorithm.HMAC512("nadeuri")).build().verify(jwt).getClaim("email").asString(); // TODO: 하드코딩한 비밀키 수정
            Optional<Member> optionalMember = memberRepository.findByEmail(email);

            if (optionalMember.isPresent()) {
                Member member = optionalMember.get();
                PrincipalDetails principalDetails = new PrincipalDetails(member);
                // 임의로 인증된 객체 생성
                // 해당 생성자의 권장되는 방식은 아니지만, 앞전의 JWT의 서명 검증을 근거로 둠
                Authentication authentication = new UsernamePasswordAuthenticationToken(principalDetails, null, null);

                SecurityContextHolder.getContext().setAuthentication(authentication);

                chain.doFilter(request, response);
            } else {
                throw new JWTVerificationException("존재하지 않는 회원의 JWT 요청이 발생하였습니다. : " + email);
            }

        } catch (JWTVerificationException e) {
            log.warn(e.getMessage());

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

            ResponseDto<Void> responseDto = ResponseDto.<Void>builder()
                    .message("토큰이 유효하지 않습니다.")
                    .data(null)
                    .build();
            final ObjectMapper serializer = new ObjectMapper();
            response.getWriter().write(serializer.writeValueAsString(responseDto));
        }
    }
}
