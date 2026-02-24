package com.github.fruna97.nadeuri.domain.nadeuri.service;

import java.util.List;
import java.util.UUID;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.CreateNadeuriRequest;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.NadeuriSummaryResponse;
import com.github.fruna97.nadeuri.domain.nadeuri.dto.UpdateNadeuriRequest;

public interface NadeuriService {

    NadeuriSummaryResponse createNadeuri(UUID memberUuid, CreateNadeuriRequest createNadeuriRequest);

    NadeuriSummaryResponse getNadeuri(UUID memberUuid, UUID nadeuriUuid);

    List<NadeuriSummaryResponse> getParticipatingNadeuris(UUID memberUuid);

    NadeuriSummaryResponse updateNadeuri(UUID memberUuid, UUID nadeuriUuid,
            UpdateNadeuriRequest updateNadeuriRequest);
}
