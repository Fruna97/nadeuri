package com.github.fruna97.nadeuri.repository;

import java.time.Duration;
import java.util.Optional;

public interface RefreshTokenRepository {
    String save(String email, String refreshToken, Duration duration);
    Optional<String> findByEmail(String email);
    void deleteByEmail(String email);
}
