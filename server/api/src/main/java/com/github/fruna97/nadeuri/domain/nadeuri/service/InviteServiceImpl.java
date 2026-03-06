package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
import com.github.fruna97.nadeuri.exception.NadeuriNotFoundException;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class InviteServiceImpl implements InviteService {

    private final NadeuriRepository nadeuriRepository;

    private final MemberRepository memberRepository;

    private InviteRepository inviteRepository;

    @Autowired
    InviteServiceImpl(InviteRepository inviteRepository, MemberRepository memberRepository, NadeuriRepository nadeuriRepository) {
        this.inviteRepository = inviteRepository;
        this.memberRepository = memberRepository;
        this.nadeuriRepository = nadeuriRepository;
    }

    @Override
    @Transactional
    public void createInvite(UUID memberUuid, UUID nadeuriUuid, CreateInviteRequest createInviteRequest) {
        // 초대자 확인
        Member inviter = memberRepository.findByUuid(memberUuid)
                .orElseThrow(() -> {
                    log.warn("존재하지 않는 회원의 초대. UUID : {}", memberUuid);
                    return new BadCredentialsException("자격 증명에 실패하였습니다.");
                });

        // 나들이 확인
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid)
                .orElseThrow(NadeuriNotFoundException::new);
        // invter가 나들이에 권한이 있는지(참가중인지) 확인
        if (!nadeuri.hasAuthorityToNadeuri(memberUuid)) {
            log.warn("비정상적인 요청 발생: 나들이 참가자가 아닌 회원의 초대 생성 요청.");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        // invitee 이메일에 대한 회원이 존재하는지 확인
        Member invitee = memberRepository.findByEmail(createInviteRequest.getInviteeEmail())
                .orElseThrow(() -> {
                    log.warn("존재하지 않는 대상 이메일 조회. Email : {}", createInviteRequest.getInviteeEmail());
                    throw new MemberNotFoundException();
                });

        // 자기 자신 초대 방지
        if (inviter.getUuid().equals(invitee.getUuid())) {
            log.warn("비정상적인 요청 발생: 자기 자신 초대 시도. Member UUID : {}", memberUuid);
            throw new InvalidInviteException(InvalidInviteExceptionCode.SELF_INVITE_NOT_ALLOWED);
        }

        // 이미 참여중인 회원 초대 방지
        if (nadeuri.isParticipatingMember(invitee.getUuid())) {
            throw new InvalidInviteException(InvalidInviteExceptionCode.ALREADY_PARTICIPATING);
        }

        // 중복 초대 방지
        boolean alreadyInviting = inviteRepository.existsByNadeuri_UuidAndInvitee_Uuid(nadeuri.getUuid(), invitee.getUuid());
        if (alreadyInviting) {
            throw new InvalidInviteException(InvalidInviteExceptionCode.DUPLICATE_INVITE);
        }

        // 저장
        Invite invite = Invite.builder()
                .inviter(inviter)
                .invitee(invitee)
                .nadeuri(nadeuri).build();
        inviteRepository.save(invite);
    }

    @Override
    @Transactional
    public void acceptInvite(UUID memberUuid, UUID nadeuriUuid, UUID inviteUuid) {
        // 초대 조회
        Invite invite = inviteRepository.findByUuid(inviteUuid)
                .orElseThrow(InviteNotFoundException::new);

        // Invite의 소속 Nadeuri에 대한 요청인지 확인
        if (!invite.getNadeuri().getUuid().equals(nadeuriUuid)) {
            throw new InviteNotFoundException();
        }

        // 현재 회원이 invitee 인지 확인
        if (!memberUuid.equals(invite.getInvitee().getUuid())) {
            log.warn("비정상적인 요청 발생: 초대받은 회원과 인증된 회원이 다름. 인증 회원 : {}, 초대받은 회원 : {}", memberUuid, invite.getInvitee().getUuid());
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        // 이미 참여중이 아닌경우, 나들이에 회원 추가
        Nadeuri nadeuri = invite.getNadeuri();
        boolean alreadyParticipating = nadeuri.isParticipatingMember(memberUuid);
        if (!alreadyParticipating) {
            nadeuri.getMembers().add(invite.getInvitee());
        }

        // 초대 삭제 (방금 추가된 경우, 이미 참여중인 경우 모두 삭제)
        inviteRepository.delete(invite);
    }

    @Override
    @Transactional
    public void rejectInvite(UUID memberUuid, UUID nadeuriUuid, UUID inviteUuid) {
        // 초대 조회
        Invite invite = inviteRepository.findByUuid(inviteUuid)
                .orElseThrow(InviteNotFoundException::new);

        // Invite의 소속 Nadeuri에 대한 요청인지 확인
        if (!invite.getNadeuri().getUuid().equals(nadeuriUuid)) {
            throw new InviteNotFoundException();
        }

        // 현재 회원이 invitee 인지 확인
        if (!memberUuid.equals(invite.getInvitee().getUuid())) {
            log.warn("비정상적인 요청 발생: 초대받은 회원과 인증된 회원이 다름. 인증 회원 : {}, 초대받은 회원 : {}", memberUuid, invite.getInvitee().getUuid());
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        // 초대 삭제
        inviteRepository.delete(invite);
    }
}
