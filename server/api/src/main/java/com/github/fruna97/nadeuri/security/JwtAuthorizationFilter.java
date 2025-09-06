package com.github.fruna97.nadeuri.security;

import java.io.IOException;
import java.util.Optional;
import java.util.UUID;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.repository.MemberRepository;
import com.github.fruna97.nadeuri.service.JwtService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JwtAuthorizationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final MemberRepository memberRepository;

    public JwtAuthorizationFilter(JwtService jwtService, MemberRepository memberRepository) {
        this.jwtService = jwtService;
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

        String accessToken = jwtHeader.replace("Bearer ", "");
        Optional<DecodedJWT> verifiedToken = jwtService.verifyToken(accessToken);
        if (verifiedToken.isEmpty()) {
            chain.doFilter(request, response);
            return;
        }

        String tokenType = verifiedToken.get().getClaim("type").asString();
        if (!tokenType.equals("access")) {
            chain.doFilter(request, response);
            return;
        }

        UUID uuid = UUID.fromString(verifiedToken.get().getSubject());
        Optional<Member> member = memberRepository.findByUuid(uuid);
        if (member.isEmpty()) {
            log.warn("존재하지 않는 회원의 JWT 요청이 발생 : " + uuid.toString());
            chain.doFilter(request, response);
            return;
        }

        PrincipalDetails principalDetails = new PrincipalDetails(member.get());
        // 임의로 인증된 객체 생성 (UsernamePasswordAuthenticationToken의 권장되는 생성 방식은 아니지만, 앞전의 AccessToken 검증을 근거로 둠)
        Authentication authentication = new UsernamePasswordAuthenticationToken(principalDetails, null, null);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        chain.doFilter(request, response);
    }
}
