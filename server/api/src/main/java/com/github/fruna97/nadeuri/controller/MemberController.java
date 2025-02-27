package com.github.fruna97.nadeuri.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.github.fruna97.nadeuri.dto.SignUpDto;
import com.github.fruna97.nadeuri.service.MemberService;

@RestController
public class MemberController {

    MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/member/signup")
    public ResponseEntity<String> signUp(@RequestBody SignUpDto signUpDto) {
        memberService.signUp(signUpDto.toEntity());

        return ResponseEntity
                .ok()
                .body("회원가입 성공");
    }
}
