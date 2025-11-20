package com.github.fruna97.nadeuri.domain.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.spy;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.AuthenticationException;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriTitleRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.NadeuriRepository;
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
        UUID uuid = UUID.randomUUID();
        Member member = Member.builder()
                .id(1L)
                .uuid(uuid)
                .email("test_email@test.com")
                .password("test_password")
                .nickname("test_nickname").build();
        when(memberRepository.getReferenceById(1L)).thenReturn(member);

        String title = "test_title";
        Nadeuri savedNadeuri = Nadeuri.builder()
                .id(97L)
                .title(title).build();
        when(nadeuriRepository.save(any(Nadeuri.class))).thenReturn(savedNadeuri);

        PrincipalDetails principalDetails = new PrincipalDetails(
                member.getId(),
                member.getUuid(),
                member.getEmail(),
                member.getPassword());

        // When
        nadeuriServiceImpl.createNadeuri(principalDetails, title);

        // Then
        verify(nadeuriRepository).save(nadeuriCaptor.capture()); // Repository의 [save]를 호출하는지
        Nadeuri capturedNadeuri = nadeuriCaptor.getValue();
        assertThat(capturedNadeuri.getTitle()).isEqualTo(title); // 주어진 제목을 그대로 저장하는지
        assertThat(capturedNadeuri.getOwner()).isEqualTo(member); // 인증 회원을 Owner로 지정하는지
        assertThat(capturedNadeuri.getMembers()).contains(member); // 인증 회원을 참여 회원 목록에 담는지
    }

    @Test
    void getParticipatingNadeuris() {
        // Given
        List<Nadeuri> participatingNadeuris = new ArrayList<>();
        UUID memberUuid = UUID.randomUUID();
        Member member = Member.builder()
                .id(1L)
                .uuid(memberUuid)
                .email("test_email@test.com")
                .password("test_password")
                .nickname("test_nickname")
                .participatingNadeuris(participatingNadeuris).build();

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
        when(nadeuriRepository.findByMembers_Id(1L)).thenReturn(participatingNadeuris);

        PrincipalDetails principalDetails = new PrincipalDetails(
                member.getId(),
                member.getUuid(),
                member.getEmail(),
                member.getPassword());

        // When
        List<NadeuriSummaryResponse> result = nadeuriServiceImpl.getParticipatingNadeuris(principalDetails);

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
    void updateNadeuriTitle() {
        // Given
        long memberId1 = 0L;
        Member member1 = Member.builder()
                .id(memberId1).build();
        long memberId2 = 1L;
        Member member2 = Member.builder()
                .id(memberId2).build();

        UUID nadeuriUuid = UUID.randomUUID();
        String previousTitle = "Previous Title";
        List<Member> members = List.of(member1, member2);
        Nadeuri nadeuri = Nadeuri.builder()
                .uuid(nadeuriUuid)
                .title(previousTitle)
                .members(members).build();
        Nadeuri spyNadeuri = spy(nadeuri);
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(spyNadeuri));

        String newTitle = "New Title";
        PrincipalDetails principalDetails1 = new PrincipalDetails(memberId1, null, null, null);
        UpdateNadeuriTitleRequest updateNadeuriTitleRequest = UpdateNadeuriTitleRequest.builder()
                .newTitle(newTitle).build();
        

        // When
        nadeuriServiceImpl.updateNadeuriTitle(principalDetails1, nadeuriUuid, updateNadeuriTitleRequest);

        // Then
        verify(spyNadeuri).setTitle(newTitle); // 새로운 제목을 인자로 넣어 [setTitle]을 호출하는지
    }

    @Test
    void updateNadeuriTitle_수정권한이없는사용자() {
        // Given
        long memberHasAuthorityId = 0L;
        Member memberHasAuthority = Member.builder()
                .id(memberHasAuthorityId).build();
        long memberWithoutAuthorityId = 1L;

        UUID nadeuriUuid = UUID.randomUUID();
        String previousTitle = "Previous Title";
        List<Member> members = List.of(memberHasAuthority);
        Nadeuri nadeuri = Nadeuri.builder()
                .uuid(nadeuriUuid)
                .title(previousTitle)
                .members(members).build();
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));

        String newTitle = "New Title";
        PrincipalDetails principalDetailsWithoutAuthority = new PrincipalDetails(memberWithoutAuthorityId, null, null, null);
        UpdateNadeuriTitleRequest updateNadeuriTitleRequest = UpdateNadeuriTitleRequest.builder()
                .newTitle(newTitle).build();

        // When
        // Then
        assertThrows(AuthenticationException.class, () -> {
            nadeuriServiceImpl.updateNadeuriTitle(principalDetailsWithoutAuthority, nadeuriUuid,
                    updateNadeuriTitleRequest);
        }); // Nadeuri에 참가중이지 않은 회원이 수정 요청을 했을 때, 인증 예외를 발생시키는지
    }
}
