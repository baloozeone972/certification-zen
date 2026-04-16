// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/learning/GetFlashcardsUseCaseImpl.java
package com.certifapp.application.usecase.learning;

import com.certifapp.domain.exception.SubscriptionRequiredException;
import com.certifapp.domain.model.learning.Flashcard;
import com.certifapp.domain.model.user.SubscriptionTier;
import com.certifapp.domain.port.input.learning.GetFlashcardsUseCase;
import com.certifapp.domain.port.output.FlashcardRepository;
import com.certifapp.domain.port.output.UserRepository;
import com.certifapp.domain.service.FreemiumGuardService;

import java.util.List;
import java.util.UUID;

/**
 * Implementation of {@link GetFlashcardsUseCase}.
 *
 * <p>Flashcards are a PRO-only feature. FREE users receive a
 * {@link SubscriptionRequiredException} with the feature name.</p>
 */
public class GetFlashcardsUseCaseImpl implements GetFlashcardsUseCase {

    private final FlashcardRepository  flashcardRepository;
    private final UserRepository       userRepository;
    private final FreemiumGuardService freemiumGuardService;

    public GetFlashcardsUseCaseImpl(
            FlashcardRepository  flashcardRepository,
            UserRepository       userRepository,
            FreemiumGuardService freemiumGuardService) {
        this.flashcardRepository  = flashcardRepository;
        this.userRepository       = userRepository;
        this.freemiumGuardService = freemiumGuardService;
    }

    @Override
    public List<Flashcard> execute(UUID userId, String certificationId, int limit) {
        SubscriptionTier tier = userRepository.findById(userId)
                .map(u -> u.subscriptionTier())
                .orElse(SubscriptionTier.FREE);

        freemiumGuardService.requireUnlimited(tier, "Flashcards & Spaced Repetition");

        int effectiveLimit = limit <= 0 ? 20 : Math.min(limit, 50);
        return flashcardRepository.findDueByUserAndCertification(userId, certificationId, effectiveLimit);
    }
}
