package com.github.fruna97.nadeuri.repository;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.github.fruna97.nadeuri.domain.Member;

class MemoryMemberRepositoryTest {

    MemoryMemberRepository memberRepository;

    @BeforeEach
    void beforeEach() {
        memberRepository = new MemoryMemberRepository();
    }

    @AfterEach
    void afterEach() {
        MemoryMemberRepository.clear();
    }

    @Test
    void save() {
        // Given
        Member newMember = Member.builder()
                .email("test_email@test.com")
                .password("test_password")
                .nickname("test_nickname")
                .build();

        // When
        Member savedMember = memberRepository.save(newMember);

        // Then
        Member result = memberRepository.findById(savedMember.getId()).get();
        assertThat(result).isEqualTo(savedMember);
    }

    @Test
    void findByEmail() {
        // Given
        Member member1 = Member.builder()
                .email("test_email_1@test.com")
                .password("test_password_1")
                .nickname("test_nickname_1")
                .build();
        memberRepository.save(member1);

        Member member2 = Member.builder()
                .email("test_email_2@test.com")
                .password("test_password_2")
                .nickname("test_nickname_2")
                .build();
        
        // When
        Member savedMember2 = memberRepository.save(member2);

        // Then
        Member result = memberRepository.findByEmail("test_email_2@test.com").get();
        assertThat(result).isEqualTo(savedMember2);
    }
}
