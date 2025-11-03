package com.github.fruna97.nadeuri.domain.member.service;

import com.github.fruna97.nadeuri.domain.member.dto.SignInRequest;
import com.github.fruna97.nadeuri.domain.member.dto.SignUpRequest;
import com.github.fruna97.nadeuri.domain.member.dto.TokenResponse;

public interface MemberService {

    void signUp(SignUpRequest signUpRequest);

    TokenResponse signIn(SignInRequest signInRequest);
}
