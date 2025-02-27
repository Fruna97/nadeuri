package com.github.fruna97.nadeuri.dto;

import com.github.fruna97.nadeuri.domain.Member;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SignUpDto {

    private String email;
    private String password;
    private String username;

    public Member toEntity() {
        return Member.builder()
                .email(email)
                .password(password)
                .username(username)
                .build();
    }
}
