package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.List;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.ParticipatingNadeuriResponse;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

public interface NadeuriService {

    void createNadeuri(PrincipalDetails principalDetails, String title);

    List<ParticipatingNadeuriResponse> getParticipatingNadeuris(PrincipalDetails principalDetails);
}
