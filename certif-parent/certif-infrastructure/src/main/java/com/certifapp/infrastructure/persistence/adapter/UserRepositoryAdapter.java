// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/adapter/UserRepositoryAdapter.java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.user.User;
import com.certifapp.domain.port.output.UserRepository;
import com.certifapp.infrastructure.persistence.entity.UserEntity;
import com.certifapp.infrastructure.persistence.mapper.UserMapper;
import com.certifapp.infrastructure.persistence.repository.UserJpaRepository;
import org.springframework.stereotype.Component;

import java.util.Optional;
import java.util.UUID;

/**
 * Adapter implementing {@link UserRepository} using Spring Data JPA.
 * Converts between domain Records and JPA entities via MapStruct.
 */
@Component
public class UserRepositoryAdapter implements UserRepository {

    private final UserJpaRepository jpaRepository;
    private final UserMapper        mapper;

    public UserRepositoryAdapter(UserJpaRepository jpaRepository, UserMapper mapper) {
        this.jpaRepository = jpaRepository;
        this.mapper        = mapper;
    }

    @Override
    public Optional<User> findById(UUID id) {
        return jpaRepository.findById(id).map(mapper::toDomain);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return jpaRepository.findByEmail(email).map(mapper::toDomain);
    }

    @Override
    public boolean existsByEmail(String email) {
        return jpaRepository.existsByEmail(email);
    }

    @Override
    public User save(User user) {
        UserEntity entity = mapper.toEntity(user);
        return mapper.toDomain(jpaRepository.save(entity));
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }
}
