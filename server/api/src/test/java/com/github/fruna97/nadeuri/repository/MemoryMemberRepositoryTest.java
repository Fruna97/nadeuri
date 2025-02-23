package com.github.fruna97.nadeuri.repository;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;

import com.github.fruna97.nadeuri.domain.Member;

class MemoryMemberRepositoryTest {
    MemoryMemberRepository repository = new MemoryMemberRepository();
    
    @Test
    void save() {
        Member member = new Member();
        member.setEmail("test_email@test.com");
        member.setPassword("test_password");
        member.setUsername("test_username");
        
        repository.save(member);

        Member result = repository.findById(member.getId()).get();

        Assertions.assertThat(result).isEqualTo(member);
    }
}
