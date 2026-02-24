package com.github.fruna97.nadeuri.domain.member.service;

import java.util.UUID;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.member.dto.SignUpRequest;

public interface MemberService {

    void signUp(SignUpRequest signUpRequest);

    MemberSummaryResponse getMyProfile(UUID memberUuid);
}
