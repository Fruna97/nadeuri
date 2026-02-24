package com.github.fruna97.nadeuri.exception;

import com.github.fruna97.nadeuri.domain.nadeuri.model.Plan;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PlanNotFoundInNadeuriException extends RuntimeException {

    public PlanNotFoundInNadeuriException(Plan plan) {
        super("Nadeuri안에 속하지 않은 일정에 접근 요청 발생 (Plan ID: " + plan.getId() + ")");
    }
}
