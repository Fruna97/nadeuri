package com.github.fruna97.nadeuri.repository;

import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;

public class MemoryMemberRepository implements MemberRepository {
    private static Map<Long, Member> store = new ConcurrentHashMap<>();
    private static long sequence = 0L;

    @Override
    public Member save(Member member) {
        validateDuplicateEmail(member); // 중복 이메일 확인
        
        Member savedMember = Member.builder()
            .id(++sequence)
            .email(member.getEmail())
            .password(member.getPassword())
            .username(member.getUsername())
            .build();
        store.put(savedMember.getId(), savedMember);

        return savedMember;
    }

    @Override
    public Optional<Member> findById(Long id) {
        return Optional.ofNullable(store.get(id));
    }

    @Override
    public Optional<Member> findByEmail(String email) {
        return store.values().stream()
            .filter(member -> member.getEmail().equals(email))
            .findFirst();
    }

    private void validateDuplicateEmail(Member member) {
        findByEmail(member.getEmail())
            .ifPresent(m -> {
                throw new DuplicateEmailException(m.getEmail());
            });
    }

    public static void clear() {
        store.clear();
    }
}
