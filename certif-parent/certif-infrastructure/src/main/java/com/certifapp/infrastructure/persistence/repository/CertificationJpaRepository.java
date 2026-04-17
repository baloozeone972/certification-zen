// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/CertificationJpaRepository.java
package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.CertificationEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Spring Data JPA repository for {@link CertificationEntity}.
 */
@Repository
public interface CertificationJpaRepository extends JpaRepository<CertificationEntity, String> {

    @Query("SELECT c FROM CertificationEntity c LEFT JOIN FETCH c.themes ORDER BY c.name")
    List<CertificationEntity> findAllWithThemes();

    @Query("SELECT c FROM CertificationEntity c LEFT JOIN FETCH c.themes " +
            "WHERE c.isActive = true ORDER BY c.name")
    List<CertificationEntity> findAllActiveWithThemes();
}
