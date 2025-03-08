package com.github.fruna97.nadeuri.dto;

import com.github.fruna97.nadeuri.domain.Member;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SignUpDto {

    @NotBlank
    @Email
    private String email;
    @NotBlank
    @Size(min = 9, message = "비밀번호는 9자 이상 이여야 합니다")
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
