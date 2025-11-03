package com.github.fruna97.nadeuri.domain.member.service;

import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.member.dto.SignInRequest;
import com.github.fruna97.nadeuri.domain.member.dto.SignUpRequest;
import com.github.fruna97.nadeuri.domain.member.dto.TokenResponse;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.exception.DuplicateEmailException;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@Service
public class MemberServiceImpl implements MemberService {

    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final AuthenticationManager authenticationManager;
    private final MemberRepository memberRepository;
    private final JwtService jwtService;

    @Autowired
    public MemberServiceImpl(BCryptPasswordEncoder bCryptPasswordEncoder, 
            AuthenticationManager authenticationManager, 
            MemberRepository memberRepository, 
            JwtService jwtService) {
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.authenticationManager = authenticationManager;
        this.memberRepository = memberRepository;
        this.jwtService = jwtService;
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
    public TokenResponse signIn(SignInRequest signInRequest) {
        String email = signInRequest.getEmail();
        String password = signInRequest.getPassword();

        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(email, password);
        Authentication authentication = authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
        UUID uuid = principalDetails.getUuid();

        String accessToken = jwtService.createAccessToken(uuid);
        String refreshToken = jwtService.createAndSaveRefreshToken(uuid);

        return TokenResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken).build();
    }
}
