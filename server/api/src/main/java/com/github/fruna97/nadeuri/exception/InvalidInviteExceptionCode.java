package com.github.fruna97.nadeuri.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum InvalidInviteExceptionCode {
    SELF_INVITE_NOT_ALLOWED("자기 자신을 초대할 수 없습니다."),
    ALREADY_PARTICIPATING("이미 나들이에 참가 중인 회원입니다."),
    DUPLICATE_INVITE("이미 초대한 회원입니다.");

    private String message;
}
