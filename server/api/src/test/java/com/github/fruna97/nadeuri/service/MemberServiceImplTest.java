package com.github.fruna97.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;
import com.github.fruna97.nadeuri.repository.MemoryMemberRepository;

public class MemberServiceImplTest {

    MemoryMemberRepository memberRepository;
    MemberService memberService;

    @BeforeEach
    private void beforeEach() {
        memberRepository = new MemoryMemberRepository();
        memberService = new MemberServiceImpl(memberRepository, new BCryptPasswordEncoder());
    }

    @AfterEach
    private void afterEach() {
        memberRepository.clear();
    }

    @Test
    void signUp() {
        Member member = new Member();
        member.setEmail("test_email@test.com");
        member.setPassword("test_password");
        member.setUsername("test_username");

        memberService.signUp(member);

        Member result = memberRepository.findById(member.getId()).get();

        assertThat(result).isEqualTo(member);
    }

    @Test
    void signUpWithDuplicateEmail() {
        Member member = new Member();
        member.setEmail("test_email_1@test.com");
        member.setPassword("test_password");
        member.setUsername("test_username");

        Member memberWithDuplicateEmail = new Member();
        memberWithDuplicateEmail.setEmail("test_email_1@test.com");
        memberWithDuplicateEmail.setPassword("test_password");
        memberWithDuplicateEmail.setUsername("test_username");

        memberService.signUp(member);

        assertThatThrownBy(() -> memberService.signUp(memberWithDuplicateEmail))
                .isInstanceOf(DuplicateEmailException.class)
                .hasMessageContaining("이미 존재하는 이메일 입니니다: " + memberWithDuplicateEmail.getEmail());
    }
}
