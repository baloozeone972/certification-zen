// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/FlashcardJpaRepository.java
package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.FlashcardEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * Spring Data JPA repository for {@link FlashcardEntity}.
 */
@Repository
public interface FlashcardJpaRepository extends JpaRepository<FlashcardEntity, UUID> {

    /**
     * Returns flashcards due for review today for a given user and certification.
     * Joins with SM-2 schedule to filter by due date.
     */
    @Query("""
            SELECT f FROM FlashcardEntity f
            JOIN SM2ScheduleEntity s ON s.questionId = f.id
            WHERE s.userId = :userId
            AND f.questionId IN (
                SELECT q.id FROM QuestionEntity q WHERE q.certificationId = :certId
            )
            AND s.dueDate <= :today
            ORDER BY s.dueDate ASC
            """)
    List<FlashcardEntity> findDueByUserAndCertification(
            @Param("userId") UUID userId,
            @Param("certId") String certId,
            @Param("today") LocalDate today,
            org.springframework.data.domain.Pageable pageable);
}
