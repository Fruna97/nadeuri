package com.github.fruna97.nadeuri.service;

import java.util.Map;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.dto.SignUpDto;
import com.github.fruna97.nadeuri.repository.MemberRepository;
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
    public Member signUp(SignUpDto signUpDto) {
        String rawPassword = signUpDto.getPassword();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);

        return memberRepository.save(Member.builder()
                .email(signUpDto.getEmail())
                .password(encPassword)
                .nickname(signUpDto.getNickname())
                .build());
    }

    @Override
    public Map<String, String> signIn(String email, String password) {
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(email, password);
        Authentication authentication = authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
        UUID uuid = principalDetails.getUuid();

        String accessToken = jwtService.createAccessToken(uuid);
        String refreshToken = jwtService.createAndSaveRefreshToken(uuid);

        return Map.of("accessToken", accessToken, 
                "refreshToken", refreshToken);
    }
}
