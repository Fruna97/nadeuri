package com.github.fruna97.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.ParticipatingNadeuriDto;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.NadeuriRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.service.NadeuriServiceImpl;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@ExtendWith(MockitoExtension.class)
@Transactional
class NadeuriServiceImplTest {

    @Mock
    NadeuriRepository nadeuriRepository;

    @Mock
    MemberRepository memberRepository;

    @InjectMocks
    NadeuriServiceImpl nadeuriServiceImpl;

    @Captor
    ArgumentCaptor<Nadeuri> nadeuriCaptor;

    @Test
    void createNadeuri() {
        // Given
        Member member = Member.builder()
                .id(1L)
                .email("test_email@test.com")
                .password("test_password")
                .nickname("test_nickname").build();
        PrincipalDetails principalDetails = new PrincipalDetails(member);
        when(memberRepository.getReferenceById(1L)).thenReturn(member);

        String title = "test_title";
        Nadeuri savedNadeuri = Nadeuri.builder()
                .id(97L)
                .title(title).build();
        when(nadeuriRepository.save(any(Nadeuri.class))).thenReturn(savedNadeuri);

        // When
        Nadeuri result = nadeuriServiceImpl.createNadeuri(principalDetails, title);

        // Then
        assertThat(result).isEqualTo(savedNadeuri); // 저장된 객체를 그대로 반환 하는지

        verify(nadeuriRepository).save(nadeuriCaptor.capture());
        Nadeuri capturedNadeuri = nadeuriCaptor.getValue();
        assertThat(capturedNadeuri.getTitle()).isEqualTo(title); // 주어진 제목을 그대로 저장하는지
        assertThat(capturedNadeuri.getOwner()).isEqualTo(member); // 인증 회원을 Owner로 지정하는지
        assertThat(capturedNadeuri.getMembers()).contains(member); // 인증 회원을 참여 회원 목록에 담는지
    }

    @Test
    void getParticipatingNadeuris() {
        // Given
        List<Nadeuri> participatingNadeuris = new ArrayList<>();
        UUID uuid = UUID.randomUUID();
        Member member = Member.builder()
                .id(1L)
                .uuid(uuid)
                .email("test_email@test.com")
                .password("test_password")
                .nickname("test_nickname")
                .participatingNadeuris(participatingNadeuris).build();
        PrincipalDetails principalDetails = new PrincipalDetails(member);

        String title1 = "title1";
        String title2 = "title2";
        Nadeuri nadeuri1 = Nadeuri.builder()
                .id(97L)
                .title(title1)
                .owner(member)
                .members(List.of(member)).build();
        Nadeuri nadeuri2 = Nadeuri.builder()
                .id(98L)
                .title(title2)
                .owner(member)
                .members(List.of(member)).build();
        participatingNadeuris.add(nadeuri1);
        participatingNadeuris.add(nadeuri2);

        when(nadeuriRepository.findByMembers_Id(1L)).thenReturn(participatingNadeuris);

        // When
        List<ParticipatingNadeuriDto> result = nadeuriServiceImpl.getParticipatingNadeuris(principalDetails);

        // Then
        assertThat(result).hasSize(2); // 참가 Nadeuri 목록의 개수가 정확한지

        List<String> titles = result.stream()
                .map(ParticipatingNadeuriDto::getTitle)
                .toList();
        assertThat(titles).containsExactlyInAnyOrder(title1, title2); // 변환된 DTO가 제목을 그대로 가지고 있는지
        assertThat(result).allSatisfy(
                participatingNadeuriDto -> assertThat(participatingNadeuriDto.getMembers())
                        .extracting(MemberSummaryResponse::getUuid).contains(uuid)); // 각 Nadeuri 회원 목록에 생성한 회원이 포함되어 있는지
    }
}
