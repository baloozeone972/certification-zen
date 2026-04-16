// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/adapter/UserPreferencesRepositoryAdapter.java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.user.UserPreferences;
import com.certifapp.domain.port.output.UserPreferencesRepository;
import com.certifapp.infrastructure.persistence.mapper.UserMapper;
import com.certifapp.infrastructure.persistence.repository.UserPreferencesJpaRepository;
import org.springframework.stereotype.Component;

import java.util.Optional;
import java.util.UUID;

/**
 * Adapter implementing {@link UserPreferencesRepository} using Spring Data JPA.
 */
@Component
public class UserPreferencesRepositoryAdapter implements UserPreferencesRepository {

    private final UserPreferencesJpaRepository jpaRepository;
    private final UserMapper mapper;

    public UserPreferencesRepositoryAdapter(
            UserPreferencesJpaRepository jpaRepository, UserMapper mapper) {
        this.jpaRepository = jpaRepository;
        this.mapper        = mapper;
    }

    @Override
    public Optional<UserPreferences> findByUserId(UUID userId) {
        return jpaRepository.findById(userId).map(mapper::toDomain);
    }

    @Override
    public UserPreferences save(UserPreferences preferences) {
        return mapper.toDomain(jpaRepository.save(mapper.toEntity(preferences)));
    }
}
