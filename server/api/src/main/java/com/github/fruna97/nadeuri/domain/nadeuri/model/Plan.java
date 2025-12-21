package com.github.fruna97.nadeuri.domain.nadeuri.model;

import java.time.LocalDateTime;
import java.util.UUID;
import org.hibernate.annotations.CreationTimestamp;
import com.fasterxml.uuid.Generators;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class Plan {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(nullable = false, unique = true)
    private UUID uuid;

    @Column(nullable = false, length = 100)
    private String planTitle;

    private String googlePlacesId;

    private Double latitude;

    private Double longitude;

    @Column(nullable = false)
    private LocalDateTime startAt;

    @Column(nullable = false)
    private LocalDateTime endAt;

    @ManyToOne(optional = false)
    @JoinColumn(name = "nadeuri_id", nullable = false)
    private Nadeuri nadeuri;

    // TODO: Spring Data JPA 4.0.0 이상에서 Hibernate의 @UuidGenerator 사용으로 리팩터링할 것 (GitHub Issue #6)
    @PrePersist
    void prePersist() {
        if (uuid == null) {
            uuid = Generators.timeBasedEpochGenerator().generate();
        }
    }
}
