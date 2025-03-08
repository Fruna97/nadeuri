package com.github.fruna97.nadeuri;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;

import lombok.extern.slf4j.Slf4j;

@RestControllerAdvice
@Slf4j
public class CustomExceptionHandler {

    @ExceptionHandler(DuplicateEmailException.class)
    public ResponseEntity<ResponseDto<?>> duplicateEmailHandler(DuplicateEmailException e) {
        log.warn("중복된 이메일 가입 요청 : " + e.getMessage());
        return ResponseEntity.badRequest().body(new ResponseDto<>(e.getMessage(), null));
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ResponseDto<?>> signUpRequestValidationHandler(
            MethodArgumentNotValidException e) {
        // 유효성 검사에 실패한 필드와 그에 대한 에러 메시지들을 수집
        Map<String, List<String>> errorMap = new HashMap<>();
        e.getFieldErrors().forEach(error -> {
            if (errorMap.containsKey(error.getField())) {
                errorMap.get(error.getField()).add(error.getDefaultMessage());
            } else {
                List<String> data = new ArrayList<>();
                data.add(error.getDefaultMessage());
                errorMap.put(error.getField(), data);
            }
        });

        return ResponseEntity
                .badRequest()
                .body(new ResponseDto<>("유효성 검사 실패", errorMap));
    }
}
