// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/SM2ScheduleJpaRepository.java
package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.SM2ScheduleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

/**
 * Spring Data JPA repository for {@link SM2ScheduleEntity}.
 */
@Repository
public interface SM2ScheduleJpaRepository extends JpaRepository<SM2ScheduleEntity, UUID> {

    Optional<SM2ScheduleEntity> findByUserIdAndQuestionId(UUID userId, UUID questionId);
}
