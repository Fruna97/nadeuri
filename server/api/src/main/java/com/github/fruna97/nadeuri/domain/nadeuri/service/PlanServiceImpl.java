package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.PlanSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Plan;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.NadeuriRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.PlanRepository;
import com.github.fruna97.nadeuri.exception.PlanNotFoundInNadeuriException;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PlanServiceImpl implements PlanService {

    private final NadeuriRepository nadeuriRepository;
    private final PlanRepository planRepository;

    @Autowired
    public PlanServiceImpl(NadeuriRepository nadeuriRepository, PlanRepository planRepository) {
        this.nadeuriRepository = nadeuriRepository;
        this.planRepository = planRepository;
    }

    @Override
    @Transactional
    public PlanSummaryResponse createPlan(PrincipalDetails principalDetails, UUID nadeuriUuid, CreatePlanRequest createPlanRequest) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid).orElseThrow();
        if (!nadeuri.hasAuthorityToNadeuri(principalDetails)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 수정 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        Plan plan = createPlanRequest.toEntity(nadeuri);
        Plan savedPlan = planRepository.save(plan);

        return PlanSummaryResponse.fromEntity(savedPlan);
    }

    @Override
    @Transactional(readOnly = true)
    public PlanSummaryResponse getPlan(PrincipalDetails principalDetails, UUID nadeuriUuid, UUID planUuid) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid).orElseThrow();
        if (!nadeuri.hasAuthorityToNadeuri(principalDetails)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 수정 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        Plan plan = planRepository.findByUuid(planUuid).orElseThrow();
        if (!nadeuri.hasPlan(plan)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 포함되지 않은 일정 조회 요청");
            throw new PlanNotFoundInNadeuriException(plan);
        }

        return PlanSummaryResponse.fromEntity(plan);
    }

    @Override
    @Transactional
    public PlanSummaryResponse updatePlan(PrincipalDetails principalDetails, UUID nadeuriUuid,
            UUID planUuid, UpdatePlanRequest updatePlanRequest) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid).orElseThrow();
        if (!nadeuri.hasAuthorityToNadeuri(principalDetails)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 수정 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        Plan plan = planRepository.findByUuid(planUuid).orElseThrow();
        if (!nadeuri.hasPlan(plan)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 포함되지 않은 일정 조회 요청");
            throw new PlanNotFoundInNadeuriException(plan);
        }

        plan.setPlanTitle(updatePlanRequest.getPlanTitle());
        plan.setGooglePlacesId(updatePlanRequest.getGooglePlacesId());
        plan.setLatitude(updatePlanRequest.getLatitude());
        plan.setLongitude(updatePlanRequest.getLongitude());
        plan.setStartAt(updatePlanRequest.getStartAt());
        plan.setEndAt(updatePlanRequest.getEndAt());

        Plan savedPlan = planRepository.save(plan);
        return PlanSummaryResponse.fromEntity(savedPlan);
    }
}
