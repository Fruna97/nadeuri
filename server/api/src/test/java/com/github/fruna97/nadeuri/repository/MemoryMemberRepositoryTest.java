package com.github.fruna97.nadeuri.repository;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.github.fruna97.nadeuri.domain.Member;

class MemoryMemberRepositoryTest {

    MemoryMemberRepository memberRepository;

    @BeforeEach
    public void beforeEach() {
        memberRepository = new MemoryMemberRepository();
    }

    @AfterEach
    public void afterEach() {
        memberRepository.clear();
    }

    @Test
    void save() {
        Member member = Member.builder()
                .email("test_email@test.com")
                .password("test_password")
                .username("test_username")
                .build();

        memberRepository.save(member);

        Member result = memberRepository.findById(member.getId()).get();

        assertThat(result).isEqualTo(member);
    }

    @Test
    void findByEmail() {
        Member member1 = Member.builder()
                .email("test_email_1@test.com")
                .password("test_password_1")
                .username("test_username_1")
                .build();
        memberRepository.save(member1);

        Member member2 = Member.builder()
                .email("test_email_2@test.com")
                .password("test_password_2")
                .username("test_username_2")
                .build();
        memberRepository.save(member2);

        Member result = memberRepository.findByEmail("test_email_2@test.com").get();
        assertThat(result).isEqualTo(member2);
    }
}
