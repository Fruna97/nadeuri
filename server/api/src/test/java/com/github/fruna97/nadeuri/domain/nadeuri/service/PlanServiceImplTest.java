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
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdatePlanRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Plan;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.NadeuriRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.PlanRepository;
import com.github.fruna97.nadeuri.exception.PlanNotFoundInNadeuriException;
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
        String title = "test_plan";
        boolean allDay = false;
        LocalDateTime startAt = LocalDateTime.of(2025, 12, 14, 12, 0);
        LocalDateTime endAt = LocalDateTime.of(2025, 12, 14, 13, 0);
        Plan plan = Plan.builder()
                .title(title)
                .allDay(allDay)
                .startAt(startAt)
                .endAt(endAt)
                .nadeuri(nadeuri).build();
        Plan savedPlan = Plan.builder()
                .id(planId)
                .uuid(planUuid)
                .title(title)
                .allDay(allDay)
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

        assertAll(() -> assertEquals(result.getTitle(), title),
                () -> assertEquals(result.isAllDay(), allDay),
                () -> assertEquals(result.getStartAt(), startAt),
                () -> assertEquals(result.getEndAt(), endAt)); // 저장된 정보들을 그대로 반환하는지
    }

    @Test
    void createPlan_AllDayTrue() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        CreatePlanRequest createPlanRequest = mock(CreatePlanRequest.class);

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(true);

        String title = "test_plan";
        boolean allDay = true;
        LocalDateTime startAt = LocalDateTime.of(2025, 12, 14, 12, 0);
        LocalDateTime endAt = LocalDateTime.of(2025, 12, 14, 13, 0);
        Plan plan = Plan.builder()
                .title(title)
                .allDay(allDay)
                .startAt(startAt)
                .endAt(endAt)
                .nadeuri(nadeuri).build();
        when(createPlanRequest.toEntity(nadeuri)).thenReturn(plan);

        Plan savedPlan = mock(Plan.class);
        when(planRepository.save(plan)).thenReturn(savedPlan);
        when(savedPlan.getNadeuri()).thenReturn(nadeuri);
        when(nadeuri.getUuid()).thenReturn(nadeuriUuid);

        // When
        planServiceImpl.createPlan(principalDetails, nadeuriUuid, createPlanRequest);

        // Then
        ArgumentCaptor<Plan> planCaptor = ArgumentCaptor.forClass(Plan.class);
        verify(planRepository).save(planCaptor.capture()); // [PlanRepository.save] 메서드가 호출 되었는지
        Plan capturedPlan = planCaptor.getValue();
        assertAll(
                () -> assertEquals(capturedPlan.getStartAt(), LocalDateTime.of(2025, 12, 14, 0, 0)),
                () -> assertEquals(capturedPlan.getEndAt(), LocalDateTime.of(2025, 12, 15, 0, 0))
        ); // [allDay]가 True 일 때, [startAt]과 [endAt]의 시간을 00시 00분으로 설정하고, Exclusive하게 전처리 하는지
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
        assertThrows(AuthenticationException.class,
                () -> planServiceImpl.createPlan(principalDetails, nadeuriUuid, createPlanRequest)); // Nadeuri에 참가중이지 않은 회원이 일정 생성 요청을 했을 때, 인증 예외를 발생시키는지
    }

    @Test
    void getPlan() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(true);

        long planId = 0L;
        String title = "test_plan";
        boolean allDay = false;
        LocalDateTime startAt = LocalDateTime.of(2025, 12, 14, 12, 0);
        LocalDateTime endAt = LocalDateTime.of(2025, 12, 14, 13, 0);
        Plan plan = Plan.builder()
                .id(planId)
                .uuid(planUuid)
                .title(title)
                .allDay(allDay)
                .startAt(startAt)
                .endAt(endAt)
                .nadeuri(nadeuri).build();
        when(planRepository.findByUuid(planUuid)).thenReturn(Optional.of(plan));
        when(nadeuri.getUuid()).thenReturn(nadeuriUuid);

        // When
        PlanSummaryResponse result = planServiceImpl.getPlan(principalDetails, nadeuriUuid, planUuid);

        // Then
        assertAll(() -> assertEquals(result.getTitle(), title),
                () -> assertEquals(result.getStartAt(), startAt),
                () -> assertEquals(result.getEndAt(), endAt)); // 저장소에서 가져온 정보들을 그대로 반환하는지
    }

    @Test
    void getPlan_권한이없는회원() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(false);

        // When
        // Then
        assertThrows(AuthenticationException.class,
                () -> planServiceImpl.getPlan(principalDetails, nadeuriUuid, planUuid)); // Nadeuri에 참가중이지 않은 회원이 일정 조회 요청을 했을 때, 인증 예외를 발생시키는지
    }

    @Test
    void getPlan_나들이에없는일정조회() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(true);

        Plan plan = mock(Plan.class);
        when(planRepository.findByUuid(planUuid)).thenReturn(Optional.of(plan));
        when(plan.getNadeuri()).thenReturn(nadeuri);
        when(nadeuri.getUuid()).thenReturn(UUID.randomUUID());

        // When
        // Then
        assertThrows(PlanNotFoundInNadeuriException.class,
                () -> planServiceImpl.getPlan(principalDetails, nadeuriUuid, planUuid)); // Nadeuri에 속하지 않은 일정 조회 요청 시, 관련 예외를 발생시키는지
    }

    @Test
    void updatePlan() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();
        String newTitle = "new_title";
        String newGooglePlacesId = "new_google_places_id";
        boolean newAllDay = false;
        LocalDateTime newStartAt = LocalDateTime.now();
        LocalDateTime newEndAt = LocalDateTime.now();
        UpdatePlanRequest updatePlanRequest = UpdatePlanRequest.builder()
                .title(newTitle)
                .googlePlacesId(newGooglePlacesId)
                .allDay(newAllDay)
                .startAt(newStartAt)
                .endAt(newEndAt).build();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(true);

        Plan plan = mock(Plan.class);
        when(planRepository.findByUuid(planUuid)).thenReturn(Optional.of(plan));
        when(plan.getNadeuri()).thenReturn(nadeuri);
        when(nadeuri.getUuid()).thenReturn(nadeuriUuid);

        Plan savedPlan = Plan.builder()
            .id(0L)
            .uuid(planUuid)
            .title(newTitle)
            .googlePlacesId(newGooglePlacesId)
            .allDay(newAllDay)
            .startAt(newStartAt)
            .endAt(newEndAt)
            .nadeuri(nadeuri).build();
        when(planRepository.save(plan)).thenReturn(savedPlan);

        // When
        planServiceImpl.updatePlan(principalDetails, nadeuriUuid, planUuid, updatePlanRequest);

        // Then
        assertAll(() -> verify(plan).setTitle(newTitle),
                () -> verify(plan).setGooglePlacesId(newGooglePlacesId),
                () -> verify(plan).setAllDay(newAllDay),
                () -> verify(plan).setStartAt(newStartAt),
                () -> verify(plan).setEndAt(newEndAt)); // Entity의 Setter들을 정확한 매개변수를 넣어 모두 호출했는지
        verify(planRepository).save(plan); // 명시적으로 [save] 메서드를 호출했는지
    }

    @Test
    void updatePlan_AllDayTrue() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();
        String newTitle = "new_title";
        String newGooglePlacesId = "new_google_places_id";
        boolean newAllDay = true;
        LocalDateTime newStartAt = LocalDateTime.of(2026, 1, 26, 11, 0);
        LocalDateTime newEndAt = LocalDateTime.of(2026, 1, 28, 17, 0);
        UpdatePlanRequest updatePlanRequest = UpdatePlanRequest.builder()
                .title(newTitle)
                .googlePlacesId(newGooglePlacesId)
                .allDay(newAllDay)
                .startAt(newStartAt)
                .endAt(newEndAt).build();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(true);

        String oldTitle = "old_title";
        String oldGooglePlacesId = "old_google_places_id";
        boolean oldAllDay = false;
        LocalDateTime oldStartAt = LocalDateTime.of(2025, 12, 14, 12, 0);
        LocalDateTime oldEndAt = LocalDateTime.of(2025, 12, 14, 13, 0);
        Plan plan = Plan.builder()
                .title(oldTitle)
                .googlePlacesId(oldGooglePlacesId)
                .allDay(oldAllDay)
                .startAt(oldStartAt)
                .endAt(oldEndAt)
                .nadeuri(nadeuri).build();
        when(planRepository.findByUuid(planUuid)).thenReturn(Optional.of(plan));
        when(nadeuri.getUuid()).thenReturn(nadeuriUuid);

        Plan savedPlan = mock(Plan.class);
        when(planRepository.save(plan)).thenReturn(savedPlan);
        when(savedPlan.getNadeuri()).thenReturn(nadeuri);
        when(nadeuri.getUuid()).thenReturn(nadeuriUuid);

        // When
        planServiceImpl.updatePlan(principalDetails, nadeuriUuid, planUuid, updatePlanRequest);

        // Then
        ArgumentCaptor<Plan> planCaptor = ArgumentCaptor.forClass(Plan.class);
        verify(planRepository).save(planCaptor.capture()); // 명시적으로 [save] 메서드를 호출했는지
        Plan capturedPlan = planCaptor.getValue();
        assertAll(
                () -> assertEquals(capturedPlan.getStartAt(), LocalDateTime.of(2026, 1, 26, 0, 0)),
                () -> assertEquals(capturedPlan.getEndAt(), LocalDateTime.of(2026, 1, 29, 0, 0))
        ); // [allDay]가 True 일 때, [startAt]과 [endAt]의 시간을 00시 00분으로 설정하고, Exclusive하게 전처리 하는지
    }

    @Test
    void updatePlan_수정권한이없는회원() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();
        UpdatePlanRequest updatePlanRequest = mock(UpdatePlanRequest.class);

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(false);

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> planServiceImpl
                .updatePlan(principalDetails, nadeuriUuid, planUuid, updatePlanRequest)); // Nadeuri에 참가중이지 않은 회원이 일정 갱신 요청을 했을 때, 인증 예외를 발생시키는지
    }

    @Test
    void updatePlan_나들이에없는일정() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();
        UpdatePlanRequest updatePlanRequest = mock(UpdatePlanRequest.class);

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(true);

        Plan plan = mock(Plan.class);
        when(planRepository.findByUuid(planUuid)).thenReturn(Optional.of(plan));
        when(plan.getNadeuri()).thenReturn(nadeuri);
        when(nadeuri.getUuid()).thenReturn(UUID.randomUUID());

        // When
        // Then
        assertThrows(PlanNotFoundInNadeuriException.class, () -> planServiceImpl
                .updatePlan(principalDetails, nadeuriUuid, planUuid, updatePlanRequest)); // Nadeuri에 속하지 않은 일정 갱신 요청 시, 관련 예외를 발생시키는지
    }

    @Test
    void deletePlan() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(true);

        Plan plan = mock(Plan.class);
        when(planRepository.findByUuid(planUuid)).thenReturn(Optional.of(plan));
        when(plan.getNadeuri()).thenReturn(nadeuri);
        when(nadeuri.getUuid()).thenReturn(nadeuriUuid);

        // When
        planServiceImpl.deletePlan(principalDetails, nadeuriUuid, planUuid);

        // Then
        verify(planRepository).delete(plan); // [plan]을 담아 [delete] 메서드를 호출했는지
    }

    @Test
    void deletePlan_수정권한이없는회원() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(false);

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> planServiceImpl.deletePlan(principalDetails, nadeuriUuid, planUuid)); // Nadeuri에 참가중이지 않은 회원이 일정 삭제 요청을 했을 때, 인증 예외를 발생시키는지
    }

    @Test
    void deletePlan_나들이에없는일정() {
        // Given
        PrincipalDetails principalDetails = mock(PrincipalDetails.class);
        UUID nadeuriUuid = UUID.randomUUID();
        UUID planUuid = UUID.randomUUID();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(principalDetails)).thenReturn(true);

        Plan plan = mock(Plan.class);
        when(planRepository.findByUuid(planUuid)).thenReturn(Optional.of(plan));
        when(plan.getNadeuri()).thenReturn(nadeuri);
        when(nadeuri.getUuid()).thenReturn(UUID.randomUUID());

        // When
        // Then
        assertThrows(PlanNotFoundInNadeuriException.class, () -> planServiceImpl
                .deletePlan(principalDetails, nadeuriUuid, planUuid)); // Nadeuri에 속하지 않은 일정 삭제 요청 시, 관련 예외를 발생시키는지
    }
}
