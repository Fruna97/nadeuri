package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.List;
import java.util.UUID;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriRequest;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

public interface NadeuriService {

    NadeuriSummaryResponse createNadeuri(PrincipalDetails principalDetails, CreateNadeuriRequest createNadeuriRequest);

    NadeuriSummaryResponse getNadeuri(PrincipalDetails principalDetails, UUID nadeuriUuid);

    List<NadeuriSummaryResponse> getParticipatingNadeuris(PrincipalDetails principalDetails);

    void updateNadeuri(PrincipalDetails principalDetails, UUID nadeuriUuid,
            UpdateNadeuriRequest updateNadeuriRequest);
}
