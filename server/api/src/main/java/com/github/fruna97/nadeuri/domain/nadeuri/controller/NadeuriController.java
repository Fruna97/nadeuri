package com.github.fruna97.nadeuri.domain.nadeuri.controller;

import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.service.NadeuriService;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import jakarta.validation.Valid;

@RestController
public class NadeuriController {

    private final NadeuriService nadeuriService;

    @Autowired
    public NadeuriController(NadeuriService nadeuriService) {
        this.nadeuriService = nadeuriService;
    }

    @PostMapping("/nadeuri")
    public ResponseEntity<ResponseDto<NadeuriSummaryResponse>> createNadeuri(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @RequestBody @Valid CreateNadeuriRequest createNadeuriRequest) {
        NadeuriSummaryResponse nadeuriSummaryResponse = nadeuriService.createNadeuri(principalDetails, createNadeuriRequest);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<NadeuriSummaryResponse>builder()
                        .message("Nadeuri가 생성되었습니다.")
                        .data(nadeuriSummaryResponse).build());
    }

    @GetMapping("/nadeuri/{uuid}")
    public ResponseEntity<ResponseDto<NadeuriSummaryResponse>> getNadeuri(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @PathVariable("uuid") UUID uuid) {
        NadeuriSummaryResponse nadeuriSummaryResponse =
                nadeuriService.getNadeuri(principalDetails, uuid);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<NadeuriSummaryResponse>builder()
                        .message("Nadeuri를 성공적으로 조회했습니다.")
                        .data(nadeuriSummaryResponse).build());
    }    

    @GetMapping("/nadeuri/participating")
    public ResponseEntity<ResponseDto<List<NadeuriSummaryResponse>>> participatingNadeuris(
            @AuthenticationPrincipal PrincipalDetails principalDetails) {
        List<NadeuriSummaryResponse> participatingNadeuris =
                nadeuriService.getParticipatingNadeuris(principalDetails);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<List<NadeuriSummaryResponse>>builder()
                        .message("Nadeuri가 성공적으로 조회되었습니다.")
                        .data(participatingNadeuris).build());
    }

    @PatchMapping("/nadeuri/{uuid}")
    public ResponseEntity<ResponseDto<NadeuriSummaryResponse>> updateNadeuri(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @PathVariable("uuid") UUID uuid, @RequestBody UpdateNadeuriRequest updateNadeuriTitleRequest) {
        NadeuriSummaryResponse nadeuriSummaryResponse = nadeuriService.updateNadeuri(principalDetails, uuid, updateNadeuriTitleRequest);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<NadeuriSummaryResponse>builder()
                        .message("Nadeuri가 성공적으로 변경되었습니다.")
                        .data(nadeuriSummaryResponse).build());
    }
}
