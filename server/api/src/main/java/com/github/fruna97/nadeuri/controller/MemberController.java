package com.github.fruna97.nadeuri.controller;

import java.util.Map;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.dto.SignInDto;
import com.github.fruna97.nadeuri.dto.SignUpDto;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import com.github.fruna97.nadeuri.service.JwtService;
import com.github.fruna97.nadeuri.service.MemberService;
import jakarta.validation.Valid;


@RestController
public class MemberController {

    private final MemberService memberService;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    @Autowired
    public MemberController(MemberService memberService, 
            JwtService jwtService,
            AuthenticationManager authenticationManager) {
        this.memberService = memberService;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
    }

    @PostMapping("/member/signup")
    public ResponseEntity<ResponseDto<Void>> signUp(@RequestBody @Valid SignUpDto signUpDto) {
        memberService.signUp(signUpDto);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<Void>builder()
                        .message("회원가입 성공")
                        .data(null)
                        .build());
    }

    @PostMapping("/member/signin")
    public ResponseEntity<ResponseDto<Map<String, String>>> signIn(@RequestBody @Valid SignInDto signInDto) {
        String email = signInDto.getEmail();
        String password = signInDto.getPassword();
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(email, password);
        Authentication authentication = authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
        UUID uuid = principalDetails.getUuid();

        String accessToken = jwtService.createAccessToken(uuid);
        String refreshToken = jwtService.createAndSaveRefreshToken(uuid);

        Map<String, String> data = Map.of("accessToken", accessToken, 
                "refreshToken", refreshToken);
        return ResponseEntity
                .ok()
                .body(ResponseDto.<Map<String, String>>builder()
                        .message("성공적으로 로그인이 되었습니다.")
                        .data(data)
                        .build());
    }
}
