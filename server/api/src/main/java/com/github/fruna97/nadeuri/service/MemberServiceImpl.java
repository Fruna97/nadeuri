package com.github.fruna97.nadeuri.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.dto.SignUpDto;
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
    public Member signUp(SignUpDto signUpDto) {
        String rawPassword = signUpDto.getPassword();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);

        return memberRepository.save(Member.builder()
                .email(signUpDto.getEmail())
                .password(encPassword)
                .nickname(signUpDto.getNickname())
                .build());
    }
}
