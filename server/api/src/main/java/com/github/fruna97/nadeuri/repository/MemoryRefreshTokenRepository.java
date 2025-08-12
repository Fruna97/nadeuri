package com.github.fruna97.nadeuri.repository;

import java.time.Duration;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import org.springframework.stereotype.Repository;

@Repository
public class MemoryRefreshTokenRepository implements RefreshTokenRepository {

    private static Map<String, String> store = new ConcurrentHashMap<>();

    @Override
    public String save(String email, String refreshToken, Duration timeout) {
        store.put(email, refreshToken);
        return refreshToken;
    }

    @Override
    public Optional<String> findByEmail(String email) {
        String refreshToken = store.get(email);
        return Optional.ofNullable(refreshToken);
    }

    @Override
    public void deleteByEmail(String email) {
        store.remove(email);
    }

    public static void clear() {
        store.clear();
    }
}
