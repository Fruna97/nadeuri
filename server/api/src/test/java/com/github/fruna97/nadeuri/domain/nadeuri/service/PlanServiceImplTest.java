package com.github.fruna97.nadeuri.domain.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.AuthenticationException;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.PlanSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Plan;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.NadeuriRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.PlanRepository;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@ExtendWith(MockitoExtension.class)
class PlanServiceImplTest {

    @Mock
    NadeuriRepository nadeuriRepository;

    @Mock
    PlanRepository planRepository;

    @InjectMocks
    PlanServiceImpl planServiceImpl;

    @Test
    void createPlan() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        CreatePlanRequest createPlanRequest = mock(CreatePlanRequest.class);

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(true);

        long planId = 0L;
        UUID planUuid = UUID.randomUUID();
        String planTitle = "test_plan";
        LocalDateTime startAt = LocalDateTime.of(2025, 12, 14, 12, 0);
        LocalDateTime endAt = LocalDateTime.of(2025, 12, 14, 13, 0);
        Plan plan = Plan.builder()
                .planTitle(planTitle)
                .startAt(startAt)
                .endAt(endAt)
                .nadeuri(nadeuri).build();
        Plan savedPlan = Plan.builder()
                .id(planId)
                .uuid(planUuid)
                .planTitle(planTitle)
                .startAt(startAt)
                .endAt(endAt)
                .nadeuri(nadeuri).build();
        when(createPlanRequest.toEntity(nadeuri)).thenReturn(plan);
        when(planRepository.save(plan)).thenReturn(savedPlan);

        // When
        PlanSummaryResponse result = planServiceImpl.createPlan(principalDetails, nadeuriUuid, createPlanRequest);

        // Then
        ArgumentCaptor<Plan> planCaptor = ArgumentCaptor.forClass(Plan.class);
        verify(planRepository).save(planCaptor.capture()); // [PlanRepository.save] 메서드가 호출 되었는지
        assertThat(planCaptor.getValue()).isEqualTo(plan); // [PlanRepository.save] 메서드에 인자가 제대로 전달되었는지

        assertAll(() -> assertEquals(result.getPlanTitle(), planTitle),
                () -> assertEquals(result.getStartAt(), startAt),
                () -> assertEquals(result.getEndAt(), endAt)); // 저장된 정보들을 그대로 반환하는지
    }

    @Test
    void createPlan_권한이없는회원() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        CreatePlanRequest createPlanRequest = mock(CreatePlanRequest.class);

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(false);

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> planServiceImpl.createPlan(principalDetails, nadeuriUuid, createPlanRequest));
    }
}
