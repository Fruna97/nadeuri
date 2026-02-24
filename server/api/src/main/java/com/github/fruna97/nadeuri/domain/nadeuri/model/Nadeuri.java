package com.github.fruna97.nadeuri.domain.nadeuri.model;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import com.fasterxml.uuid.Generators;
import com.github.fruna97.nadeuri.domain.member.model.Member;
import com.github.fruna97.nadeuri.security.PrincipalDetails;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
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

    @OneToMany(mappedBy = "nadeuri")
    @Builder.Default
    @Fetch(FetchMode.SUBSELECT)
    private List<Plan> plans = new ArrayList<>();

    // TODO: Spring Data JPA 4.0.0 이상에서 Hibernate의 @UuidGenerator 사용으로 리팩터링할 것 (GitHub Issue #6)
    @PrePersist
    void prePersist() {
        if (uuid == null) {
            uuid = Generators.timeBasedEpochGenerator().generate();
        }
    }

    /**
     * Principal에 해당하는 회원이 Nadeuri를 수정할 수 있는 권한을 가지고 있는지 확인합니다.
     * <p>
     * LAZY하게 Fetch되는 {@code members} 필드에 접근하기 위해, <strong>Managed(Attached) 상태의 엔티티에서 사용하는 것을
     * 권장합니다.</strong>
     * 
     * @param principalDetails 회원의 정보가 담긴 Principal.
     * @return Principal에 해당하는 회원이 Nadeuri에 대한 수정 권한이 있는지 여부.
     */
    public boolean hasAuthorityToNadeuri(PrincipalDetails principalDetails) {
        return members.stream().anyMatch(member -> member.getId().equals(principalDetails.getId()));
    }
}
