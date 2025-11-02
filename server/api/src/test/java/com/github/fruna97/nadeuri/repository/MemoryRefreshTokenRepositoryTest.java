package com.github.fruna97.nadeuri.repository;

import static org.assertj.core.api.Assertions.assertThat;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import com.github.fruna97.nadeuri.domain.member.repository.MemoryRefreshTokenRepository;

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
        UUID uuid = UUID.randomUUID();
        String refreshToken = "test_refresh_token";

        // when
        memoryRefreshTokenRepository.save(uuid, refreshToken, null);

        // then
        Optional<String> result = memoryRefreshTokenRepository.findByUuid(uuid);
        assertThat(result).isPresent();
        assertThat(result.get()).isEqualTo(refreshToken);
    }

    @Test
    void findByUuid() {
        // given
        UUID uuid1 = UUID.randomUUID();
        String refreshToken1 = "test_refresh_token_1";
        memoryRefreshTokenRepository.save(uuid1, refreshToken1, null);

        UUID uuid2 = UUID.randomUUID();
        String refreshToken2 = "test_refresh_token_2";
        memoryRefreshTokenRepository.save(uuid2, refreshToken2, null);

        // when
        Optional<String> foundToken = memoryRefreshTokenRepository.findByUuid(uuid2);

        // then
        assertThat(refreshToken2).isEqualTo(foundToken.get());
    }

    @Test
    void deleteByUuid() {
        // given
        UUID uuid = UUID.randomUUID();
        String refreshToken = "test_refresh_token";
        memoryRefreshTokenRepository.save(uuid, refreshToken, null);

        // when
        memoryRefreshTokenRepository.deleteByUuid(uuid);

        // then
        Optional<String> result = memoryRefreshTokenRepository.findByUuid(uuid);
        assertThat(result).isNotPresent();
    }
}
