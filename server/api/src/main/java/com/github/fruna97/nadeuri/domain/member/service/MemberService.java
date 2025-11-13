package com.github.fruna97.nadeuri.domain.member.service;

import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.member.dto.SignUpRequest;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

public interface MemberService {

    void signUp(SignUpRequest signUpRequest);

    MemberSummaryResponse getMyProfile(PrincipalDetails principalDetails);
}
