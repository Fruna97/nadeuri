package com.github.fruna97.nadeuri.exception;

import com.github.fruna97.nadeuri.domain.nadeuri.model.Plan;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PlanNotFoundInNadeuriException extends RuntimeException {

    public PlanNotFoundInNadeuriException(Plan plan) {
        super("Nadeuri안에 속하지 않은 일정에 접근 요청 발생 (Plan ID: " + plan.getId() + ")");
        log.warn("비정상적인 요청 발생: Nadeuri에 포함되지 않은 일정 조회 요청");
    }
}
