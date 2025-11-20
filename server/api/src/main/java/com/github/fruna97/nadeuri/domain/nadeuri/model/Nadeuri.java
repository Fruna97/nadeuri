package com.github.fruna97.nadeuri.domain.nadeuri.model;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import com.fasterxml.uuid.Generators;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class Nadeuri {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(nullable = false, unique = true)
    private UUID uuid;

    @Column(length = 100)
    private String title;

    @ManyToOne(optional = false)
    @JoinColumn(name = "owner_id", nullable = false)
    private Member owner;

    @ManyToMany
    @JoinTable(name = "nadeuri_member", 
            joinColumns = @JoinColumn(name = "nadeuri_id"),
            inverseJoinColumns = @JoinColumn(name = "member_id"))
    @Builder.Default
    @Fetch(FetchMode.SUBSELECT)
    private List<Member> members = new ArrayList<>();

    // TODO: Spring Data JPA 4.0.0 이상에서 Hibernate의 @UuidGenerator 사용으로 리팩터링할 것 (GitHub Issue #6)
    @PrePersist
    void prePersist() {
        if (uuid == null) {
            uuid = Generators.timeBasedEpochGenerator().generate();
        }
    }
}
