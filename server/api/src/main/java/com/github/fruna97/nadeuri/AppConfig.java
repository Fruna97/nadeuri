package com.github.fruna97.nadeuri;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.github.fruna97.nadeuri.repository.MemberRepository;
import com.github.fruna97.nadeuri.repository.MemoryMemberRepository;

@Configuration
public class AppConfig {

    @Bean
    public MemberRepository memberRepository() {
        return new MemoryMemberRepository();
    }

    @Bean
    public BCryptPasswordEncoder bcCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
