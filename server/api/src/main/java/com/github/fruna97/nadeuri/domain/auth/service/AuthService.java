package com.github.fruna97.nadeuri.domain.auth.service;

import com.github.fruna97.nadeuri.domain.auth.dto.SignInRequest;
import com.github.fruna97.nadeuri.domain.auth.dto.TokenResponse;

public interface AuthService {

    TokenResponse signIn(SignInRequest signInRequest);
}
