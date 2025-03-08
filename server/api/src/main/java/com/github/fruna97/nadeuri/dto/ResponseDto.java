package com.github.fruna97.nadeuri.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class ResponseDto<T> {

    private String message;
    private T data;
}
