package com.github.fruna97.nadeuri.domain.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.member.dto.SignUpRequest;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final MemberRepository memberRepository;

    @Autowired
    public MemberServiceImpl(BCryptPasswordEncoder bCryptPasswordEncoder,
            MemberRepository memberRepository) {
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.memberRepository = memberRepository;
    }

    @Override
    @Transactional
    public void signUp(SignUpRequest signUpRequest) {
        String email = signUpRequest.getEmail();
        String encryptedPassword = bCryptPasswordEncoder.encode(signUpRequest.getPassword());
        String nickname = signUpRequest.getNickname();

        Member member = Member.builder()
                .email(email)
                .password(encryptedPassword)
                .nickname(nickname).build();
        try {
            memberRepository.saveAndFlush(member);
        } catch (DataIntegrityViolationException e) {
            throw new DuplicateEmailException(email);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public MemberSummaryResponse getMyProfile(PrincipalDetails principalDetails) {
        long id = principalDetails.getId();

        Member member = memberRepository.findById(id).orElseThrow(() -> {
            log.warn("존재하지 않는 회원 조회. ID : " + id);
            return new BadCredentialsException("자격 증명에 실패하였습니다.");
        });

        return MemberSummaryResponse.from(member);
    }
}
