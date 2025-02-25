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
        Member member = new Member();
        member.setEmail("test_email@test.com");
        member.setPassword("test_password");
        member.setUsername("test_username");
        
        memberRepository.save(member);

        Member result = memberRepository.findById(member.getId()).get();

        assertThat(result).isEqualTo(member);
    }

    @Test
    void findByEmail() {
        Member member1 = new Member();
        member1.setEmail("test_email_1@test.com");
        member1.setPassword("test_password_1");
        member1.setUsername("test_username_1");
        memberRepository.save(member1);
        
        Member member2 = new Member();
        member2.setEmail("test_email_2@test.com");
        member2.setPassword("test_password_2");
        member2.setUsername("test_username_2");
        memberRepository.save(member2);
        
        Member result = memberRepository.findByEmail("test_email_2@test.com").get();
        assertThat(result).isEqualTo(member2);
    }

    
}
