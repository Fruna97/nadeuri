package com.github.fruna97.nadeuri.service;

import com.github.fruna97.nadeuri.domain.Nadeuri;
import com.github.fruna97.nadeuri.security.PrincipalDetails;

public interface NadeuriService {

    Nadeuri createNadeuri(PrincipalDetails principalDetails, String title);
}
