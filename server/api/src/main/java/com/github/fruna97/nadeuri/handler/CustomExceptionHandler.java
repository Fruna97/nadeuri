package com.github.fruna97.nadeuri.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
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
    public ResponseEntity<ResponseDto<Void>> duplicateEmailHandler(DuplicateEmailException e) {
        log.warn("중복된 이메일 가입 요청 : " + e.getMessage());
        return ResponseEntity
                .status(HttpStatus.CONFLICT)
                .body(ResponseDto.<Void>builder()
                        .message(e.getMessage())
                        .data(null)
                        .build());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ResponseDto<Map<String, List<String>>>> requestValidationHandler(
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
                .body(ResponseDto.<Map<String, List<String>>>builder()
                        .message("유효성 검사에 실패했습니다.")
                        .data(errorMap)
                        .build());
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ResponseDto<Void>> httpMessageNotReadableException(HttpMessageNotReadableException e) {
        return ResponseEntity
                .badRequest()
                .body(ResponseDto.<Void>builder()
                        .message(e.getMessage())
                        .data(null)
                        .build());
    }
}
