package com.github.fruna97.nadeuri.service;

import java.util.Set;
import com.github.fruna97.nadeuri.domain.Nadeuri;
import com.github.fruna97.nadeuri.dto.ParticipatingNadeuriDto;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

public interface NadeuriService {

    Nadeuri createNadeuri(PrincipalDetails principalDetails, String title);

    Set<ParticipatingNadeuriDto> getParticipatingNadeuris(PrincipalDetails principalDetails);
}
