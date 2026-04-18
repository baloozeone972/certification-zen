// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/adapter/ExamSessionRepositoryAdapter.java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.port.output.ExamSessionRepository;
import com.certifapp.infrastructure.persistence.mapper.ExamSessionMapper;
import com.certifapp.infrastructure.persistence.repository.ExamSessionJpaRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Adapter implementing {@link ExamSessionRepository}.
 */
@Component
public class ExamSessionRepositoryAdapter implements ExamSessionRepository {

    private final ExamSessionJpaRepository jpaRepository;
    private final ExamSessionMapper mapper;

    public ExamSessionRepositoryAdapter(
            ExamSessionJpaRepository jpaRepository, ExamSessionMapper mapper) {
        this.jpaRepository = jpaRepository;
        this.mapper = mapper;
    }

    @Override
    public Optional<ExamSession> findById(UUID id) {
        return jpaRepository.findById(id).map(mapper::toDomain);
    }

    @Override
    public int countTodayByUserAndCertification(UUID userId, String certId, ExamMode mode) {
        OffsetDateTime startOfDay = LocalDate.now().atStartOfDay()
                .atOffset(ZoneOffset.UTC);
        return jpaRepository.countTodayByUserAndCertification(
                userId, certId, mode.name(), startOfDay);
    }

    @Override
    public List<ExamSession> findByUserId(UUID userId, String certificationId,
                                          ExamMode mode, java.time.LocalDate from,
                                          java.time.LocalDate to, int page, int size) {
        OffsetDateTime fromDt = from != null ? from.atStartOfDay().atOffset(ZoneOffset.UTC) : null;
        OffsetDateTime toDt = to != null ? to.atTime(LocalTime.MAX).atOffset(ZoneOffset.UTC) : null;
        String modeStr = mode != null ? mode.name() : null;

        return jpaRepository.findByUserIdWithFilters(
                        userId, certificationId, modeStr, fromDt, toDt,
                        PageRequest.of(page, size))
                .map(mapper::toDomain)
                .toList();
    }

    @Override
    public ExamSession save(ExamSession session) {
        return mapper.toDomain(jpaRepository.save(mapper.toEntity(session)));
    }
}
