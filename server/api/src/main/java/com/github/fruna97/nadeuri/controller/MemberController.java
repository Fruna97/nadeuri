package com.github.fruna97.nadeuri.controller;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.github.fruna97.nadeuri.dto.ReissueTokenDto;
import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.dto.SignInDto;
import com.github.fruna97.nadeuri.dto.SignUpDto;
import com.github.fruna97.nadeuri.service.JwtService;
import com.github.fruna97.nadeuri.service.MemberService;
import jakarta.validation.Valid;


@RestController
public class MemberController {

    private final MemberService memberService;
    private final JwtService jwtService;

    @Autowired
    public MemberController(MemberService memberService, JwtService jwtService) {
        this.memberService = memberService;
        this.jwtService = jwtService;
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

        Map<String, String> issuedTokens = memberService.signIn(email, password);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<Map<String, String>>builder()
                        .message("성공적으로 로그인이 되었습니다.")
                        .data(issuedTokens)
                        .build());
    }

    @PostMapping("/member/reissue-token")
    public ResponseEntity<ResponseDto<Map<String, String>>> reissueToken(@RequestBody @Valid ReissueTokenDto reissueTokenDto) {
        String refreshToken = reissueTokenDto.getRefreshToken();

        Map<String, String> reissuedTokens = jwtService.reissueToken(refreshToken);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<Map<String, String>>builder()
                        .message("토큰이 재발급 되었습니다.")
                        .data(reissuedTokens)
                        .build());
    }
    
}
