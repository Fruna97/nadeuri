package com.github.fruna97.nadeuri.repository;

import java.time.Duration;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

public class MemoryRefreshTokenRepository implements RefreshTokenRepository {

    private static Map<UUID, String> store = new ConcurrentHashMap<>();

    @Override
    public String save(UUID uuid, String refreshToken, Duration timeout) {
        store.put(uuid, refreshToken);
        return refreshToken;
    }

    @Override
    public Optional<String> findByUuid(UUID uuid) {
        String refreshToken = store.get(uuid);
        return Optional.ofNullable(refreshToken);
    }

    @Override
    public void deleteByUuid(UUID uuid) {
        store.remove(uuid);
    }

    public static void clear() {
        store.clear();
    }
}
