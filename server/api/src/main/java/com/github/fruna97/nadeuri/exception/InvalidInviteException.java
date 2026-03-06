package com.github.fruna97.nadeuri.exception;

import lombok.Getter;

@Getter
public class InvalidInviteException extends RuntimeException {

    private InvalidInviteExceptionCode invalidInviteExceptionCode;

    public InvalidInviteException(InvalidInviteExceptionCode invalidInviteExceptionCode) {
        super(invalidInviteExceptionCode.getMessage());
        this.invalidInviteExceptionCode = invalidInviteExceptionCode;
    }
}
