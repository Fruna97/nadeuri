package com.github.fruna97.nadeuri.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.github.fruna97.nadeuri.repository.MemberRepository;
import com.github.fruna97.nadeuri.repository.MemoryMemberRepository;
import com.github.fruna97.nadeuri.repository.MemoryRefreshTokenRepository;
import com.github.fruna97.nadeuri.repository.RefreshTokenRepository;

@Configuration
public class AppConfig {

    @Bean
    MemberRepository memberRepository() {
        return new MemoryMemberRepository();
    }

    @Bean
    RefreshTokenRepository refreshTokenRepository() {
        return new MemoryRefreshTokenRepository();
    }
}
