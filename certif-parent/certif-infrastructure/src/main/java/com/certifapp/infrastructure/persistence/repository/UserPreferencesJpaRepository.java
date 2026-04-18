// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/UserPreferencesJpaRepository.java
package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.UserPreferencesEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

/**
 * Spring Data JPA repository for {@link UserPreferencesEntity}.
 */
@Repository
public interface UserPreferencesJpaRepository extends JpaRepository<UserPreferencesEntity, UUID> {
}
