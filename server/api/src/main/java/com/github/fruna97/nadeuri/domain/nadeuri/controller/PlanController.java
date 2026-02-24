package com.github.fruna97.nadeuri.domain.nadeuri.controller;

import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.PlanSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdatePlanRequest;
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

    @GetMapping("/nadeuri/{nadeuriUuid}/plan/{planUuid}")
    public ResponseEntity<ResponseDto<PlanSummaryResponse>> getPlan(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @PathVariable("nadeuriUuid") UUID nadeuriUuid,
            @PathVariable("planUuid") UUID planUuid) {
        PlanSummaryResponse planSummaryResponse =
                planService.getPlan(principalDetails, nadeuriUuid, planUuid);

        return ResponseEntity.ok()
                .body(ResponseDto.<PlanSummaryResponse>builder()
                        .message("일정이 조회되었습니다.")
                        .data(planSummaryResponse).build());
    }

    @PutMapping("/nadeuri/{nadeuriUuid}/plan/{planUuid}")
    public ResponseEntity<ResponseDto<PlanSummaryResponse>> updatePlan(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @PathVariable("nadeuriUuid") UUID nadeuriUuid,
            @PathVariable("planUuid") UUID planUuid,
            @RequestBody @Valid UpdatePlanRequest updatePlanRequest) {
        PlanSummaryResponse planSummaryResponse =
                planService.updatePlan(principalDetails, nadeuriUuid, planUuid, updatePlanRequest);

        return ResponseEntity.ok()
                .body(ResponseDto.<PlanSummaryResponse>builder()
                        .message("일정이 업데이트되었습니다.")
                        .data(planSummaryResponse).build());
    }

    @DeleteMapping("/nadeuri/{nadeuriUuid}/plan/{planUuid}")
    public ResponseEntity<ResponseDto<Void>> deletePlan(
            @AuthenticationPrincipal PrincipalDetails principalDetails,
            @PathVariable("nadeuriUuid") UUID nadeuriUuid,
            @PathVariable("planUuid") UUID planUuid
    ) {
        planService.deletePlan(principalDetails, nadeuriUuid, planUuid);

        return ResponseEntity.ok()
                .body(ResponseDto.<Void>builder()
                        .message("일정이 삭제되었습니다.")
                        .data(null).build());
    }
}
