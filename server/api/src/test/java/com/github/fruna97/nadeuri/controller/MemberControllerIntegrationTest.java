package com.github.fruna97.nadeuri.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Stream;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.fruna97.nadeuri.dto.ResponseDto;

@SpringBootTest
@AutoConfigureMockMvc
@Transactional
class MemberControllerIntegrationTest {

    @Autowired
    MockMvc mockMvc;
    @Autowired
    ObjectMapper objectMapper;

    @Test
    void signUp() throws Exception {
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

        // When
        MockHttpServletResponse response = mockMvc
                .perform(post("/member/signup")
                    .headers(headers)
                    .content(requestBody)).andReturn().getResponse();
        

        // Then
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value()); // 회원가입이 정상적으로 이루어 지는지
    }

    @Test
    void signUpWithDuplicatedEmail() throws Exception {
        // Given
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String requestBody1 = """
                {
                    "email": "test_eamil@test.com",
                    "password": "test_password1",
                    "nickname": "test_nickname1"
                }
                """;

        String requestBody2 = """
                {
                    "email": "test_eamil@test.com",
                    "password": "test_password2",
                    "nickname": "test_nickname2"
                }
                """;

        mockMvc.perform(post("/member/signup").headers(headers).content(requestBody1));

        // When
        MockHttpServletResponse response = mockMvc.perform(post("/member/signup").headers(headers).content(requestBody2)).andReturn().getResponse();

        // Then
        assertThat(response.getStatus()).isEqualTo(HttpStatus.CONFLICT.value()); // 중복 이메일 가입 시 CONFLICT 코드를 응답 하는지
    }

    static Stream<Arguments> invalidRequests() {
        return Stream.of(
                // 빈 이메일
                Arguments.of("""
                        {
                            "email": "",
                            "password": "test_password",
                            "nickname": "test_nickname"
                        }
                        """, "유효성 검사에 실패했습니다.", Set.of("email")),
                // 올바르지 않은 형식의 이메일
                Arguments.of("""
                        {
                            "email": "invalid_email_format",
                            "password": "test_password",
                            "nickname": "test_nickname"
                        }
                        """, "유효성 검사에 실패했습니다.", Set.of("email")),
                // 빈 비밀번호
                Arguments.of("""
                        {
                            "email": "test_email@test.com",
                            "password": "",
                            "nickname": "test_nickname"
                        }
                        """, "유효성 검사에 실패했습니다.", Set.of("password")),
                // 9자 미만의 비밀번호
                Arguments.of("""
                        {
                            "email": "test_email@test.com",
                            "password": "under_9",
                            "nickname": "test_nickname"
                        }
                        """, "유효성 검사에 실패했습니다.", Set.of("password")));
    }

    @ParameterizedTest
    @MethodSource("invalidRequests")
    void signUpWithInvalidRequests(
            String requestBody,
            String expectedMessage,
            Set<String> expectedData) throws Exception {
        // Given
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // When
        MockHttpServletResponse response = mockMvc.perform(post("/member/signup").headers(headers).content(requestBody)).andReturn().getResponse();

        // Then
        ResponseDto<Map<String, List<String>>> responseDto = objectMapper.readValue(response.getContentAsString(), new TypeReference<ResponseDto<Map<String, List<String>>>>() {});
        int status = response.getStatus();
        String message = responseDto.getMessage();
        Map<String, List<String>> data = responseDto.getData();

        assertThat(status).isEqualTo(HttpStatus.BAD_REQUEST.value()); // 요청 본문 검증 실패 시 BAD_REQUEST 코드를 응답 하는지
        assertThat(message).isEqualTo(expectedMessage); // 응답 본문의 메시지가 "유효성 검사에 실패했습니다." 인지
        assertThat(data.keySet()).isEqualTo(expectedData); // 응답 본문의 데이터가 유효성 검증에 실패한 필드를 포함하는지
    }
}
