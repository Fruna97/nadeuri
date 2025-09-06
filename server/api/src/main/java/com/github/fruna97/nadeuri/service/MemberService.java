package com.github.fruna97.nadeuri.service;

import java.util.Map;
import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.dto.SignUpDto;

public interface MemberService {

    Member signUp(SignUpDto signUpDto);

    Map<String, String> signIn(String email, String password);
}
