// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/adapter/FlashcardRepositoryAdapter.java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.learning.Flashcard;
import com.certifapp.domain.port.output.FlashcardRepository;
import com.certifapp.infrastructure.persistence.entity.FlashcardEntity;
import com.certifapp.infrastructure.persistence.repository.FlashcardJpaRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * Adapter implementing {@link FlashcardRepository}.
 */
@Component
public class FlashcardRepositoryAdapter implements FlashcardRepository {

    private final FlashcardJpaRepository jpaRepository;

    public FlashcardRepositoryAdapter(FlashcardJpaRepository jpaRepository) {
        this.jpaRepository = jpaRepository;
    }

    @Override
    public List<Flashcard> findDueByUserAndCertification(
            UUID userId, String certificationId, int limit) {
        var entities = jpaRepository.findDueByUserAndCertification(
                userId, certificationId, LocalDate.now(), PageRequest.of(0, limit));
        return entities.stream().map(this::toDomain).toList();
    }

    @Override
    public Flashcard save(Flashcard flashcard) {
        return toDomain(jpaRepository.save(toEntity(flashcard)));
    }

    @Override
    public List<Flashcard> saveAll(List<Flashcard> flashcards) {
        return flashcards.stream().map(this::save).toList();
    }

    // ── Inline mapping (no MapStruct needed for simple record) ───────────────

    private Flashcard toDomain(FlashcardEntity e) {
        return new Flashcard(e.getId(), e.getQuestionId(), e.getCourseId(),
                e.getFrontText(), e.getBackText(), e.getCodeExample(),
                e.isAiGenerated(), e.getCreatedAt());
    }

    private FlashcardEntity toEntity(Flashcard f) {
        FlashcardEntity e = new FlashcardEntity();
        e.setId(f.id());
        e.setQuestionId(f.questionId());
        e.setCourseId(f.courseId());
        e.setFrontText(f.frontText());
        e.setBackText(f.backText());
        e.setCodeExample(f.codeExample());
        e.setAiGenerated(f.aiGenerated());
        e.setCreatedAt(f.createdAt());
        return e;
    }
}
