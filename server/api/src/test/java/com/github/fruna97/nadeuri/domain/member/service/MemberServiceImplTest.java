package com.github.fruna97.nadeuri.domain.member.service;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.UUID;
import org.assertj.core.api.ThrowableAssert.ThrowingCallable;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.github.fruna97.nadeuri.domain.member.dto.SignUpRequest;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;

@ExtendWith(MockitoExtension.class)
class MemberServiceImplTest {

    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Mock
    MemberRepository memberRepository;

    MemberService memberService;

    @Captor
    ArgumentCaptor<Member> memberCaptor;

    @BeforeEach
    void beforeEach() {
        bCryptPasswordEncoder = new BCryptPasswordEncoder();
        memberService = new MemberServiceImpl(bCryptPasswordEncoder, memberRepository);
    }

    @Test
    void signUp() {
        // Given
        UUID uuid = UUID.randomUUID();
        String email = "test_email@test.com";
        String password = "test_password";
        String nickname = "test_nickname";
        SignUpRequest signUpRequest = SignUpRequest.builder()
                .email(email)
                .password(password)
                .nickname(nickname).build();
        Member savedMember = Member.builder()
                .uuid(uuid)
                .email(email)
                .password(password)
                .nickname(nickname).build();
        when(memberRepository.saveAndFlush(any(Member.class))).thenReturn(savedMember);

        // When
        memberService.signUp(signUpRequest);

        // Then
        verify(memberRepository).saveAndFlush(memberCaptor.capture()); // Repository의 [saveAndFlush]를 호출하는지
        Member capturedMember = memberCaptor.getValue();
        assertTrue(bCryptPasswordEncoder.matches(password, capturedMember.getPassword())); // 비밀번호를 암호화 하여 저장 하는지
    }

    @Test
    void signUp_중복이메일() {
        // Given
        String email = "test_email@test.com";
        String password = "test_password";
        String nickname = "test_nickname";
        SignUpRequest signUpRequest = SignUpRequest.builder()
                .email(email)
                .password(password)
                .nickname(nickname).build();
        when(memberRepository.saveAndFlush(any(Member.class))).thenThrow(DataIntegrityViolationException.class);

        // When
        ThrowingCallable signUpWithDuplicatedEmailAction = () -> memberService.signUp(signUpRequest);

        // Then
        assertThatThrownBy(signUpWithDuplicatedEmailAction)
                .isInstanceOf(DuplicateEmailException.class); // DuplicateEmailException을 re-throw 하는지
    }
}
