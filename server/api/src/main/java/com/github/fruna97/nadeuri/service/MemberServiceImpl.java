package com.github.fruna97.nadeuri.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.repository.MemberRepository;

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
        String rawPassword = member.getPassword();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);

        member.setPassword(encPassword);

        Member memberEntity = memberRepository.save(member);

        return memberEntity;
    }
}
