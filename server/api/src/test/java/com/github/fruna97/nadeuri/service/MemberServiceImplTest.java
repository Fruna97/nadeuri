package com.github.fruna97.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import org.assertj.core.api.ThrowableAssert.ThrowingCallable;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.dto.SignUpDto;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;
import com.github.fruna97.nadeuri.repository.MemoryMemberRepository;

class MemberServiceImplTest {

    MemoryMemberRepository memberRepository;
    MemberService memberService;

    @BeforeEach
    void beforeEach() {
        memberRepository = new MemoryMemberRepository();
        memberService = new MemberServiceImpl(memberRepository, new BCryptPasswordEncoder());
    }

    @AfterEach
    void afterEach() {
        MemoryMemberRepository.clear();
    }

    @Test
    void signUp() {
        // Given
        SignUpDto signUpDto = SignUpDto.builder()
                .email("test_email@test.com")
                .password("test_password")
                .username("test_username")
                .build();

        // When
        Member savedMember = memberService.signUp(signUpDto);
        Member result = memberRepository.findById(savedMember.getId()).get();

        // Then
        assertThat(result).isEqualTo(savedMember);
    }

    @Test
    void signUpWithDuplicateEmail() {
        // Given
        SignUpDto signUpDto1 = SignUpDto.builder()
                .email("test_email_1@test.com")
                .password("test_password")
                .username("test_username")
                .build();

        SignUpDto signUpDto2 = SignUpDto.builder()
                .email("test_email_1@test.com")
                .password("test_password")
                .username("test_username")
                .build();

        // When
        memberService.signUp(signUpDto1);
        ThrowingCallable signUpWithDuplicatedEmailAction = () -> memberService.signUp(signUpDto2);

        // Then
        assertThatThrownBy(signUpWithDuplicatedEmailAction)
                .isInstanceOf(DuplicateEmailException.class)
                .hasMessageContaining("이미 존재하는 이메일 입니다: " + signUpDto2.getEmail());
    }
}
