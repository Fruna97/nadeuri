package com.github.fruna97.nadeuri.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.intercept.AuthorizationFilter;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.domain.member.service.JwtService;
import com.github.fruna97.nadeuri.security.filter.JwtAuthorizationFilter;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http,
        AuthenticationManager authenticationManager, 
        JwtService jwtService, 
        MemberRepository memberRepository) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .cors(cors -> cors.disable())
                .sessionManagement(sessionManagement -> sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .formLogin(formLogin -> formLogin.disable())
                .httpBasic(httpBasic -> httpBasic.disable());

        http
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/member/signin").permitAll()
                        .requestMatchers("/member/signup").permitAll()
                        .requestMatchers("/member/reissue-token").permitAll()
                        .requestMatchers("/error").permitAll()
                        .anyRequest().authenticated());

        http.addFilterBefore(new JwtAuthorizationFilter(jwtService, memberRepository), AuthorizationFilter.class);

        http.exceptionHandling((exceptionHandling) -> exceptionHandling
                .authenticationEntryPoint((request, response, authException) -> {
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

                    ResponseDto<Void> responseDto = ResponseDto.<Void>builder()
                            .message(authException.getLocalizedMessage())
                            .data(null)
                            .build();
                    final ObjectMapper serializer = new ObjectMapper();
                    response.getWriter().write(serializer.writeValueAsString(responseDto));
                    response.setContentType(MediaType.APPLICATION_JSON_VALUE);
                }));

        return http.build();
    }
}
