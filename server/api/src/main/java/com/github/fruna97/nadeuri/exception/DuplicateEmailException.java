package com.github.fruna97.nadeuri.exception;

public class DuplicateEmailException extends RuntimeException {
    private DuplicateEmailException(String email) {
        super("이미 존재하는 이메일 입니니다: " + email);
    }
}
