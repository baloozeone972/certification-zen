// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/learning/ReviewFlashcardUseCase.java
package com.certifapp.domain.port.input.learning;

import com.certifapp.domain.model.learning.SM2Schedule;
import java.util.UUID;

/**
 * Use case: record the result of a flashcard review and update the SM-2 schedule.
 */
public interface ReviewFlashcardUseCase {

    /**
     * SM-2 review command.
     *
     * @param userId      the reviewing user
     * @param flashcardId the reviewed flashcard
     * @param rating      SM-2 quality rating 0-5:
     *                    0=blackout, 1=wrong, 2=wrong+hint,
     *                    3=correct+hard, 4=correct, 5=perfect
     */
    record ReviewFlashcardCommand(UUID userId, UUID flashcardId, int rating) {
        public ReviewFlashcardCommand {
            if (rating < 0 || rating > 5)
                throw new IllegalArgumentException("SM-2 rating must be 0-5, got: " + rating);
        }
    }

    /**
     * @param command review data
     * @return the updated {@link SM2Schedule} with new due date
     */
    SM2Schedule execute(ReviewFlashcardCommand command);
}
