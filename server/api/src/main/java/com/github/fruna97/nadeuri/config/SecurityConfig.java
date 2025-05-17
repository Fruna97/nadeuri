package com.github.fruna97.nadeuri.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.intercept.AuthorizationFilter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.github.fruna97.nadeuri.JwtAuthenticationFilter;
import com.github.fruna97.nadeuri.JwtAuthorizationFilter;
import com.github.fruna97.nadeuri.repository.MemberRepository;

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
                        .anyRequest().authenticated());

        http.with(new MyCustomDsl(memberRepository), dsl -> {});

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
