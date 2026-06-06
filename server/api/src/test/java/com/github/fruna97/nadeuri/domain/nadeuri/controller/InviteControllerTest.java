package com.github.fruna97.nadeuri.domain.nadeuri.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
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
import com.github.fruna97.nadeuri.domain.member.dto.CreateInviteRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.service.InviteService;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@ExtendWith(MockitoExtension.class)
class InviteControllerTest {

    private final UUID memberUuid = UUID.randomUUID();

    @Mock
    private InviteService inviteService;

    @Mock
    private PrincipalDetails principalDetails;

    @InjectMocks
    private InviteController inviteController;

    @BeforeEach
    void beforeEach() {
        when(principalDetails.getUuid()).thenReturn(memberUuid);
    }

    @Test
    void postInvite() {
        // Given
                UUID nadeuriUuid = UUID.randomUUID();
        CreateInviteRequest createInviteRequest = CreateInviteRequest.builder()
                .inviteeEmail("invitee@test.com")
                .build();

        // When
        ResponseEntity<ResponseDto<Void>> result =
                inviteController.postInvite(principalDetails, nadeuriUuid, createInviteRequest);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환하는지
        ResponseDto<Void> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getMessage()).isEqualTo("초대가 생성되었습니다."); // 성공 메시지가 기대값과 동일한지
        assertThat(body.getData()).isNull(); // 성공 시 data는 null인지
        verify(inviteService, times(1)).createInvite(memberUuid, nadeuriUuid, createInviteRequest); // 서비스 호출을 정확히 위임하는지
    }

    @Test
    void acceptInvite() {
        // Given
        UUID nadeuriUuid = UUID.randomUUID();
        UUID inviteUuid = UUID.randomUUID();

        // When
        ResponseEntity<ResponseDto<Void>> result =
                inviteController.acceptInvite(principalDetails, nadeuriUuid, inviteUuid);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환하는지
        ResponseDto<Void> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getMessage()).isEqualTo("초대가 수락되었습니다."); // 성공 메시지가 기대값과 동일한지
        assertThat(body.getData()).isNull(); // 성공 시 data는 null인지
        verify(inviteService, times(1)).acceptInvite(memberUuid, nadeuriUuid, inviteUuid); // 서비스 호출을 정확히 위임하는지
    }

    @Test
    void rejectInvite() {
        // Given
        UUID nadeuriUuid = UUID.randomUUID();
        UUID inviteUuid = UUID.randomUUID();

        // When
        ResponseEntity<ResponseDto<Void>> result =
                inviteController.rejectInvite(principalDetails, nadeuriUuid, inviteUuid);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환하는지
        ResponseDto<Void> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getMessage()).isEqualTo("초대가 거절되었습니다."); // 성공 메시지가 기대값과 동일한지
        assertThat(body.getData()).isNull(); // 성공 시 data는 null인지
                verify(inviteService, times(1)).rejectInvite(memberUuid, nadeuriUuid, inviteUuid); // 서비스 호출을 정확히 위임하는지
    }
}
