package com.github.fruna97.nadeuri.service;

import java.util.Map;
import com.github.fruna97.nadeuri.domain.Member;

public interface MemberService {

    Member signUp(String email, String password, String nickname);

    Map<String, String> signIn(String email, String password);
}
