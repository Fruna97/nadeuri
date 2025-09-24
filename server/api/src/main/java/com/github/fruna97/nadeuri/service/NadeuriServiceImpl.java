package com.github.fruna97.nadeuri.service;

import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.github.fruna97.nadeuri.domain.Member;
import com.github.fruna97.nadeuri.domain.Nadeuri;
import com.github.fruna97.nadeuri.dto.ParticipatingNadeuriDto;
import com.github.fruna97.nadeuri.repository.MemberRepository;
import com.github.fruna97.nadeuri.repository.NadeuriRepository;
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
    public Set<ParticipatingNadeuriDto> getParticipatingNadeuris(PrincipalDetails principalDetails) {
        Member member = memberRepository.findById(principalDetails.getId()).orElseThrow();
        Set<Nadeuri> participatingNadeuris = member.getParticipatingNadeuris();

        return participatingNadeuris.stream()
                .map(nadeuri -> ParticipatingNadeuriDto.builder()
                        .title(nadeuri.getTitle())
                        .build())
                .collect(Collectors.toSet());
    }
}
