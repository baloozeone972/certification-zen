// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/adapter/SM2ScheduleRepositoryAdapter.java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.learning.SM2Schedule;
import com.certifapp.domain.port.output.SM2ScheduleRepository;
import com.certifapp.infrastructure.persistence.entity.SM2ScheduleEntity;
import com.certifapp.infrastructure.persistence.repository.SM2ScheduleJpaRepository;
import org.springframework.stereotype.Component;

import java.util.Optional;
import java.util.UUID;

/**
 * Adapter implementing {@link SM2ScheduleRepository}.
 */
@Component
public class SM2ScheduleRepositoryAdapter implements SM2ScheduleRepository {

    private final SM2ScheduleJpaRepository jpaRepository;

    public SM2ScheduleRepositoryAdapter(SM2ScheduleJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public Optional<SM2Schedule> findByUserAndQuestion(UUID userId, UUID questionId) {
        return jpaRepository.findByUserIdAndQuestionId(userId, questionId).map(this::toDomain);
    }

    @Override
    public SM2Schedule save(SM2Schedule schedule) {
        return toDomain(jpaRepository.save(toEntity(schedule)));
    }

    private SM2Schedule toDomain(SM2ScheduleEntity e) {
        return new SM2Schedule(e.getId(), e.getUserId(), e.getQuestionId(),
                e.getEaseFactor(), e.getIntervalDays(), e.getRepetitions(),
                e.getDueDate(), e.getLastReviewedAt());
    }

    private SM2ScheduleEntity toEntity(SM2Schedule s) {
        SM2ScheduleEntity e = new SM2ScheduleEntity();
        e.setId(s.id());
        e.setUserId(s.userId());
        e.setQuestionId(s.questionId());
        e.setEaseFactor(s.easeFactor());
        e.setIntervalDays(s.intervalDays());
        e.setRepetitions(s.repetitions());
        e.setDueDate(s.dueDate());
        e.setLastReviewedAt(s.lastReviewedAt());
        return e;
    }
}
