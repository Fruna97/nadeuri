package com.github.fruna97.nadeuri.domain.member.service;

import java.util.Map;
import com.github.fruna97.nadeuri.domain.member.model.Member;

public interface MemberService {

    Member signUp(String email, String password, String nickname);

    Map<String, String> signIn(String email, String password);
}
