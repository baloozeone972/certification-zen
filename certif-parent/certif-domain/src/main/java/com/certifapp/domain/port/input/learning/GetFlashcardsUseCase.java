// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/learning/GetFlashcardsUseCase.java
package com.certifapp.domain.port.input.learning;

import com.certifapp.domain.model.learning.Flashcard;

import java.util.List;
import java.util.UUID;

/**
 * Use case: retrieve flashcards due for SM-2 review for a given user and certification.
 */
public interface GetFlashcardsUseCase {
    /**
     * @param userId          the reviewing user
     * @param certificationId target certification
     * @param limit           maximum number of cards to return (0 = no limit)
     * @return list of flashcards due today, sorted by overdue-first
     * @throws com.certifapp.domain.exception.SubscriptionRequiredException for FREE users
     */
    List<Flashcard> execute(UUID userId, String certificationId, int limit);
}
