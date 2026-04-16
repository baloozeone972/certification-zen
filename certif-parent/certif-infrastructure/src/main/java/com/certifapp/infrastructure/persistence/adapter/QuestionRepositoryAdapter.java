// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/adapter/QuestionRepositoryAdapter.java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.certification.CertificationTheme;
import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.question.QuestionFilter;
import com.certifapp.domain.port.output.CertificationRepository;
import com.certifapp.domain.port.output.QuestionRepository;
import com.certifapp.infrastructure.persistence.entity.QuestionEntity;
import com.certifapp.infrastructure.persistence.entity.QuestionOptionEntity;
import com.certifapp.infrastructure.persistence.mapper.QuestionMapper;
import com.certifapp.infrastructure.persistence.repository.QuestionJpaRepository;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Adapter implementing {@link QuestionRepository}.
 * Handles random selection and theme-based filtering.
 */
@Component
public class QuestionRepositoryAdapter implements QuestionRepository {

    private final QuestionJpaRepository jpaRepository;
    private final CertificationRepository certificationRepository;
    private final QuestionMapper mapper;

    public QuestionRepositoryAdapter(
            QuestionJpaRepository    jpaRepository,
            CertificationRepository  certificationRepository,
            QuestionMapper           mapper) {
        this.jpaRepository           = jpaRepository;
        this.certificationRepository = certificationRepository;
        this.mapper                  = mapper;
    }

    @Override
    public Optional<Question> findById(UUID id) {
        return jpaRepository.findById(id).map(mapper::toDomain);
    }

    @Override
    public Optional<Question> findByLegacyId(String legacyId) {
        return jpaRepository.findByLegacyId(legacyId).map(mapper::toDomain);
    }

    @Override
    public List<Question> findByFilter(QuestionFilter filter) {
        List<QuestionEntity> entities;

        if (filter.themeCodes().isEmpty()) {
            entities = jpaRepository.findByCertificationIdActiveRandom(filter.certificationId());
        } else {
            // Resolve theme codes to UUIDs
            List<UUID> themeIds = resolveThemeIds(filter.certificationId(), filter.themeCodes());
            entities = jpaRepository.findByCertificationIdAndThemeIdsRandom(
                    filter.certificationId(), themeIds);
        }

        // Apply limit
        if (filter.limit() > 0 && entities.size() > filter.limit()) {
            entities = entities.subList(0, filter.limit());
        }

        return mapper.toDomainList(entities);
    }

    @Override
    public Map<String, Integer> countByTheme(String certificationId) {
        List<Object[]> raw = jpaRepository.countByThemeForCertification(certificationId);
        Map<String, Integer> result = new LinkedHashMap<>();
        for (Object[] row : raw) {
            UUID themeId = (UUID) row[0];
            Long count   = (Long) row[1];
            result.put(themeId.toString(), count.intValue());
        }
        return result;
    }

    @Override
    public Question save(Question question) {
        QuestionEntity entity = mapper.toEntity(question);
        // Persist options
        for (var opt : question.options()) {
            QuestionOptionEntity oe = new QuestionOptionEntity();
            oe.setQuestion(entity);
            oe.setLabel(opt.label());
            oe.setText(opt.text());
            oe.setCorrect(opt.isCorrect());
            oe.setDisplayOrder(opt.displayOrder());
            entity.getOptions().add(oe);
        }
        return mapper.toDomain(jpaRepository.save(entity));
    }

    @Override
    public List<Question> saveAll(List<Question> questions) {
        return questions.stream().map(this::save).toList();
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private List<UUID> resolveThemeIds(String certificationId, List<String> themeCodes) {
        return certificationRepository.findById(certificationId)
                .map(cert -> cert.themes().stream()
                        .filter(t -> themeCodes.contains(t.code()))
                        .map(CertificationTheme::id)
                        .filter(Objects::nonNull)
                        .toList())
                .orElse(List.of());
    }
}
