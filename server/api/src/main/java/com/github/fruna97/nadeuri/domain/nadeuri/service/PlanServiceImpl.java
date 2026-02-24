package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.time.LocalDateTime;
import java.time.LocalTime;
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
import com.github.fruna97.nadeuri.exception.NadeuriNotFoundException;
import com.github.fruna97.nadeuri.exception.PlanNotFoundException;
import com.github.fruna97.nadeuri.exception.PlanNotFoundInNadeuriException;
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
    public PlanSummaryResponse createPlan(UUID memberUuid, UUID nadeuriUuid,
            CreatePlanRequest createPlanRequest) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid)
                .orElseThrow(NadeuriNotFoundException::new);
        if (!nadeuri.hasAuthorityToNadeuri(memberUuid)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 생성 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        Plan plan = createPlanRequest.toEntity(nadeuri);

        preprocessByAllDay(plan);

        Plan savedPlan = planRepository.save(plan);
        return PlanSummaryResponse.fromEntity(savedPlan);
    }

    @Override
    @Transactional(readOnly = true)
    public PlanSummaryResponse getPlan(UUID memberUuid, UUID nadeuriUuid,
            UUID planUuid) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid)
                .orElseThrow(NadeuriNotFoundException::new);
        if (!nadeuri.hasAuthorityToNadeuri(memberUuid)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 조회 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        Plan plan = planRepository.findByUuid(planUuid).orElseThrow(PlanNotFoundException::new);
        if (!plan.getNadeuri().getUuid().equals(nadeuriUuid)) {
            throw new PlanNotFoundInNadeuriException(plan);
        }

        return PlanSummaryResponse.fromEntity(plan);
    }

    @Override
    @Transactional
    public PlanSummaryResponse updatePlan(UUID memberUuid, UUID nadeuriUuid,
            UUID planUuid, UpdatePlanRequest updatePlanRequest) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid)
                .orElseThrow(NadeuriNotFoundException::new);
        if (!nadeuri.hasAuthorityToNadeuri(memberUuid)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 수정 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        Plan plan = planRepository.findByUuid(planUuid).orElseThrow(PlanNotFoundException::new);
        if (!plan.getNadeuri().getUuid().equals(nadeuriUuid)) {
            throw new PlanNotFoundInNadeuriException(plan);
        }

        plan.setTitle(updatePlanRequest.getTitle());
        plan.setGooglePlacesId(updatePlanRequest.getGooglePlacesId());
        plan.setAllDay(updatePlanRequest.getAllDay());
        plan.setStartAt(updatePlanRequest.getStartAt());
        plan.setEndAt(updatePlanRequest.getEndAt());

        preprocessByAllDay(plan);

        Plan savedPlan = planRepository.save(plan);
        return PlanSummaryResponse.fromEntity(savedPlan);
    }

    @Override
    @Transactional
    public void deletePlan(UUID memberUuid, UUID nadeuriUuid, UUID planUuid) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid)
                .orElseThrow(NadeuriNotFoundException::new);
        if (!nadeuri.hasAuthorityToNadeuri(memberUuid)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 삭제 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        Plan plan = planRepository.findByUuid(planUuid).orElseThrow(PlanNotFoundException::new);
        if (!plan.getNadeuri().getUuid().equals(nadeuriUuid)) {
            throw new PlanNotFoundInNadeuriException(plan);
        }
        planRepository.delete(plan);
    }

    /**
     * {@code allDay} 필드가 True인 경우, {@code startAt}과 {@code endAt}의 시간을 00시 00분으로 변경하고 범위를 Exclusive하게 변경
     * @param plan
     */
    private void preprocessByAllDay(Plan plan) {
        if (!plan.isAllDay()) {
            return;
        }

        plan.setStartAt(LocalDateTime.of(
                plan.getStartAt().toLocalDate(),
                LocalTime.of(0, 0)));
        plan.setEndAt(LocalDateTime.of(
                plan.getEndAt().toLocalDate().plusDays(1),
                LocalTime.of(0, 0)));
    }
}
