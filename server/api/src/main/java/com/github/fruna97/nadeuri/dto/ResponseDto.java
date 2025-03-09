package com.github.fruna97.nadeuri.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ResponseDto<T> {

    private String message;
    private T data;
}
