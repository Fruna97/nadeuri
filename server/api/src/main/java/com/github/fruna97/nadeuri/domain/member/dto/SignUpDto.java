package com.github.fruna97.nadeuri.domain.member.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
// 요청에 담긴 데이터의 Deserialize를 위한 생성자
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class SignUpDto {

    @NotBlank
    @Email
    private String email;

    @NotBlank
    @Size(min = 9, message = "비밀번호는 9자 이상 이여야 합니다")
    private String password;

    private String nickname;
}
