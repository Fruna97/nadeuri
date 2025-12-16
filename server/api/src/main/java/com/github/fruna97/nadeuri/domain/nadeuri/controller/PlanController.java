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
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.PlanSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.service.PlanService;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import jakarta.validation.Valid;


@RestController
public class PlanController {

    private final PlanService planService;

    @Autowired
    public PlanController(PlanService planService) {
        this.planService = planService;
    }

    @PostMapping("/nadeuri/{nadeuriUuid}/plan")
    public ResponseEntity<ResponseDto<PlanSummaryResponse>> createPlan(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @PathVariable("nadeuriUuid") UUID nadeuriUuid,
            @RequestBody @Valid CreatePlanRequest createPlanRequest) {
        PlanSummaryResponse planSummaryResponse =
                planService.createPlan(principalDetails, nadeuriUuid, createPlanRequest);

        return ResponseEntity.ok()
                .body(ResponseDto.<PlanSummaryResponse>builder()
                        .message("일정이 생성되었습니다.")
                        .data(planSummaryResponse).build());
    }
}
