// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/learning/ReviewFlashcardUseCaseImpl.java
package com.certifapp.application.usecase.learning;

import com.certifapp.domain.model.learning.SM2Schedule;
import com.certifapp.domain.port.input.learning.ReviewFlashcardUseCase;
import com.certifapp.domain.port.output.SM2ScheduleRepository;
import com.certifapp.domain.service.SM2AlgorithmService;

import java.util.UUID;

/**
 * Implementation of {@link ReviewFlashcardUseCase}.
 *
 * <p>Applies the SM-2 algorithm to update the review schedule,
 * creating a new schedule entry if this is the first review.</p>
 */
public class ReviewFlashcardUseCaseImpl implements ReviewFlashcardUseCase {

    private final SM2ScheduleRepository sm2Repository;
    private final SM2AlgorithmService sm2Service;

    public ReviewFlashcardUseCaseImpl(
            SM2ScheduleRepository sm2Repository,
            SM2AlgorithmService sm2Service) {
        this.sm2Repository = sm2Repository;
        this.sm2Service = sm2Service;
    }

    @Override
    public SM2Schedule execute(ReviewFlashcardCommand command) {
        // Flashcard UUID ≠ question UUID — we schedule by flashcard
        // Treat flashcard UUID as the "questionId" in the SM2 schedule
        UUID flashcardId = command.flashcardId();
        UUID userId = command.userId();

        SM2Schedule current = sm2Repository
                .findByUserAndQuestion(userId, flashcardId)
                .orElseGet(() -> sm2Service.initialSchedule(userId, flashcardId));

        SM2Schedule updated = sm2Service.review(current, command.rating());
        return sm2Repository.save(updated);
    }
}
