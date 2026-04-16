// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/adapter/UserAnswerRepositoryAdapter.java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.session.UserAnswer;
import com.certifapp.domain.port.output.UserAnswerRepository;
import com.certifapp.infrastructure.persistence.mapper.ExamSessionMapper;
import com.certifapp.infrastructure.persistence.repository.UserAnswerJpaRepository;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.UUID;

/**
 * Adapter implementing {@link UserAnswerRepository}.
 */
@Component
public class UserAnswerRepositoryAdapter implements UserAnswerRepository {

    private final UserAnswerJpaRepository jpaRepository;
    private final ExamSessionMapper       mapper;

    public UserAnswerRepositoryAdapter(
            UserAnswerJpaRepository jpaRepository, ExamSessionMapper mapper) {
        this.jpaRepository = jpaRepository;
        this.mapper        = mapper;
    }

    @Override
    public UserAnswer save(UserAnswer answer) {
        return mapper.toDomain(jpaRepository.save(mapper.toEntity(answer)));
    }

    @Override
    public List<UserAnswer> saveAll(List<UserAnswer> answers) {
        var entities = answers.stream().map(mapper::toEntity).toList();
        return mapper.toDomainAnswerList(jpaRepository.saveAll(entities));
    }

    @Override
    public List<UserAnswer> findBySessionId(UUID sessionId) {
        return mapper.toDomainAnswerList(
                jpaRepository.findBySessionIdOrderByAnsweredAt(sessionId));
    }
}
