package com.github.fruna97.nadeuri.repository;

import java.time.Duration;
import java.util.Optional;
import java.util.UUID;

public interface RefreshTokenRepository {
    String save(UUID uuid, String refreshToken, Duration duration);
    Optional<String> findByUuid(UUID uuid);
    void deleteByUuid(UUID uuid);
}
