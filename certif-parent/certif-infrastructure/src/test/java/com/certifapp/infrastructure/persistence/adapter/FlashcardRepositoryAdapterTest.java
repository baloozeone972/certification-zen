package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.learning.Flashcard;
import com.certifapp.infrastructure.persistence.entity.FlashcardEntity;
import com.certifapp.infrastructure.persistence.repository.FlashcardJpaRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class FlashcardRepositoryAdapterTest {

    @Mock
    private FlashcardJpaRepository jpaRepository;

    @InjectMocks
    private FlashcardRepositoryAdapter flashcardRepositoryAdapter;

    private UUID userId;
    private String certificationId;
    private int limit;
    private LocalDate today;
    private List<FlashcardEntity> entities;
    private List<Flashcard> domainObjects;

    @BeforeEach
    public void setUp() {
        userId = UUID.randomUUID();
        certificationId = "cert123";
        limit = 5;
        today = LocalDate.now();

        Flashcard flashcard1 = new Flashcard(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(),
                "Question1", "Answer1", "Code1", false, today);
        Flashcard flashcard2 = new Flashcard(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(),
                "Question2", "Answer2", "Code2", true, today);

        domainObjects = Arrays.asList(flashcard1, flashcard2);

        entities = Arrays.asList(
                new FlashcardEntity(flashcard1.id(), flashcard1.questionId(), flashcard1.courseId(),
                        flashcard1.frontText(), flashcard1.backText(), flashcard1.codeExample(),
                        flashcard1.aiGenerated(), flashcard1.createdAt()),
                new FlashcardEntity(flashcard2.id(), flashcard2.questionId(), flashcard2.courseId(),
                        flashcard2.frontText(), flashcard2.backText(), flashcard2.codeExample(),
                        flashcard2.aiGenerated(), flashcard2.createdAt())
        );
    }

    @Test
    @DisplayName("findDueByUserAndCertification_nominalCase_success")
    public void findDueByUserAndCertification_nominalCase_success() {
        when(jpaRepository.findDueByUserAndCertification(userId, certificationId, today, PageRequest.of(0, limit)))
                .thenReturn(entities);

        List<Flashcard> result = flashcardRepositoryAdapter.findDueByUserAndCertification(
                userId, certificationId, limit);

        assertThat(result).isEqualTo(domainObjects);
        verify(jpaRepository, times(1)).findDueByUserAndCertification(userId, certificationId, today, PageRequest.of(0, limit));
    }

    @Test
    @DisplayName("findDueByUserAndCertification_emptyList_success")
    public void findDueByUserAndCertification_emptyList_success() {
        when(jpaRepository.findDueByUserAndCertification(userId, certificationId, today, PageRequest.of(0, limit)))
                .thenReturn(List.of());

        List<Flashcard> result = flashcardRepositoryAdapter.findDueByUserAndCertification(
                userId, certificationId, limit);

        assertThat(result).isEmpty();
        verify(jpaRepository, times(1)).findDueByUserAndCertification(userId, certificationId, today, PageRequest.of(0, limit));
    }

    @Test
    @DisplayName("save_nominalCase_success")
    public void save_nominalCase_success() {
        Flashcard flashcard = new Flashcard(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(),
                "Question1", "Answer1", "Code1", false, today);
        when(jpaRepository.save(any(FlashcardEntity.class))).thenReturn(toEntity(flashcard));

        Flashcard savedFlashcard = flashcardRepositoryAdapter.save(flashcard);

        assertThat(savedFlashcard).isEqualTo(flashcard);
        verify(jpaRepository, times(1)).save(any(FlashcardEntity.class));
    }

    @Test
    @DisplayName("saveAll_nominalCase_success")
    public void saveAll_nominalCase_success() {
        List<Flashcard> flashcards = Arrays.asList(
                new Flashcard(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(),
                        "Question1", "Answer1", "Code1", false, today),
                new Flashcard(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(),
                        "Question2", "Answer2", "Code2", true, today)
        );
        when(jpaRepository.save(any(FlashcardEntity.class))).thenReturn(toEntity(flashcards.get(0)));

        List<Flashcard> savedFlashcards = flashcardRepositoryAdapter.saveAll(flashcards);

        assertThat(savedFlashcards).isEqualTo(flashcards);
        verify(jpaRepository, times(2)).save(any(FlashcardEntity.class));
    }

    private FlashcardEntity toEntity(Flashcard flashcard) {
        FlashcardEntity entity = new FlashcardEntity();
        entity.setId(flashcard.id());
        entity.setQuestionId(flashcard.questionId());
        entity.setCourseId(flashcard.courseId());
        entity.setFrontText(flashcard.frontText());
        entity.setBackText(flashcard.backText());
        entity.setCodeExample(flashcard.codeExample());
        entity.setAiGenerated(flashcard.aiGenerated());
        entity.setCreatedAt(flashcard.createdAt());
        return entity;
    }
}
