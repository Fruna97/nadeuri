package com.github.fruna97.nadeuri.repository;

import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import com.github.fruna97.nadeuri.domain.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

    Optional<Member> findByUuid(UUID uuid);

    Optional<Member> findByEmail(String email);
}
