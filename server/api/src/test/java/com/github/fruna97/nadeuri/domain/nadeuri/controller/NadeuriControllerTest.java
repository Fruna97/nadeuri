package com.github.fruna97.nadeuri.domain.nadeuri.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.List;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriTitleRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.service.NadeuriService;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@ExtendWith(MockitoExtension.class)
class NadeuriControllerTest {

    @Mock
    private NadeuriService nadeuriService;

    @Mock
    private PrincipalDetails principalDetails;

    @InjectMocks
    private NadeuriController nadeuriController;

    @Captor
    private ArgumentCaptor<String> titleCaptor;

    @Test
    void createNadeuri() {
        // Given
        String title = "test_title";
        CreateNadeuriRequest createNadeuriRequest = CreateNadeuriRequest.builder()
                .title(title).build();

        // When
        ResponseEntity<ResponseDto<Void>> result = nadeuriController.createNadeuri(principalDetails, createNadeuriRequest);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지

        verify(nadeuriService).createNadeuri(any(PrincipalDetails.class), titleCaptor.capture()); // NadeuriService의 createNadeuri 메서드를 호출하는지
        assertThat(titleCaptor.getValue()).isEqualTo(title); // 메서드의 인자에 title을 제대로 전달하는지        
    }

    @Test
    void getNadeuri() {
        // Given
        UUID uuid = UUID.randomUUID();
        String title = "test_title";
        NadeuriSummaryResponse nadeuriSummaryResponse = NadeuriSummaryResponse.builder()
                .uuid(uuid)
                .title(title).build();
        when(nadeuriService.getNadeuri(principalDetails, uuid)).thenReturn(nadeuriSummaryResponse);

        // When
        ResponseEntity<ResponseDto<NadeuriSummaryResponse>> result = nadeuriController.getNadeuri(principalDetails, uuid);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지
        ResponseDto<NadeuriSummaryResponse> body = result.getBody();
        assertNotNull(body); // 응답에 본문을 담고 있는지
        assertThat(body.getData()).isEqualTo(nadeuriSummaryResponse); // 응답 본문의 데이터가 [NadeuriService.getNadeuri]가 반환한 [NadeuriSummaryResponse]와 동일한지
    }

    @Test
    void participatingNadeuris() {
        // Given
        List<NadeuriSummaryResponse> participatingNadeuris = List.of(
            NadeuriSummaryResponse.builder().title("test_title_1").build(), 
            NadeuriSummaryResponse.builder().title("test_title_2").build(), 
            NadeuriSummaryResponse.builder().title("test_title_3").build()
        );
        when(nadeuriService.getParticipatingNadeuris(any(PrincipalDetails.class))).thenReturn(participatingNadeuris);

        // When
        ResponseEntity<ResponseDto<List<NadeuriSummaryResponse>>> result = nadeuriController.participatingNadeuris(principalDetails);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지
        ResponseDto<List<NadeuriSummaryResponse>> body = result.getBody();
        assertNotNull(body); // 응답에 본문을 담고 있는지
        assertThat(body.getData()).containsExactlyInAnyOrderElementsOf(participatingNadeuris); // 응답 본문의 데이터가 주어진 Nadeuri 목록과 같은지
    }

    @Test
    void updateNadeuriTitle() {
        // Given
        UUID nadeuriUuid = UUID.randomUUID();

        String newTitle = "new Title";
        UpdateNadeuriTitleRequest updateNadeuriTitleRequest =
                UpdateNadeuriTitleRequest.builder().newTitle(newTitle).build();

        // When
        ResponseEntity<ResponseDto<Void>> result = nadeuriController
                .updateNadeuriTitle(principalDetails, nadeuriUuid, updateNadeuriTitleRequest);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환하는지
    }
}
