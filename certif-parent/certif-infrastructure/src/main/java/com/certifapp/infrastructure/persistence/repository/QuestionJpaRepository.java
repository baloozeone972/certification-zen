// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/QuestionJpaRepository.java
package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.QuestionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Spring Data JPA repository for {@link QuestionEntity}.
 */
@Repository
public interface QuestionJpaRepository extends JpaRepository<QuestionEntity, UUID> {

    Optional<QuestionEntity> findByLegacyId(String legacyId);

    @Query("SELECT q FROM QuestionEntity q WHERE q.certificationId = :certId " +
            "AND q.isActive = true ORDER BY FUNCTION('random')")
    List<QuestionEntity> findByCertificationIdActiveRandom(@Param("certId") String certId);

    @Query("SELECT q FROM QuestionEntity q WHERE q.certificationId = :certId " +
            "AND q.themeId IN :themeIds AND q.isActive = true ORDER BY FUNCTION('random')")
    List<QuestionEntity> findByCertificationIdAndThemeIdsRandom(
            @Param("certId") String certId,
            @Param("themeIds") List<UUID> themeIds);

    @Query("SELECT q.themeId, COUNT(q) FROM QuestionEntity q " +
            "WHERE q.certificationId = :certId AND q.isActive = true GROUP BY q.themeId")
    List<Object[]> countByThemeForCertification(@Param("certId") String certId);

    @Query("SELECT q FROM QuestionEntity q WHERE q.explanationStatus = :status")
    List<QuestionEntity> findByExplanationStatus(@Param("status") String status);

    long countByCertificationIdAndIsActiveTrue(String certificationId);
}
