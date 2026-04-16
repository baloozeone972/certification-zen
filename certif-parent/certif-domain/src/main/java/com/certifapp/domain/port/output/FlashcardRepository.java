// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/FlashcardRepository.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.learning.Flashcard;
import java.util.List;
import java.util.UUID;

/** Output port: persistence and retrieval of flashcards. */
public interface FlashcardRepository {
    List<Flashcard> findDueByUserAndCertification(UUID userId, String certificationId, int limit);
    Flashcard       save(Flashcard flashcard);
    List<Flashcard> saveAll(List<Flashcard> flashcards);
}
