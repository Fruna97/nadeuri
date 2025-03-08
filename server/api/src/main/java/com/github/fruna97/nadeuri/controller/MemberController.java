package com.github.fruna97.nadeuri.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.dto.SignUpDto;
import com.github.fruna97.nadeuri.service.MemberService;

import jakarta.validation.Valid;

@RestController
public class MemberController {

    MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/member/signup")
    public ResponseEntity<ResponseDto<?>> signUp(@RequestBody @Valid SignUpDto signUpDto) {
        memberService.signUp(signUpDto.toEntity());

        return ResponseEntity
                .ok()
                .body(new ResponseDto<>("회원가입 성공", null));
    }
}
