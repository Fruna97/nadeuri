package com.github.fruna97.nadeuri.domain.nadeuri.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.github.fruna97.nadeuri.domain.nadeuri.model.Nadeuri;

public interface NadeuriRepository extends JpaRepository<Nadeuri, Long> {

    List<Nadeuri> findByMembers_Id(long id);
}
