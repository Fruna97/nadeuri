package com.github.fruna97.nadeuri;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;
import lombok.extern.slf4j.Slf4j;

@RestControllerAdvice
@Slf4j
public class CustomExceptionHandler {

    @ExceptionHandler(DuplicateEmailException.class)
    public ResponseEntity<ResponseDto> duplicateEmailHandler(DuplicateEmailException e) {
        log.warn("중복된 이메일 가입 요청 : " + e.getMessage());
        return ResponseEntity
            .badRequest()
            .body(new ResponseDto(e.getMessage()));
    }
}