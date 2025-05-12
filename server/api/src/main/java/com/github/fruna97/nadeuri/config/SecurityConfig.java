package com.github.fruna97.nadeuri.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.github.fruna97.nadeuri.JwtAuthenticationFilter;

@Configuration
public class SecurityConfig {

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .sessionManagement(sessionManagement -> sessionManagement.disable())
                .formLogin(formLogin -> formLogin.disable())
                .httpBasic(httpBasic -> httpBasic.disable());

        http
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/member/login").permitAll()
                        .requestMatchers("/member/signup").permitAll()
                        .requestMatchers("/login").permitAll()
                        .anyRequest().authenticated());

        http.with(new MyCustomDsl(), dsl -> {});

        return http.build();
    }

    @Bean
    BCryptPasswordEncoder bcCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // AuthenticationManager가 생성된 후 가져오기 위해 작성한 Custom DSL
    class MyCustomDsl extends AbstractHttpConfigurer<MyCustomDsl, HttpSecurity> {

        @Override
        public void configure(HttpSecurity http) throws Exception {
            AuthenticationManager authenticationManager = http.getSharedObject(AuthenticationManager.class);
            http.addFilter(new JwtAuthenticationFilter(authenticationManager));
        }
    }
}
