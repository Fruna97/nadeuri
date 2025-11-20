package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.List;
import java.util.UUID;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriTitleRequest;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

public interface NadeuriService {

    void createNadeuri(PrincipalDetails principalDetails, String title);

    List<NadeuriSummaryResponse> getParticipatingNadeuris(PrincipalDetails principalDetails);

    void updateNadeuriTitle(PrincipalDetails principalDetails, UUID nadeuriUuid,
            UpdateNadeuriTitleRequest updateNadeuriTitleRequest);
}
