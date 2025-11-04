package com.github.fruna97.nadeuri.domain.auth.repository;

import static org.assertj.core.api.Assertions.assertThat;
import java.util.Optional;
import java.util.UUID;
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
        UUID uuid = UUID.randomUUID();
        String refreshToken = "test_refresh_token";

        // when
        memoryRefreshTokenRepository.save(uuid, refreshToken, null);

        // then
        Optional<String> result = memoryRefreshTokenRepository.findByUuid(uuid);
        assertThat(result).get().isEqualTo(refreshToken); // Refresh Token을 정확히 저장했는지 
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
        Optional<String> result = memoryRefreshTokenRepository.findByUuid(uuid2);

        // then
        assertThat(result).get().isEqualTo(refreshToken2); // UUID로 찾아낸 Refresh Token이 정확한지
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
        assertThat(result).isNotPresent(); // UUID를 통한 삭제가 되었는지
    }
}
