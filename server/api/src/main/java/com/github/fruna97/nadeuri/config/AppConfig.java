package com.github.fruna97.nadeuri.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.github.fruna97.nadeuri.domain.member.repository.MemoryRefreshTokenRepository;
import com.github.fruna97.nadeuri.domain.member.repository.RefreshTokenRepository;

@Configuration
public class AppConfig {

    @Bean
    RefreshTokenRepository refreshTokenRepository() {
        return new MemoryRefreshTokenRepository();
    }
}
