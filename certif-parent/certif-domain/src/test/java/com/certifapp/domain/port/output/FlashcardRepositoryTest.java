package com.certifapp.domain.port.output;

import com.certifapp.domain.model.learning.Flashcard;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verifyNoMoreInteractions;

public class FlashcardRepositoryTest {

    private FlashcardRepository flashcardRepository;
    private FlashcardRepositoryImpl flashcardRepositoryImpl;

    @BeforeEach
    public void setUp() {
        flashcardRepository = new FlashcardRepositoryImpl();
        flashcardRepositoryImpl = new FlashcardRepositoryImpl();
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(flashcardRepository);
    }

    @Test
    @DisplayName("findDueByUserAndCertification_nominalCase")
    public void findDueByUserAndCertification_nominalCase() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int limit = 5;
        List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard(), new Flashcard());

        // Arrange
        flashcardRepository.findDueByUserAndCertification(userId, certificationId, limit);

        // Act
        List<Flashcard> actualFlashcards = flashcardRepositoryImpl.findDueByUserAndCertification(userId, certificationId, limit);

        // Assert
        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
    }

    @Test
    @DisplayName("findDueByUserAndCertification_emptyList")
    public void findDueByUserAndCertification_emptyList() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int limit = 5;
        List<Flashcard> expectedFlashcards = Arrays.asList();

        // Arrange
        flashcardRepository.findDueByUserAndCertification(userId, certificationId, limit);

        // Act
        List<Flashcard> actualFlashcards = flashcardRepositoryImpl.findDueByUserAndCertification(userId, certificationId, limit);

        // Assert
        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
    }

    @Test
    @DisplayName("findDueByUserAndCertification_nullParameters")
    public void findDueByUserAndCertification_nullParameters() {
        UUID userId = null;
        String certificationId = "cert123";
        int limit = 5;

        // Arrange
        flashcardRepository.findDueByUserAndCertification(userId, certificationId, limit);

        // Act & Assert
        assertThatThrownBy(() -> flashcardRepositoryImpl.findDueByUserAndCertification(userId, certificationId, limit))
                .isInstanceOf(NullPointerException.class);
    }

    @Test
    @DisplayName("save_nominalCase")
    public void save_nominalCase() {
        Flashcard flashcard = new Flashcard();
        Flashcard expectedFlashcard = new Flashcard();

        // Arrange
        flashcardRepository.save(flashcard);

        // Act
        Flashcard actualFlashcard = flashcardRepositoryImpl.save(flashcard);

        // Assert
        assertThat(actualFlashcard).isEqualTo(expectedFlashcard);
    }

    @Test
    @DisplayName("save_nullFlashcard")
    public void save_nullFlashcard() {
        Flashcard flashcard = null;

        // Arrange
        flashcardRepository.save(flashcard);

        // Act & Assert
        assertThatThrownBy(() -> flashcardRepositoryImpl.save(flashcard))
                .isInstanceOf(NullPointerException.class);
    }

    @Test
    @DisplayName("saveAll_nominalCase")
    public void saveAll_nominalCase() {
        List<Flashcard> flashcards = Arrays.asList(new Flashcard(), new Flashcard());
        List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard(), new Flashcard());

        // Arrange
        flashcardRepository.saveAll(flashcards);

        // Act
        List<Flashcard> actualFlashcards = flashcardRepositoryImpl.saveAll(flashcards);

        // Assert
        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
    }

    @Test
    @DisplayName("saveAll_emptyList")
    public void saveAll_emptyList() {
        List<Flashcard> flashcards = Arrays.asList();
        List<Flashcard> expectedFlashcards = Arrays.asList();

        // Arrange
        flashcardRepository.saveAll(flashcards);

        // Act
        List<Flashcard> actualFlashcards = flashcardRepositoryImpl.saveAll(flashcards);

        // Assert
        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
    }

    @Test
    @DisplayName("saveAll_nullList")
    public void saveAll_nullList() {
        List<Flashcard> flashcards = null;

        // Arrange
        flashcardRepository.saveAll(flashcards);

        // Act & Assert
        assertThatThrownBy(() -> flashcardRepositoryImpl.saveAll(flashcards))
                .isInstanceOf(NullPointerException.class);
    }
}

// Assuming an implementation exists for testing purposes
class FlashcardRepositoryImpl implements FlashcardRepository {
    @Override
    public List<Flashcard> findDueByUserAndCertification(UUID userId, String certificationId, int limit) {
        // Implementation not shown for brevity
        return null;
    }

    @Override
    public Flashcard save(Flashcard flashcard) {
        // Implementation not shown for brevity
        return null;
    }

    @Override
    public List<Flashcard> saveAll(List<Flashcard> flashcards) {
        // Implementation not shown for brevity
        return null;
    }
}