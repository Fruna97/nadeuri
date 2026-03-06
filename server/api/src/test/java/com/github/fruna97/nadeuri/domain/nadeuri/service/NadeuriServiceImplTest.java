package com.github.fruna97.nadeuri.domain.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.AuthenticationException;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.NadeuriRepository;

@ExtendWith(MockitoExtension.class)
@Transactional
class NadeuriServiceImplTest {

    @Mock
    private NadeuriRepository nadeuriRepository;

    @Mock
    private MemberRepository memberRepository;

    @InjectMocks
    private NadeuriServiceImpl nadeuriServiceImpl;

    @Test
    void createNadeuri() {
        // Given
        UUID memberUuid = UUID.randomUUID();
        Member member = Member.builder()
                .uuid(memberUuid).build();
        String title = "test_title";

        CreateNadeuriRequest createNadeuriRequest = CreateNadeuriRequest.builder()
                .title(title).build();
        Nadeuri savedNadeuri = Nadeuri.builder()
                .id(0L)
                .title(title)
                .owner(member)
                .members(List.of(member)).build();

        when(memberRepository.findByUuid(memberUuid)).thenReturn(Optional.of(member));
        when(nadeuriRepository.save(any(Nadeuri.class))).thenReturn(savedNadeuri);

        // When
        NadeuriSummaryResponse result = nadeuriServiceImpl.createNadeuri(memberUuid, createNadeuriRequest);

        // Then
        assertThat(result.getTitle()).isEqualTo(title); // 주어진 제목을 그대로 저장하는지
        assertThat(result.getMembers())
                .anySatisfy(memberSummaryResponse -> assertThat(memberSummaryResponse.getUuid())
                        .isEqualTo(memberUuid)); // Nadeuri의 멤버 목록에 만든 회원이 포함되어 있는지
    }

    @Test
    void getNadeuri() {
        // Given
        UUID memberUuid = UUID.randomUUID();
        Member member = Member.builder()
                .uuid(memberUuid).build();

        long nadeuriId = 0L;
        UUID nadeuriUuid = UUID.randomUUID();
        String nadeuriTitle = "test_title";
        Nadeuri nadeuri = Nadeuri.builder()
                .id(nadeuriId)
                .uuid(nadeuriUuid)
                .title(nadeuriTitle)
                .members(List.of(member)).build();
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));

        // When
        NadeuriSummaryResponse result = nadeuriServiceImpl.getNadeuri(memberUuid, nadeuriUuid);

        // Then
        assertAll(() -> assertThat(result.getUuid()).isEqualTo(nadeuriUuid),
                () -> assertThat(result.getTitle()).isEqualTo(nadeuriTitle)); // 조회 결과가 저장소에서 가져온 Nadeuri와 일치하는지
    }

    @Test
    void getNadeuri_조회권한이없는회원() {
        // Given
        UUID memberHasAuthorityUuid = UUID.randomUUID();
        Member memberHasAuthority = Member.builder()
                .uuid(memberHasAuthorityUuid).build();

        long nadeuriId = 0L;
        UUID nadeuriUuid = UUID.randomUUID();
        String nadeuriTitle = "test_title";
        Nadeuri nadeuri = Nadeuri.builder()
                .id(nadeuriId)
                .uuid(nadeuriUuid)
                .title(nadeuriTitle)
                .members(List.of(memberHasAuthority)).build();
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));

        UUID memberWithoutAuthorityUuid = UUID.randomUUID();

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            nadeuriServiceImpl.getNadeuri(memberWithoutAuthorityUuid, nadeuriUuid);
        }); // Nadeuri에 참가중이지 않은 회원이 조회 요청을 했을 때, 인증 예외를 발생시키는지
    }

    @Test
    void getParticipatingNadeuris() {
        // Given
        List<Nadeuri> participatingNadeuris = new ArrayList<>();
        UUID memberUuid = UUID.randomUUID();
        Member member = Member.builder()
                .uuid(memberUuid)
                .email("test_email@test.com")
                .password("test_password")
                .nickname("test_nickname").build();

        UUID uuid1 = UUID.randomUUID();
        UUID uuid2 = UUID.randomUUID();
        String title1 = "title1";
        String title2 = "title2";
        Nadeuri nadeuri1 = Nadeuri.builder()
                .id(97L)
                .uuid(uuid1)
                .title(title1)
                .owner(member)
                .members(List.of(member)).build();
        Nadeuri nadeuri2 = Nadeuri.builder()
                .id(98L)
                .uuid(uuid2)
                .title(title2)
                .owner(member)
                .members(List.of(member)).build();
        participatingNadeuris.add(nadeuri1);
        participatingNadeuris.add(nadeuri2);
        when(nadeuriRepository.findByMembers_Uuid(memberUuid)).thenReturn(participatingNadeuris);

        // When
        List<NadeuriSummaryResponse> result = nadeuriServiceImpl.getParticipatingNadeuris(memberUuid);

        // Then
        assertThat(result).hasSize(2); // 참가 Nadeuri 목록의 개수가 정확한지

        List<UUID> uuids = result.stream()
                .map(NadeuriSummaryResponse::getUuid).toList();
        assertThat(uuids).containsExactlyInAnyOrder(uuid1, uuid2);// 저장된 UUID를 그대로 가지고 오는지
        List<String> titles = result.stream()
                .map(NadeuriSummaryResponse::getTitle).toList();
        assertThat(titles).containsExactlyInAnyOrder(title1, title2); // 저장된 제목을 그대로 가지고 오는지
        assertThat(result).allSatisfy(
                participatingNadeuriResponse -> assertThat(participatingNadeuriResponse.getMembers())
                        .extracting(MemberSummaryResponse::getUuid).contains(memberUuid)); // 각 Nadeuri 회원 목록에 생성한 회원이 포함되어 있는지
    }

    @Test
    void updateNadeuri() {
        // Given
        UUID memberUuid = UUID.randomUUID();
        UUID nadeuriUuid = UUID.randomUUID();
        String newNadeuriTitle = "new_title";
        UpdateNadeuriRequest updateNadeuriTitleRequest = UpdateNadeuriRequest.builder()
                .title(newNadeuriTitle).build();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(memberUuid)).thenReturn(true);

        Nadeuri savedNadeuri = Nadeuri.builder()
                .uuid(nadeuriUuid)
                .title(newNadeuriTitle).build();
        when(nadeuriRepository.save(nadeuri)).thenReturn(savedNadeuri);

        // When
        nadeuriServiceImpl.updateNadeuri(memberUuid, nadeuriUuid, updateNadeuriTitleRequest);

        // Then
        assertAll(() -> verify(nadeuri).setTitle(newNadeuriTitle)); // Entity의 Setter들을 정확한 매개변수를 넣어 모두 호출했는지
        verify(nadeuriRepository).save(nadeuri); // 명시적으로 [save] 메서드를 호출했는지
    }

    @Test
    void updateNadeuri_수정권한이없는회원() {
        // Given
        UUID memberUuid = UUID.randomUUID();
        UUID nadeuriUuid = UUID.randomUUID();
        String newNadeuriTitle = "new_title";
        UpdateNadeuriRequest updateNadeuriTitleRequest = UpdateNadeuriRequest.builder()
                .title(newNadeuriTitle).build();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(memberUuid)).thenReturn(false);

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            nadeuriServiceImpl.updateNadeuri(memberUuid, nadeuriUuid,
                    updateNadeuriTitleRequest);
        }); // Nadeuri에 참가중이지 않은 회원이 수정 요청을 했을 때, 인증 예외를 발생시키는지
    }
}
