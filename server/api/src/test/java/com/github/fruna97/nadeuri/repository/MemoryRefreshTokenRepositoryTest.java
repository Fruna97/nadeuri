package com.github.fruna97.nadeuri.repository;

import static org.assertj.core.api.Assertions.assertThat;
import java.util.Optional;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class MemoryRefreshTokenRepositoryTest {

    MemoryRefreshTokenRepository memoryRefreshTokenRepository;

    @BeforeEach
    void beforeEach() {
        memoryRefreshTokenRepository = new MemoryRefreshTokenRepository();
    }

    @AfterEach
    void afterEach() {
        MemoryRefreshTokenRepository.clear();
    }

    @Test
    void save() {
        // given
        String email = "test_email@test.com";
        String refreshToken = "test_refresh_token";

        // when
        memoryRefreshTokenRepository.save(email, refreshToken, null);

        // then
        Optional<String> result = memoryRefreshTokenRepository.findByEmail(email);
        assertThat(result).isPresent();
        assertThat(result.get()).isEqualTo(refreshToken);
    }

    @Test
    void findByEmail() {
        // given
        String email1 = "test_email_1@test.com";
        String refreshToken1 = "test_refresh_token_1";
        memoryRefreshTokenRepository.save(email1, refreshToken1, null);

        String email2 = "test_email_2@test.com";
        String refreshToken2 = "test_refresh_token_2";
        memoryRefreshTokenRepository.save(email2, refreshToken2, null);

        // when
        Optional<String> foundToken = memoryRefreshTokenRepository.findByEmail(email2);

        // then
        assertThat(refreshToken2).isEqualTo(foundToken.get());
    }

    @Test
    void deleteByEmail() {
        // given
        String email = "test_email@test.com";
        String refreshToken = "test_refresh_token";
        memoryRefreshTokenRepository.save(email, refreshToken, null);

        // when
        memoryRefreshTokenRepository.deleteByEmail(email);

        // then
        Optional<String> result = memoryRefreshTokenRepository.findByEmail(email);
        assertThat(result).isNotPresent();
    }
}
