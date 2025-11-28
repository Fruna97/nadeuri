package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.NadeuriRepository;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NadeuriServiceImpl implements NadeuriService {

    private final NadeuriRepository nadeuriRepository;
    private final MemberRepository memberRepository;

    @Autowired
    public NadeuriServiceImpl(NadeuriRepository nadeuriRepository,
            MemberRepository memberRepository) {
        this.nadeuriRepository = nadeuriRepository;
        this.memberRepository = memberRepository;
    }

    @Override
    @Transactional
    public NadeuriSummaryResponse createNadeuri(PrincipalDetails principalDetails, CreateNadeuriRequest createNadeuriRequest) {
        String title = createNadeuriRequest.getTitle();
        Member owner = memberRepository.getReferenceById(principalDetails.getId());

        Nadeuri nadeuri = Nadeuri.builder()
                .title(title)
                .owner(owner)
                .build();
        nadeuri.getMembers().add(owner);
        Nadeuri savedNadeuri = nadeuriRepository.save(nadeuri);

        return NadeuriSummaryResponse.fromEntity(savedNadeuri);
    }

    @Override
    @Transactional(readOnly = true)
    public NadeuriSummaryResponse getNadeuri(PrincipalDetails principalDetails, UUID nadeuriUuid) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid).orElseThrow();

        if (!nadeuri.hasAuthorityToNadeuri(principalDetails)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 조회 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        return NadeuriSummaryResponse.fromEntity(nadeuri);
    }

    @Override
    @Transactional
    public List<NadeuriSummaryResponse> getParticipatingNadeuris(PrincipalDetails principalDetails) {
        List<Nadeuri> participatingNadeuris = nadeuriRepository.findByMembers_Id(principalDetails.getId());

        return participatingNadeuris.stream()
                .map(NadeuriSummaryResponse::fromEntity).toList();
    }

    @Override
    @Transactional
    public NadeuriSummaryResponse updateNadeuri(PrincipalDetails principalDetails, UUID nadeuriUuid,
            UpdateNadeuriRequest updateNadeuriRequest) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid).orElseThrow();

        if (!nadeuri.hasAuthorityToNadeuri(principalDetails)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 수정 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        if (updateNadeuriRequest.getTitle() != null) nadeuri.setTitle(updateNadeuriRequest.getTitle());

        return NadeuriSummaryResponse.fromEntity(nadeuri);
    }
}
