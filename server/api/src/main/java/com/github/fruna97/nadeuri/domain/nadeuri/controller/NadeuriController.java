package com.github.fruna97.nadeuri.domain.nadeuri.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
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
    public ResponseEntity<ResponseDto<Void>> createNadeuri(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @RequestBody @Valid CreateNadeuriRequest createNadeuriRequest) {
        String title = createNadeuriRequest.getTitle();

        nadeuriService.createNadeuri(principalDetails, title);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<Void>builder()
                        .message("Nadeuri가 생성되었습니다.")
                        .data(null).build());
    }

    @GetMapping("/nadeuri/participating")
    public ResponseEntity<ResponseDto<List<NadeuriSummaryResponse>>> participatingNadeuris(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        List<NadeuriSummaryResponse> participatingNadeuris = nadeuriService.getParticipatingNadeuris(principalDetails);

        return ResponseEntity
                .ok()
                .body(ResponseDto.<List<NadeuriSummaryResponse>>builder()
                        .message("성공적으로 Nadeuri가 조회되었습니다.")
                        .data(participatingNadeuris).build());
    }
}
