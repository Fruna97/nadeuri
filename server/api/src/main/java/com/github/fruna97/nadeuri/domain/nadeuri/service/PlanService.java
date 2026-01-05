package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.UUID;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.PlanSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdatePlanRequest;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

public interface PlanService {

    PlanSummaryResponse createPlan(PrincipalDetails principalDetails, UUID nadeuriUuid, CreatePlanRequest createPlanRequest);

    PlanSummaryResponse getPlan(PrincipalDetails principalDetails, UUID nadeuriUuid, UUID planUuid);

    PlanSummaryResponse updatePlan(PrincipalDetails principalDetails, UUID nadeuriUuid,
            UUID planUuid, UpdatePlanRequest updatePlanRequest);
}
