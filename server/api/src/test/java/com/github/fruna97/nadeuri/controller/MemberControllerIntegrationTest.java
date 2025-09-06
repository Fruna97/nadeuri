package com.github.fruna97.nadeuri.controller;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Stream;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.repository.MemberRepository;
import com.github.fruna97.nadeuri.repository.MemoryMemberRepository;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class MemberControllerIntegrationTest {

    @Autowired
    MemberRepository memberRepository;

    @BeforeEach
    void beforeEach() {
        if (memberRepository instanceof MemoryMemberRepository) {
            MemoryMemberRepository.clear();
        }
    }

    @Test
    void signUp(@Autowired TestRestTemplate restTemplate) {
        // Given
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        String requestBody = """
                {
                    "email": "test_eamil@test.com",
                    "password": "test_password",
                    "nickname": "test_nickname"
                }
                """;
        HttpEntity<String> request = new HttpEntity<>(requestBody, headers);

        // When
        ResponseEntity<ResponseDto> response = restTemplate.exchange(
                "/member/signup",
                HttpMethod.POST,
                request,
                ResponseDto.class);
        HttpStatusCode statusCode = response.getStatusCode();
        ResponseDto responseBody = Optional.ofNullable(response.getBody()).get();

        // Then
        assertThat(statusCode).isEqualTo(HttpStatus.OK);
        assertThat(responseBody.getMessage()).isEqualTo("회원가입 성공");
    }

    @Test
    void signUpWithDuplicatedEmail(@Autowired TestRestTemplate restTemplate) {
        // Given
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String requestBody1 = """
                {
                    "email": "test_eamil@test.com",
                    "password": "test_password",
                    "nickname": "test_nickname"
                }
                """;
        HttpEntity<String> request1 = new HttpEntity<>(requestBody1, headers);

        String requestBody2 = """
                {
                    "email": "test_eamil@test.com",
                    "password": "test_password",
                    "nickname": "test_nickname"
                }
                """;
        HttpEntity<String> request2 = new HttpEntity<>(requestBody2, headers);

        // When
        restTemplate.exchange(
                "/member/signup",
                HttpMethod.POST,
                request1,
                ResponseDto.class);

        ResponseEntity<ResponseDto> response = restTemplate.exchange(
                "/member/signup",
                HttpMethod.POST,
                request2,
                ResponseDto.class);
        HttpStatusCode statusCode = response.getStatusCode();
        ResponseDto responseBody = Optional.ofNullable(response.getBody()).get();

        // Then
        assertThat(statusCode).isEqualTo(HttpStatus.BAD_REQUEST);
        assertThat(responseBody.getMessage()).isEqualTo("이미 존재하는 이메일 입니다: test_eamil@test.com");
    }

    static Stream<Arguments> invalidRequests() {
        return Stream.of(
            // 빈 이메일
            Arguments.of(
                """
                {
                    "email": "",
                    "password": "test_password",
                    "nickname": "test_nickname"
                }
                """,
                "유효성 검사에 실패했습니다.",
                Map.of("email", List.of("공백일 수 없습니다"))
            ), 
            // 올바르지 않은 형식의 이메일
            Arguments.of(
                """
                {
                    "email": "invalid_email_format",
                    "password": "test_password",
                    "nickname": "test_nickname"
                }
                """,
                "유효성 검사에 실패했습니다.",
                Map.of("email", List.of("올바른 형식의 이메일 주소여야 합니다"))
            ), 
            // 빈 비밀번호
            Arguments.of(
                """
                {
                    "email": "test_email@test.com",
                    "password": "",
                    "nickname": "test_nickname"
                }
                """,
                "유효성 검사에 실패했습니다.",
                Map.of("password", List.of("공백일 수 없습니다", "비밀번호는 9자 이상 이여야 합니다"))
            ), 
            // 9자 미만의 비밀번호
            Arguments.of(
                    """
                    {
                        "email": "test_email@test.com",
                        "password": "under_9",
                        "nickname": "test_nickname"
                    }
                    """,
                    "유효성 검사에 실패했습니다.",
                    Map.of("password", List.of("비밀번호는 9자 이상 이여야 합니다"))
            ) 
        );
    }

    @ParameterizedTest
    @MethodSource("invalidRequests")
    void signUpWithInvalidRequests(
            String requestBody,
            String expectedMessage,
            Map<String, List<String>> expectedData,
            @Autowired TestRestTemplate restTemplate) {
        // Given
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> request = new HttpEntity<String>(requestBody, headers);

        // When
        ResponseEntity<ResponseDto> response = restTemplate.exchange(
                "/member/signup",
                HttpMethod.POST,
                request,
                ResponseDto.class);
        HttpStatusCode statusCode = response.getStatusCode();
        String message = Optional.ofNullable(response.getBody()).get().getMessage();
        Map<String, List<String>> data = (Map<String, List<String>>) Optional.ofNullable(response.getBody()).get().getData();

        // Then
        assertThat(statusCode).isEqualTo(HttpStatus.BAD_REQUEST);
        assertThat(message).isEqualTo(expectedMessage);
        data.keySet().forEach(key -> {
            assertThat(Set.copyOf(data.get(key))).isEqualTo(Set.copyOf(expectedData.get(key)));
        });
    }
}
