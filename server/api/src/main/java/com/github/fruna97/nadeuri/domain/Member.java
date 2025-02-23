package com.github.fruna97.nadeuri.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Member {
    private Long id;
    private String email;
    private String password;
    private String username;
    private LocalDateTime createDate;
    private String profileImageUrl;
}
