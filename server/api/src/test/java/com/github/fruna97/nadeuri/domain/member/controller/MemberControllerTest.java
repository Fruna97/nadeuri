package com.github.fruna97.nadeuri.domain.member.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.member.dto.SignUpRequest;
import com.github.fruna97.nadeuri.domain.member.service.MemberService;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@ExtendWith(MockitoExtension.class)
class MemberControllerTest {

    @Mock
    private MemberService memberService;

    @InjectMocks
    private MemberController memberController;

    @Test
    void signUp() {
        // Given
        String email = "test_email@test.com";
        String password = "test_password";
        String nickname = "test_nickname";
        SignUpRequest signUpRequest = SignUpRequest.builder()
                .email(email)
                .password(password)
                .nickname(nickname).build();

        // When
        ResponseEntity<ResponseDto<Void>> result = memberController.signUp(signUpRequest);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환하는지
        verify(memberService, times(1)).signUp(signUpRequest); // [MemberService.signUp] 메서드를 한 번 호출했는지
    }

    @Test
    void signUp_중복이메일() {
        // Given
        String email = "duplicated_email@test.com";
        String password = "test_password";
        String nickname = "test_nickname";
        SignUpRequest signUpRequest = SignUpRequest.builder()
                .email(email)
                .password(password)
                .nickname(nickname).build();
        
        doThrow(new DuplicateEmailException(email)).when(memberService).signUp(signUpRequest);

        // When
        // Then
        assertThrows(DuplicateEmailException.class, () -> memberController.signUp(signUpRequest)); // [MemberService.signUp]에서 발생한 중복 이메일 예외를 그대로 전파하는지
    }

    @Test
    void getMyProfile() {
        // Given
        long id = 0L;
        UUID uuid = UUID.randomUUID();
        String email = "test_email@test.com";
        String password = "test_password";
        String nickname = "test_nickname";
        String profileImageUrl = "test_url";
        PrincipalDetails principalDetails = new PrincipalDetails(id, uuid, email, password);

        MemberSummaryResponse memberSummaryResponse = MemberSummaryResponse.builder()
                .uuid(uuid)
                .email(email)
                .nickname(nickname)
                .profileImageUrl(profileImageUrl).build();
        when(memberService.getMyProfile(principalDetails)).thenReturn(memberSummaryResponse);

        // When
        ResponseEntity<ResponseDto<MemberSummaryResponse>> result = memberController.getMyProfile(principalDetails);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환하는지
        ResponseDto<MemberSummaryResponse> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getData()).isEqualTo(memberSummaryResponse); // 응답 본문의 데이터가 [MemberService.getMyProfile]이 반환한 [MemberSummaryResponse]와 동일한지
    }
}
