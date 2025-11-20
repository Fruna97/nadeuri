package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriTitleRequest;
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
    public void createNadeuri(PrincipalDetails principalDetails, String title) {
        Member owner = memberRepository.getReferenceById(principalDetails.getId());

        Nadeuri nadeuri = Nadeuri.builder()
                .title(title)
                .owner(owner)
                .build();
        nadeuri.getMembers().add(owner);
        nadeuriRepository.save(nadeuri);
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
    public void updateNadeuriTitle(PrincipalDetails principalDetails, UUID nadeuriUuid,
            UpdateNadeuriTitleRequest updateNadeuriTitleRequest) {
        Nadeuri nadeuri = nadeuriRepository.findByUuid(nadeuriUuid).orElseThrow();

        if (!hasAuthorityToNadeuri(principalDetails, nadeuri)) {
            log.warn("비정상적인 요청 발생: Nadeuri에 참가중이지 않은 회원의 수정 요청");
            throw new BadCredentialsException("자격 증명에 실패하였습니다.");
        }

        nadeuri.setTitle(updateNadeuriTitleRequest.getNewTitle());
    }

    /**
     * Principal에 해당하는 회원이 Nadeuri를 수정할 수 있는 권한을 가지고 있는지 확인합니다.
     * 
     * @param principalDetails 회원의 정보가 담긴 Principal.
     * @param nadeuri [principalDetails]에 해당하는 회원이 속해있는지 확인할 Nadeuri. {@code members} 필드에 접근하기 위해,
     *        <strong>반드시 Managed(Attached) 상태의 엔티티를 전달해야합니다.</strong>
     * @return Principal에 해당하는 회원이 Nadeuri에 대한 수정 권한이 있는지 여부.
     */
    private boolean hasAuthorityToNadeuri(PrincipalDetails principalDetails, Nadeuri nadeuri) {
        return nadeuri.getMembers().stream()
                .anyMatch(member -> member.getId().equals(principalDetails.getId()));
    }
}
