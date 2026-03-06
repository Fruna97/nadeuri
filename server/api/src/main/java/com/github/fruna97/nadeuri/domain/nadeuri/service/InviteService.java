package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.UUID;
import com.github.fruna97.nadeuri.domain.member.dto.CreateInviteRequest;

public interface InviteService {

    void createInvite(UUID memberUuid, UUID nadeuriUuid, CreateInviteRequest createInviteRequest);

    void acceptInvite(UUID memberUuid, UUID nadeuriUuid, UUID inviteUuid);

    void rejectInvite(UUID memberUuid, UUID nadeuriUuid, UUID inviteUuid);
}
