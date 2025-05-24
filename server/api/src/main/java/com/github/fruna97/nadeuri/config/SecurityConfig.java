package com.github.fruna97.nadeuri.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.intercept.AuthorizationFilter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.repository.MemberRepository;
import com.github.fruna97.nadeuri.security.JwtAuthenticationFilter;
import com.github.fruna97.nadeuri.security.JwtAuthorizationFilter;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
public class SecurityConfig {

    private final MemberRepository memberRepository;

    @Autowired
    public SecurityConfig(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .sessionManagement(
                        sessionManagement -> sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .formLogin(formLogin -> formLogin.disable())
                .httpBasic(httpBasic -> httpBasic.disable());

        http
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/member/signin").permitAll()
                        .requestMatchers("/member/signup").permitAll()
                        .requestMatchers("/error").permitAll()
                        .anyRequest().authenticated());

        http.with(new MyCustomDsl(memberRepository), dsl -> {});

        http.exceptionHandling((exceptionHandling) -> exceptionHandling
                .authenticationEntryPoint(
                        (request, response, authException) -> {
                            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

                            ResponseDto<Void> responseDto = ResponseDto.<Void>builder()
                                    .message("인증 정보가 유효하지 않습니다.")
                                    .data(null)
                                    .build();
                            final ObjectMapper serializer = new ObjectMapper();
                            response.getWriter().write(serializer.writeValueAsString(responseDto));
                            response.setContentType(MediaType.APPLICATION_JSON_VALUE);
                        }));

        return http.build();
    }

    @Bean
    BCryptPasswordEncoder bcCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // AuthenticationManager가 생성된 후 가져오기 위해 작성한 Custom DSL
    private class MyCustomDsl extends AbstractHttpConfigurer<MyCustomDsl, HttpSecurity> {

        private final MemberRepository memberRepository;

        MyCustomDsl(MemberRepository memberRepository) {
            this.memberRepository = memberRepository;
        }

        @Override
        public void configure(HttpSecurity http) throws Exception {
            AuthenticationManager authenticationManager = http.getSharedObject(AuthenticationManager.class);
            http
                    .addFilterBefore(new JwtAuthenticationFilter("/member/signin", authenticationManager),
                            UsernamePasswordAuthenticationFilter.class)
                    .addFilterBefore(new JwtAuthorizationFilter(memberRepository), AuthorizationFilter.class);
        }
    }
}
