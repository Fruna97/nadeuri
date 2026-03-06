package com.github.fruna97.nadeuri.domain.nadeuri.repository;

import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Invite;

public interface InviteRepository extends JpaRepository<Invite, Long> {

    Optional<Invite> findByUuid(UUID inviteUuid);

    boolean existsByNadeuri_UuidAndInvitee_Uuid(UUID nadeuriUuid, UUID inviteeUuid);
}
