package com.github.fruna97.nadeuri.domain;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class Nadeuri {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(length = 100)
    private String title;

    @ManyToOne(optional = false)
    @JoinColumn(name = "owner", nullable = false)
    private Member owner;

    @ManyToMany
    @JoinTable(name = "nadeuri_member", 
            joinColumns = @JoinColumn(name = "nadeuri_id"),
            inverseJoinColumns = @JoinColumn(name = "member_id"))
    @Builder.Default
    @Fetch(FetchMode.SUBSELECT)
    private List<Member> members = new ArrayList<>();
}
