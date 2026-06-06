package com.github.fruna97.nadeuri.domain.nadeuri.controller;

import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.member.dto.CreateInviteRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.service.InviteService;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import jakarta.validation.Valid;

@RestController
public class InviteController {

    private InviteService inviteService;

    @Autowired
    InviteController (InviteService inviteService) {
        this.inviteService = inviteService;
    }

    @PostMapping("/nadeuri/{nadeuriUuid}/invite")
    public ResponseEntity<ResponseDto<Void>> postInvite(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @PathVariable("nadeuriUuid") UUID nadeuriUuid,
            @RequestBody @Valid CreateInviteRequest postInviteRequest) {
        inviteService.createInvite(principalDetails.getUuid(), nadeuriUuid, postInviteRequest);

        return ResponseEntity.ok()
                .body(ResponseDto.<Void>builder()
                        .message("초대가 생성되었습니다.")
                        .data(null).build());
    }

    @PostMapping("/nadeuri/{nadeuriUuid}/invite/{inviteUuid}/accept")
    public ResponseEntity<ResponseDto<Void>> acceptInvite(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @PathVariable("nadeuriUuid") UUID nadeuriUuid,
            @PathVariable("inviteUuid") UUID inviteUuid) {
        inviteService.acceptInvite(principalDetails.getUuid(), nadeuriUuid, inviteUuid);

        return ResponseEntity.ok()
                .body(ResponseDto.<Void>builder()
                        .message("초대가 수락되었습니다.")
                        .data(null).build());
    }

    @PostMapping("/nadeuri/{nadeuriUuid}/invite/{inviteUuid}/reject")
    public ResponseEntity<ResponseDto<Void>> rejectInvite(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @PathVariable("nadeuriUuid") UUID nadeuriUuid,
            @PathVariable("inviteUuid") UUID inviteUuid) {
        inviteService.rejectInvite(principalDetails.getUuid(), nadeuriUuid, inviteUuid);

        return ResponseEntity.ok()
                .body(ResponseDto.<Void>builder()
                        .message("초대가 거절되었습니다.")
                        .data(null).build());
    }
}
