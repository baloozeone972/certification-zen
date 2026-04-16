// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/UserAnswerJpaRepository.java
package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.UserAnswerEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * Spring Data JPA repository for {@link UserAnswerEntity}.
 */
@Repository
public interface UserAnswerJpaRepository extends JpaRepository<UserAnswerEntity, UUID> {

    List<UserAnswerEntity> findBySessionIdOrderByAnsweredAt(UUID sessionId);
}
