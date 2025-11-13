package com.github.fruna97.nadeuri.domain.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.member.dto.SignUpRequest;
import com.github.fruna97.nadeuri.domain.member.service.MemberService;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import jakarta.validation.Valid;

@RestController
public class MemberController {

    private final MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/member/signup")
    public ResponseEntity<ResponseDto<Void>> signUp(@RequestBody @Valid SignUpRequest signUpRequest) {
        memberService.signUp(signUpRequest);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<Void>builder()
                        .message("회원가입 성공")
                        .data(null)
                        .build());
    }

    @GetMapping("/member")
    public ResponseEntity<ResponseDto<MemberSummaryResponse>> getMyProfile(
            @AuthenticationPrincipal PrincipalDetails principalDetails) {
        MemberSummaryResponse memberSummaryResponse = memberService.getMyProfile(principalDetails);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<MemberSummaryResponse>builder()
                        .message("프로필 조회 성공")
                        .data(memberSummaryResponse).build());
    }
}
