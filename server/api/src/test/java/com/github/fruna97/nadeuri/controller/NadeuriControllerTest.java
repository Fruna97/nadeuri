package com.github.fruna97.nadeuri.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.Set;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import com.github.fruna97.nadeuri.dto.CreateNadeuriDto;
import com.github.fruna97.nadeuri.dto.ParticipatingNadeuriDto;
import com.github.fruna97.nadeuri.dto.ResponseDto;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import com.github.fruna97.nadeuri.service.NadeuriService;

@ExtendWith(MockitoExtension.class)
public class NadeuriControllerTest {

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
        CreateNadeuriDto createNadeuriDto = CreateNadeuriDto.builder()
                .title(title).build();

        // When
        ResponseEntity<ResponseDto<Void>> result = nadeuriController.createNadeuri(principalDetails, createNadeuriDto);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지

        verify(nadeuriService).createNadeuri(any(PrincipalDetails.class), titleCaptor.capture()); // NadeuriService의 createNadeuri 메서드를 호출하는지
        assertThat(titleCaptor.getValue()).isEqualTo(title); // 메서드의 인자에 title을 제대로 전달하는지        
    }

    @Test
    void participatingNadeuris() {
        // Given
        Set<ParticipatingNadeuriDto> participatingNadeuris = Set.of(
            ParticipatingNadeuriDto.builder().title("test_title_1").build(), 
            ParticipatingNadeuriDto.builder().title("test_title_2").build(), 
            ParticipatingNadeuriDto.builder().title("test_title_3").build()
        );
        when(nadeuriService.getParticipatingNadeuris(any(PrincipalDetails.class))).thenReturn(participatingNadeuris);

        // When
        ResponseEntity<ResponseDto<Set<ParticipatingNadeuriDto>>> result = nadeuriController.participatingNadeuris(principalDetails);

        // Then
        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.OK); // 200 OK를 반환 하는지
        ResponseDto<Set<ParticipatingNadeuriDto>> body = result.getBody();
        assertNotNull(body); // 응답에 본문을 담고 있는지
        assertThat(body.getData()).containsExactlyInAnyOrderElementsOf(participatingNadeuris); // 응답 본문의 데이터가 주어진 Nadeuri 목록과 같은지
    }
}
