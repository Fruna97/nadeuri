package com.github.fruna97.nadeuri.repository;

import java.util.Optional;
import java.util.UUID;
import com.github.fruna97.nadeuri.domain.Member;

public interface MemberRepository {
    Member save(Member member);

    Optional<Member> findById(Long id);

    Optional<Member> findByUuid(UUID uuid);

    Optional<Member> findByEmail(String email);
}
