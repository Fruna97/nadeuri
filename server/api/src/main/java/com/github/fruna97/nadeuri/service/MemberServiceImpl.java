package com.github.fruna97.nadeuri.service;

import java.util.DuplicateFormatFlagsException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.repository.MemberRepository;
import com.github.fruna97.nadeuri.repository.MemoryMemberRepository;

@Service
public class MemberServiceImpl implements MemberService {

    MemberRepository memberRepository;
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    public MemberServiceImpl(MemberRepository memberRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.memberRepository = memberRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public Member signUp(Member member) {
        validateDuplicateEmail(member); // 중복 이메일 확인

        String rawPassword = member.getPassword();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);

        member.setPassword(encPassword);

        Member memberEntity = memberRepository.save(member);

        return memberEntity;
    }

    private void validateDuplicateEmail(Member member) {
        memberRepository.findByEmail(member.getEmail())
            .ifPresent(m -> {
                throw new DuplicateFormatFlagsException(m.getEmail());
            });
    }
}
