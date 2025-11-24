package com.github.fruna97.nadeuri.domain.nadeuri.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import java.util.List;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import com.github.fruna97.nadeuri.common.dto.ResponseDto;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriRequest;
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

    @Test
    void createNadeuri() {
        // Given
        String title = "test_title";
        NadeuriSummaryResponse nadeuriSummaryResponse = NadeuriSummaryResponse.builder()
                .title(title).build();
        CreateNadeuriRequest createNadeuriRequest = CreateNadeuriRequest.builder()
                .title(title).build();

        when(nadeuriService.createNadeuri(principalDetails, createNadeuriRequest))
                .thenReturn(nadeuriSummaryResponse);

        // When
        ResponseEntity<ResponseDto<NadeuriSummaryResponse>> result =
                nadeuriController.createNadeuri(principalDetails, createNadeuriRequest);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지
        ResponseDto<NadeuriSummaryResponse> body = result.getBody();
        assertNotNull(body); // 응답 본문을 담고있는지
        assertThat(body.getData()).isEqualTo(nadeuriSummaryResponse); // 응답 본문의 데이터가 [NadeuriService.createNadeuri]가 반환한 [NadeuriSummaryResponse]와 동일한지
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
    void updateNadeuri() {
        // Given
        UUID uuid = UUID.randomUUID();
        String newTitle = "new_test_title";
        UpdateNadeuriRequest updateNadeuriTitleRequest = UpdateNadeuriRequest.builder()
                .title(newTitle).build();
        NadeuriSummaryResponse nadeuriSummaryResponse = NadeuriSummaryResponse.builder()
                .uuid(uuid)
                .title(newTitle).build();

        when(nadeuriService.updateNadeuri(principalDetails, uuid, updateNadeuriTitleRequest))
                .thenReturn(nadeuriSummaryResponse);

        // When
        ResponseEntity<ResponseDto<NadeuriSummaryResponse>> result =
                nadeuriController.updateNadeuri(principalDetails, uuid, updateNadeuriTitleRequest);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환하는지
        ResponseDto<NadeuriSummaryResponse> body = result.getBody();
        assertNotNull(body); // 응답에 본문을 담고 있는지
        assertThat(body.getData()).isEqualTo(nadeuriSummaryResponse); // 응답 본문의 데이터가 [NadeuriService.updateNadeuri]가 반환한 [NadeuriSummaryResponse]와 동일한지
    }
}
