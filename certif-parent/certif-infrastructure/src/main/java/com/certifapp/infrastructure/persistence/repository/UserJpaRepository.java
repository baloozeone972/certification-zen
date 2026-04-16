// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/UserJpaRepository.java
package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

/**
 * Spring Data JPA repository for {@link UserEntity}.
 */
@Repository
public interface UserJpaRepository extends JpaRepository<UserEntity, UUID> {

    Optional<UserEntity> findByEmail(String email);

    boolean existsByEmail(String email);
}
