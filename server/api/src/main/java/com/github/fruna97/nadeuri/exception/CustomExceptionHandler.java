package com.github.fruna97.nadeuri.exception;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import com.github.fruna97.nadeuri.common.dto.ResourceNotFoundError;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.extern.slf4j.Slf4j;

@RestControllerAdvice
@Slf4j
public class CustomExceptionHandler {

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
                .unprocessableEntity()
                .body(ResponseDto.<Map<String, List<String>>>builder()
                        .message("유효성 검사에 실패했습니다.")
                        .data(errorMap).build());
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ResponseDto<Void>> httpMessageNotReadableException(HttpMessageNotReadableException e) {
        return ResponseEntity
                .badRequest()
                .body(ResponseDto.<Void>builder()
                        .message(e.getMessage())
                        .data(null).build());
    }

    @ExceptionHandler(DuplicateEmailException.class)
    public ResponseEntity<ResponseDto<Void>> duplicateEmailHandler(DuplicateEmailException e) {
        log.warn("중복된 이메일 가입 요청 : " + e.getMessage());
        return ResponseEntity
                .status(HttpStatus.CONFLICT)
                .body(ResponseDto.<Void>builder()
                        .message(e.getMessage())
                        .data(null).build());
    }

    @ExceptionHandler(InvalidInviteException.class)
    public ResponseEntity<ResponseDto<Void>> invalidInviteExceptionHandler(InvalidInviteException e) {
        log.warn("유효하지 않은 초대 : Code : {}, Message : {}", e.getInvalidInviteExceptionCode(),
                e.getInvalidInviteExceptionCode().getMessage());
        HttpStatus status = switch (e.getInvalidInviteExceptionCode()) {
            case SELF_INVITE_NOT_ALLOWED -> HttpStatus.BAD_REQUEST;
            case ALREADY_PARTICIPATING, DUPLICATE_INVITE -> HttpStatus.CONFLICT;
        };

        return ResponseEntity
                .status(status)
                .body(ResponseDto.<Void>builder()
                        .message(e.getMessage())
                        .data(null).build());
    }

    @ExceptionHandler(EntityNotFoundException.class)
    public ResponseEntity<ResponseDto<Void>> entityNotFoundHandler(EntityNotFoundException e) {
        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(ResponseDto.<Void>builder()
                        .message("요청한 리소스가 존재하지 않습니다.")
                        .data(null).build());
    }

    @ExceptionHandler(MemberNotFoundException.class)
    public ResponseEntity<ResponseDto<ResourceNotFoundError>> memberNotFoundHandler(
            MemberNotFoundException e) {
        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(ResponseDto.<ResourceNotFoundError>builder()
                        .message("해당하는 회원이 존재하지 않습니다.")
                        .data(ResourceNotFoundError.builder()
                                .resource("MEMBER").build()).build());
    }

    @ExceptionHandler(NadeuriNotFoundException.class)
    public ResponseEntity<ResponseDto<ResourceNotFoundError>> nadeuriNotFoundHandler(
            NadeuriNotFoundException e) {
        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(ResponseDto.<ResourceNotFoundError>builder()
                        .message("해당하는 나들이가 존재하지 않습니다.")
                        .data(ResourceNotFoundError.builder()
                                .resource("NADEURI").build()).build());
    }

    @ExceptionHandler(PlanNotFoundException.class)
    public ResponseEntity<ResponseDto<ResourceNotFoundError>> planNotFoundHandler(
            PlanNotFoundException e) {
        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(ResponseDto.<ResourceNotFoundError>builder()
                        .message("해당하는 일정이 존재하지 않습니다.")
                        .data(ResourceNotFoundError.builder()
                                .resource("PLAN").build()).build());
    }

    @ExceptionHandler(InviteNotFoundException.class)
    public ResponseEntity<ResponseDto<ResourceNotFoundError>> inviteNotFoundHandler(
            InviteNotFoundException e) {
        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(ResponseDto.<ResourceNotFoundError>builder()
                        .message("해당하는 초대가 존재하지 않습니다.")
                        .data(ResourceNotFoundError.builder()
                                .resource("INVITE").build()).build());
    }

    @ExceptionHandler(PlanNotFoundInNadeuriException.class)
    public ResponseEntity<ResponseDto<Void>> planNotFoundInNadeuriHandler(PlanNotFoundInNadeuriException e) {
        log.warn("비정상적인 요청 발생: Nadeuri에 포함되지 않은 일정 조회 요청");
        return ResponseEntity
                .status(HttpStatus.FORBIDDEN)
                .body(ResponseDto.<Void>builder()
                        .message("접근 권한이 없습니다.")
                        .build());
    }

    @ExceptionHandler(AuthenticationException.class)
    public void authenticationExceptionHandler(AuthenticationException e) throws AuthenticationException {
        throw e;
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ResponseDto<Void>> commonHandler(Exception e) {
        log.error("처리되지 않은 예외 발생 :", e);

        return ResponseEntity
                .internalServerError()
                .body(ResponseDto.<Void>builder()
                        .message("Internal Server Error")
                        .data(null).build());
    }
}
