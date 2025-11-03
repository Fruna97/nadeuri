package com.github.fruna97.nadeuri.domain.member.controller;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.member.dto.SignInRequest;
import com.github.fruna97.nadeuri.domain.member.dto.SignUpRequest;
import com.github.fruna97.nadeuri.domain.member.service.JwtService;
import com.github.fruna97.nadeuri.domain.member.service.MemberService;
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
    public ResponseEntity<ResponseDto<Void>> signUp(@RequestBody @Valid SignUpRequest signUpRequest) {
        String email = signUpRequest.getEmail();
        String password = signUpRequest.getPassword();
        String nickname = signUpRequest.getNickname();
        
        memberService.signUp(email, password, nickname);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<Void>builder()
                        .message("회원가입 성공")
                        .data(null)
                        .build());
    }

    @PostMapping("/member/signin")
    public ResponseEntity<ResponseDto<Map<String, String>>> signIn(@RequestBody @Valid SignInRequest signInRequest) {
        String email = signInRequest.getEmail();
        String password = signInRequest.getPassword();

        Map<String, String> issuedTokens = memberService.signIn(email, password);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<Map<String, String>>builder()
                        .message("성공적으로 로그인이 되었습니다.")
                        .data(issuedTokens)
                        .build());
    }

    @PostMapping("/member/reissue-token")
    public ResponseEntity<ResponseDto<Map<String, String>>> reissueToken(@RequestHeader(value = HttpHeaders.AUTHORIZATION, required = false) String authorizationHeader) {
        if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }
        String refreshToken = authorizationHeader.replace("Bearer ", "");

        Map<String, String> reissuedTokens = jwtService.reissueToken(refreshToken);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<Map<String, String>>builder()
                        .message("토큰이 재발급 되었습니다.")
                        .data(reissuedTokens)
                        .build());
    }
    
}
