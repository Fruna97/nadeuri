package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.UUID;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.PlanSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdatePlanRequest;

public interface PlanService {

    PlanSummaryResponse createPlan(UUID memberUuid, UUID nadeuriUuid, CreatePlanRequest createPlanRequest);

    PlanSummaryResponse getPlan(UUID memberUuid, UUID nadeuriUuid, UUID planUuid);

    PlanSummaryResponse updatePlan(UUID memberUuid, UUID nadeuriUuid,
            UUID planUuid, UpdatePlanRequest updatePlanRequest);

    void deletePlan(UUID memberUuid, UUID nadeuriUuid, UUID planUuid);
}
