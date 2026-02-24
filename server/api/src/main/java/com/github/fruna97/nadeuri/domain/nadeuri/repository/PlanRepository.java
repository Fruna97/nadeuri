package com.github.fruna97.nadeuri.domain.nadeuri.repository;

import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Plan;

public interface PlanRepository extends JpaRepository<Plan, Long> {

    Optional<Plan> findByUuid(UUID uuid);
}
