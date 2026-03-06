package com.github.fruna97.nadeuri.domain.nadeuri.model;

import java.time.LocalDateTime;
import java.util.UUID;
import org.hibernate.annotations.CreationTimestamp;
import com.fasterxml.uuid.Generators;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Table(
    name = "invite",
    uniqueConstraints = {
        // 같은 나들이에 같은 회원 중복 초대 막음
        @UniqueConstraint(
            columnNames = {"nadeuri_id", "invitee_id"}
        ),
    }
)
public class Invite {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(nullable = false, unique = true)
    private UUID uuid;

    @ManyToOne(optional = false)
    @JoinColumn(name = "inviter_id", nullable = false)
    private Member inviter;

    @ManyToOne(optional = false)
    @JoinColumn(name = "invitee_id", nullable = false)
    private Member invitee;

    @ManyToOne(optional = false)
    @JoinColumn(name = "nadeuri_id", nullable = false)
    private Nadeuri nadeuri;

    @Column(nullable = false)
    @CreationTimestamp
    private LocalDateTime createdAt;

    // TODO: Spring Data JPA 4.0.0 이상에서 Hibernate의 @UuidGenerator 사용으로 리팩터링할 것 (GitHub Issue #6)
    @PrePersist
    void prePersist() {
        if (uuid == null) {
            uuid = Generators.timeBasedEpochGenerator().generate();
        }
    }
}
