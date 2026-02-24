package com.github.fruna97.nadeuri.domain.nadeuri.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import java.time.LocalDateTime;
import java.util.UUID;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.PlanSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.service.PlanService;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@ExtendWith(MockitoExtension.class)
class PlanControllerTest {

    private final UUID memberUuid = UUID.randomUUID();

    @Mock
    private PlanService planService;

    @Mock
    private PrincipalDetails principalDetails;

    @InjectMocks
    private PlanController planController;

    @BeforeEach
    void beforeEach() {
        when(principalDetails.getUuid()).thenReturn(memberUuid);
    }

    @Test
    void createPlan() {
        // Given
        UUID nadeuriUuid = UUID.randomUUID();
        CreatePlanRequest createPlanRequest = mock(CreatePlanRequest.class);

        String planTitle = "test_plan";
        LocalDateTime startAt = LocalDateTime.of(2025, 12, 16, 13, 0);
        LocalDateTime endAt = LocalDateTime.of(2025, 12, 16, 17, 30);
        PlanSummaryResponse planSummaryResponse = PlanSummaryResponse.builder()
                .title(planTitle)
                .startAt(startAt)
                .endAt(endAt).build();

        when(planService.createPlan(memberUuid, nadeuriUuid, createPlanRequest)).thenReturn(planSummaryResponse);

        // When
        ResponseEntity<ResponseDto<PlanSummaryResponse>> result =
                planController.createPlan(principalDetails, nadeuriUuid, createPlanRequest);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지
        ResponseDto<PlanSummaryResponse> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getData()).isEqualTo(planSummaryResponse); // 응답 본문의 데이터가 [PlanService.createPlan]가 반환한 [PlanSummaryResponse]와 동일한지
    }

    @Test
    void getPlan() {
        // Given
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();

        PlanSummaryResponse planSummaryResponse = mock(PlanSummaryResponse.class);
        when(planService.getPlan(memberUuid, nadeuriUuid, planUuid)).thenReturn(planSummaryResponse);

        // When
        ResponseEntity<ResponseDto<PlanSummaryResponse>> result = planController.getPlan(principalDetails, nadeuriUuid, planUuid);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지
        ResponseDto<PlanSummaryResponse> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getData()).isEqualTo(planSummaryResponse); // 응답 본문의 데이터가 [PlanService.getPlan]가 반환한 [PlanSummaryResponse]와 동일한지
    }

    @Test
    void updatePlan() {
        // Given
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();
        UpdatePlanRequest updatePlanRequest = mock(UpdatePlanRequest.class);

        PlanSummaryResponse planSummaryResponse = mock(PlanSummaryResponse.class);
        when(planService.updatePlan(memberUuid, nadeuriUuid, planUuid, updatePlanRequest)).thenReturn(planSummaryResponse);

        // When
        ResponseEntity<ResponseDto<PlanSummaryResponse>> result = planController.updatePlan(principalDetails, nadeuriUuid, planUuid, updatePlanRequest);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지
        ResponseDto<PlanSummaryResponse> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getData()).isEqualTo(planSummaryResponse); // 응답 본문의 데이터가 [PlanService.updatePlan]가 반환한 [PlanSummaryResponse]와 동일한지
    }

    @Test
    void deletePlan() {
        // Given
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();

        // When
        ResponseEntity<ResponseDto<Void>> result = planController.deletePlan(principalDetails, nadeuriUuid, planUuid);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지
    }
}
