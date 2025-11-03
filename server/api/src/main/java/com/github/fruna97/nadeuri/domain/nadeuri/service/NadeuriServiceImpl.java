package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.member.dto.MemberSummaryResponse;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.domain.member.repository.MemberRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.ParticipatingNadeuriResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;
import com.github.fruna97.nadeuri.domain.nadeuri.repository.NadeuriRepository;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

@Service
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
    public Nadeuri createNadeuri(PrincipalDetails principalDetails, String title) {
        Member owner = memberRepository.getReferenceById(principalDetails.getId());

        Nadeuri nadeuri = Nadeuri.builder()
                .title(title)
                .owner(owner)
                .build();
        nadeuri.getMembers().add(owner);

        return nadeuriRepository.save(nadeuri);
    }

    @Override
    @Transactional
    public List<ParticipatingNadeuriResponse> getParticipatingNadeuris(PrincipalDetails principalDetails) {
        List<Nadeuri> participatingNadeuris = nadeuriRepository.findByMembers_Id(principalDetails.getId());

        return participatingNadeuris.stream()
                .map(nadeuri -> ParticipatingNadeuriResponse.builder()
                        .title(nadeuri.getTitle())
                        .members(nadeuri.getMembers().stream()
                                .map(MemberSummaryResponse::from).toList()).build()).toList();
    }
}
