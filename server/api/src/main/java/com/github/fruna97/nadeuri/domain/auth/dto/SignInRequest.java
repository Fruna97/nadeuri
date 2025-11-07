package com.github.fruna97.nadeuri.domain.auth.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@ToString
public class SignInRequest {

    @NotBlank
    @Email
    private String email;

    @NotBlank
    @Size(min = 9, message = "비밀번호는 9자 이상 이여야 합니다")
    private String password;
}
