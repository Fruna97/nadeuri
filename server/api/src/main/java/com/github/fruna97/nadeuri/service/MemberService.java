package com.github.fruna97.nadeuri.service;

import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.dto.SignUpDto;

public interface MemberService {

    Member signUp(SignUpDto signUpDto);
}
