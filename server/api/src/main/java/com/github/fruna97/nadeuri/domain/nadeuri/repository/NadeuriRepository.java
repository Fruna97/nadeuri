package com.github.fruna97.nadeuri.domain.nadeuri.repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;

public interface NadeuriRepository extends JpaRepository<Nadeuri, Long> {

    Optional<Nadeuri> findByUuid(UUID uuid);

    List<Nadeuri> findByMembers_Uuid(UUID uuid);
}
