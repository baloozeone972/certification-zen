// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/ExamSessionJpaRepository.java
package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.ExamSessionEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Spring Data JPA repository for {@link ExamSessionEntity}.
 */
@Repository
public interface ExamSessionJpaRepository extends JpaRepository<ExamSessionEntity, UUID> {

    /** Count EXAM sessions started today — used for freemium daily limit check. */
    @Query("SELECT COUNT(s) FROM ExamSessionEntity s " +
           "WHERE s.userId = :userId AND s.certificationId = :certId " +
           "AND s.mode = :mode AND s.startedAt >= :startOfDay")
    int countTodayByUserAndCertification(
            @Param("userId")   UUID userId,
            @Param("certId")   String certId,
            @Param("mode")     String mode,
            @Param("startOfDay") OffsetDateTime startOfDay);

    @Query("SELECT s FROM ExamSessionEntity s " +
           "WHERE s.userId = :userId " +
           "AND (:certId IS NULL OR s.certificationId = :certId) " +
           "AND (:mode IS NULL OR s.mode = :mode) " +
           "AND (:from IS NULL OR s.startedAt >= :from) " +
           "AND (:to IS NULL OR s.startedAt <= :to) " +
           "ORDER BY s.startedAt DESC")
    Page<ExamSessionEntity> findByUserIdWithFilters(
            @Param("userId") UUID userId,
            @Param("certId") String certId,
            @Param("mode")   String mode,
            @Param("from")   OffsetDateTime from,
            @Param("to")     OffsetDateTime to,
            Pageable pageable);
}
