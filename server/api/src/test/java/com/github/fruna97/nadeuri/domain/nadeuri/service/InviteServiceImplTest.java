package com.github.fruna97.nadeuri.domain.nadeuri.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.AuthenticationException;
import com.github.fruna97.nadeuri.domain.member.dto.CreateInviteRequest;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Invite;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.InviteRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.NadeuriRepository;
import com.github.fruna97.nadeuri.exception.InvalidInviteException;
import com.github.fruna97.nadeuri.exception.InvalidInviteExceptionCode;
import com.github.fruna97.nadeuri.exception.InviteNotFoundException;
import com.github.fruna97.nadeuri.exception.MemberNotFoundException;

@ExtendWith(MockitoExtension.class)
class InviteServiceImplTest {

    @Mock
    private InviteRepository inviteRepository;

    @Mock
    private MemberRepository memberRepository;

    @Mock
    private NadeuriRepository nadeuriRepository;

    @InjectMocks
    private InviteServiceImpl inviteServiceImpl;

    @Test
    void createInvite() {
        // Given
        UUID inviterUuid = UUID.randomUUID();
        UUID inviteeUuid = UUID.randomUUID();
        UUID nadeuriUuid = UUID.randomUUID();

        Member inviter = Member.builder().uuid(inviterUuid).email("inviter@test.com").build();
        Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();

        CreateInviteRequest createInviteRequest = CreateInviteRequest.builder()
                .inviteeEmail(invitee.getEmail())
                .build();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(memberRepository.findByUuid(inviterUuid)).thenReturn(Optional.of(inviter));
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.getUuid()).thenReturn(nadeuriUuid);
        when(nadeuri.hasAuthorityToNadeuri(inviterUuid)).thenReturn(true);
        when(memberRepository.findByEmail(invitee.getEmail())).thenReturn(Optional.of(invitee));
        when(nadeuri.isParticipatingMember(inviteeUuid)).thenReturn(false);
        when(inviteRepository.existsByNadeuri_UuidAndInvitee_Uuid(nadeuriUuid, inviteeUuid)).thenReturn(false);

        // When
        inviteServiceImpl.createInvite(inviterUuid, nadeuriUuid, createInviteRequest);

        // Then
        ArgumentCaptor<Invite> inviteCaptor = ArgumentCaptor.forClass(Invite.class);
        verify(inviteRepository).save(inviteCaptor.capture()); // InviteRepository의 save를 호출하는지
        Invite capturedInvite = inviteCaptor.getValue();
        assertEquals(inviterUuid, capturedInvite.getInviter().getUuid()); // 저장되는 초대의 inviter가 올바른지
        assertEquals(inviteeUuid, capturedInvite.getInvitee().getUuid()); // 저장되는 초대의 invitee가 올바른지
        assertEquals(nadeuriUuid, capturedInvite.getNadeuri().getUuid()); // 저장되는 초대의 나들이가 올바른지
    }

    @Test
    void createInvite_자기자신초대() {
        // Given
        UUID memberUuid = UUID.randomUUID();
        UUID nadeuriUuid = UUID.randomUUID();

        Member member = Member.builder().uuid(memberUuid).email("member@test.com").build();
        CreateInviteRequest createInviteRequest = CreateInviteRequest.builder()
                .inviteeEmail(member.getEmail())
                .build();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(memberRepository.findByUuid(memberUuid)).thenReturn(Optional.of(member));
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(memberUuid)).thenReturn(true);
        when(memberRepository.findByEmail(member.getEmail())).thenReturn(Optional.of(member));

        // When
        InvalidInviteException result = assertThrows(InvalidInviteException.class,
                () -> inviteServiceImpl.createInvite(memberUuid, nadeuriUuid, createInviteRequest));

        // Then
        assertThat(result.getInvalidInviteExceptionCode())
                .isEqualTo(InvalidInviteExceptionCode.SELF_INVITE_NOT_ALLOWED); // 자기 자신 초대 예외 코드를 정확히 반환하는지
        verify(inviteRepository, never()).save(any(Invite.class)); // 잘못된 요청에서는 저장하지 않는지
    }

    @Test
    void createInvite_이미참여중인회원초대() {
        // Given
        UUID inviterUuid = UUID.randomUUID();
        UUID inviteeUuid = UUID.randomUUID();
        UUID nadeuriUuid = UUID.randomUUID();

        Member inviter = Member.builder().uuid(inviterUuid).email("inviter@test.com").build();
        Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();

        CreateInviteRequest createInviteRequest = CreateInviteRequest.builder()
                .inviteeEmail(invitee.getEmail())
                .build();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(memberRepository.findByUuid(inviterUuid)).thenReturn(Optional.of(inviter));
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(inviterUuid)).thenReturn(true);
        when(memberRepository.findByEmail(invitee.getEmail())).thenReturn(Optional.of(invitee));
        when(nadeuri.isParticipatingMember(inviteeUuid)).thenReturn(true);

        // When
        InvalidInviteException result = assertThrows(InvalidInviteException.class,
                () -> inviteServiceImpl.createInvite(inviterUuid, nadeuriUuid, createInviteRequest));

        // Then
        assertThat(result.getInvalidInviteExceptionCode())
                .isEqualTo(InvalidInviteExceptionCode.ALREADY_PARTICIPATING); // 이미 참여중인 회원 초대 예외 코드를 정확히 반환하는지
        verify(inviteRepository, never()).save(any(Invite.class)); // 이미 참여중이면 저장하지 않는지
    }

    @Test
    void createInvite_중복초대() {
        // Given
        UUID inviterUuid = UUID.randomUUID();
        UUID inviteeUuid = UUID.randomUUID();
        UUID nadeuriUuid = UUID.randomUUID();

        Member inviter = Member.builder().uuid(inviterUuid).email("inviter@test.com").build();
        Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();

        CreateInviteRequest createInviteRequest = CreateInviteRequest.builder()
                .inviteeEmail(invitee.getEmail())
                .build();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(memberRepository.findByUuid(inviterUuid)).thenReturn(Optional.of(inviter));
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.getUuid()).thenReturn(nadeuriUuid);
        when(nadeuri.hasAuthorityToNadeuri(inviterUuid)).thenReturn(true);
        when(memberRepository.findByEmail(invitee.getEmail())).thenReturn(Optional.of(invitee));
        when(nadeuri.isParticipatingMember(inviteeUuid)).thenReturn(false);
        when(inviteRepository.existsByNadeuri_UuidAndInvitee_Uuid(nadeuriUuid, inviteeUuid)).thenReturn(true);

        // When
        InvalidInviteException result = assertThrows(InvalidInviteException.class,
                () -> inviteServiceImpl.createInvite(inviterUuid, nadeuriUuid, createInviteRequest));

        // Then
        assertThat(result.getInvalidInviteExceptionCode())
                .isEqualTo(InvalidInviteExceptionCode.DUPLICATE_INVITE); // 중복 초대 예외 코드를 정확히 반환하는지
        verify(inviteRepository, never()).save(any(Invite.class)); // 중복 초대면 저장하지 않는지
    }

    @Test
    void createInvite_존재하지않는초대대상() {
        // Given
        UUID inviterUuid = UUID.randomUUID();
        UUID nadeuriUuid = UUID.randomUUID();

        Member inviter = Member.builder().uuid(inviterUuid).email("inviter@test.com").build();
        CreateInviteRequest createInviteRequest = CreateInviteRequest.builder()
                .inviteeEmail("missing@test.com")
                .build();

        Nadeuri nadeuri = mock(Nadeuri.class);
        when(memberRepository.findByUuid(inviterUuid)).thenReturn(Optional.of(inviter));
        when(nadeuriRepository.findByUuid(nadeuriUuid)).thenReturn(Optional.of(nadeuri));
        when(nadeuri.hasAuthorityToNadeuri(inviterUuid)).thenReturn(true);
        when(memberRepository.findByEmail("missing@test.com")).thenReturn(Optional.empty());

        // When
        // Then
        assertThrows(MemberNotFoundException.class,
                () -> inviteServiceImpl.createInvite(inviterUuid, nadeuriUuid, createInviteRequest)); // 존재하지 않는 초대 대상일 때 예외를 발생시키는지
    }

    @Test
    void acceptInvite() {
        // Given
        UUID inviteeUuid = UUID.randomUUID();
        UUID nadeuriUuid = UUID.randomUUID();
        UUID inviteUuid = UUID.randomUUID();

        Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();
        Nadeuri nadeuri = Nadeuri.builder().uuid(nadeuriUuid).members(new ArrayList<>()).build();
        Invite invite = Invite.builder()
                .uuid(inviteUuid)
                .invitee(invitee)
                .nadeuri(nadeuri)
                .build();

        when(inviteRepository.findByUuid(inviteUuid)).thenReturn(Optional.of(invite));

        // When
        inviteServiceImpl.acceptInvite(inviteeUuid, nadeuriUuid, inviteUuid);

        // Then
        assertThat(nadeuri.getMembers()).extracting(Member::getUuid).contains(inviteeUuid); // 수락 시 멤버 목록에 추가되는지
        verify(inviteRepository).delete(invite); // 처리 후 초대를 삭제하는지
    }

    @Test
    void acceptInvite_이미참여중인회원() {
        // Given
        UUID inviteeUuid = UUID.randomUUID();
                UUID nadeuriUuid = UUID.randomUUID();
        UUID inviteUuid = UUID.randomUUID();

        Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();
        List<Member> members = new ArrayList<>();
        members.add(invitee);
        Nadeuri nadeuri = Nadeuri.builder().uuid(nadeuriUuid).members(members).build();
        Invite invite = Invite.builder()
                .uuid(inviteUuid)
                .invitee(invitee)
                .nadeuri(nadeuri)
                .build();

        when(inviteRepository.findByUuid(inviteUuid)).thenReturn(Optional.of(invite));

        // When
        inviteServiceImpl.acceptInvite(inviteeUuid, nadeuriUuid, inviteUuid);

        // Then
        assertThat(nadeuri.getMembers()).hasSize(1); // 이미 참여중이면 중복 추가하지 않는지
        verify(inviteRepository).delete(invite); // 이미 참여중이어도 초대는 삭제하는지
    }

    @Test
    void acceptInvite_인증회원불일치() {
        // Given
        UUID inviteeUuid = UUID.randomUUID();
        UUID otherMemberUuid = UUID.randomUUID();
        UUID nadeuriUuid = UUID.randomUUID();
        UUID inviteUuid = UUID.randomUUID();

        Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();
        Nadeuri nadeuri = Nadeuri.builder().uuid(nadeuriUuid).members(new ArrayList<>()).build();
        Invite invite = Invite.builder()
                .uuid(inviteUuid)
                .invitee(invitee)
                .nadeuri(nadeuri)
                .build();

        when(inviteRepository.findByUuid(inviteUuid)).thenReturn(Optional.of(invite));

        // When
        // Then
        assertThrows(AuthenticationException.class,
                                () -> inviteServiceImpl.acceptInvite(otherMemberUuid, nadeuriUuid, inviteUuid)); // 인증 회원과 초대 대상이 다르면 인증 예외를 발생시키는지
        verify(inviteRepository, never()).delete(invite); // 인증 실패 시 초대를 삭제하지 않는지
    }

        @Test
        void acceptInvite_다른나들이경로() {
                // Given
                UUID inviteeUuid = UUID.randomUUID();
                UUID nadeuriUuid = UUID.randomUUID();
                UUID otherNadeuriUuid = UUID.randomUUID();
                UUID inviteUuid = UUID.randomUUID();

                Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();
                Nadeuri nadeuri = Nadeuri.builder().uuid(otherNadeuriUuid).members(new ArrayList<>()).build();
                Invite invite = Invite.builder().uuid(inviteUuid).invitee(invitee).nadeuri(nadeuri).build();

                when(inviteRepository.findByUuid(inviteUuid)).thenReturn(Optional.of(invite));

                // When
                // Then
                assertThrows(InviteNotFoundException.class,
                                () -> inviteServiceImpl.acceptInvite(inviteeUuid, nadeuriUuid, inviteUuid)); // 경로의 나들이 UUID와 초대의 나들이 UUID가 다르면 조회 실패로 처리하는지
                verify(inviteRepository, never()).delete(invite); // 경로 불일치 시 초대를 삭제하지 않는지
        }

    @Test
    void rejectInvite() {
        // Given
        UUID inviteeUuid = UUID.randomUUID();
                UUID nadeuriUuid = UUID.randomUUID();
        UUID inviteUuid = UUID.randomUUID();

        Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();
                Nadeuri nadeuri = Nadeuri.builder().uuid(nadeuriUuid).members(new ArrayList<>()).build();
                Invite invite = Invite.builder().uuid(inviteUuid).invitee(invitee).nadeuri(nadeuri).build();

        when(inviteRepository.findByUuid(inviteUuid)).thenReturn(Optional.of(invite));

        // When
        inviteServiceImpl.rejectInvite(inviteeUuid, nadeuriUuid, inviteUuid);

        // Then
        verify(inviteRepository).delete(invite); // 거절 시 초대를 삭제하는지
    }

    @Test
    void rejectInvite_인증회원불일치() {
        // Given
        UUID inviteeUuid = UUID.randomUUID();
        UUID otherMemberUuid = UUID.randomUUID();
                UUID nadeuriUuid = UUID.randomUUID();
        UUID inviteUuid = UUID.randomUUID();

        Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();
                Nadeuri nadeuri = Nadeuri.builder().uuid(nadeuriUuid).members(new ArrayList<>()).build();
                Invite invite = Invite.builder().uuid(inviteUuid).invitee(invitee).nadeuri(nadeuri).build();

        when(inviteRepository.findByUuid(inviteUuid)).thenReturn(Optional.of(invite));

        // When
        // Then
        assertThrows(AuthenticationException.class,
                                () -> inviteServiceImpl.rejectInvite(otherMemberUuid, nadeuriUuid, inviteUuid)); // 인증 회원과 초대 대상이 다르면 인증 예외를 발생시키는지
        verify(inviteRepository, never()).delete(invite); // 인증 실패 시 초대를 삭제하지 않는지
    }

        @Test
        void rejectInvite_다른나들이경로() {
                // Given
                UUID inviteeUuid = UUID.randomUUID();
                UUID nadeuriUuid = UUID.randomUUID();
                UUID otherNadeuriUuid = UUID.randomUUID();
                UUID inviteUuid = UUID.randomUUID();

                Member invitee = Member.builder().uuid(inviteeUuid).email("invitee@test.com").build();
                Nadeuri nadeuri = Nadeuri.builder().uuid(otherNadeuriUuid).members(new ArrayList<>()).build();
                Invite invite = Invite.builder().uuid(inviteUuid).invitee(invitee).nadeuri(nadeuri).build();

                when(inviteRepository.findByUuid(inviteUuid)).thenReturn(Optional.of(invite));

                // When
                // Then
                assertThrows(InviteNotFoundException.class,
                                () -> inviteServiceImpl.rejectInvite(inviteeUuid, nadeuriUuid, inviteUuid)); // 경로의 나들이 UUID와 초대의 나들이 UUID가 다르면 조회 실패로 처리하는지
                verify(inviteRepository, never()).delete(invite); // 경로 불일치 시 초대를 삭제하지 않는지
        }
}
