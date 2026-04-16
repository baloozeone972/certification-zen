```java
package com.certifapp.application.usecase.learning;

import com.certifapp.domain.exception.SubscriptionRequiredException;
import com.certifapp.domain.model.learning.Flashcard;
import com.certifapp.domain.model.user.SubscriptionTier;
import com.certifapp.domain.port.input.learning.GetFlashcardsUseCase;
import com.certifapp.domain.port.output.FlashcardRepository;
import com.certifapp.domain.port.output.UserRepository;
import com.certifapp.domain.service.FreemiumGuardService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class GetFlashcardsUseCaseImplTest {

    @Mock
    private FlashcardRepository flashcardRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private FreemiumGuardService freemiumGuardService;

    @InjectMocks
    private GetFlashcardsUseCaseImpl getFlashcardsUseCase;

    private UUID userId;
    private String certificationId;
    private int limit;

    @BeforeEach
    public void setUp() {
        userId = UUID.randomUUID();
        certificationId = "cert123";
        limit = 10;
    }

    @Test
    @DisplayName("should return flashcards when user has PRO tier")
    public void execute_PRO_user_success() {
        when(userRepository.findById(userId)).thenReturn(Optional.of(mockUser(SubscriptionTier.PRO)));
        List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard());
        when(flashcardRepository.findDueByUserAndCertification(any(), any(), anyInt())).thenReturn(expectedFlashcards);

        List<Flashcard> result = getFlashcardsUseCase.execute(userId, certificationId, limit);

        assertThat(result).isEqualTo(expectedFlashcards);
        verify(userRepository).findById(userId);
        verify(freemiumGuardService).requireUnlimited(SubscriptionTier.PRO, "Flashcards & Spaced Repetition");
        verify(flashcardRepository).findDueByUserAndCertification(userId, certificationId, 10);
    }

    @Test
    @DisplayName("should throw SubscriptionRequiredException when user has FREE tier")
    public void execute_FREE_user_failure() {
        when(userRepository.findById(userId)).thenReturn(Optional.of(mockUser(SubscriptionTier.FREE)));

        assertThatThrownBy(() -> getFlashcardsUseCase.execute(userId, certificationId, limit))
                .isInstanceOf(SubscriptionRequiredException.class)
                .withFailMessage("Subscription is required for this feature");

        verify(userRepository).findById(userId);
        verify(freemiumGuardService).requireUnlimited(SubscriptionTier.FREE, "Flashcards & Spaced Repetition");
    }

    @Test
    @DisplayName("should use default limit when provided limit is less than or equal to 0")
    public void execute_limit_0_success() {
        int defaultLimit = 20;
        List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard());
        when(flashcardRepository.findDueByUserAndCertification(any(), any(), eq(defaultLimit))).thenReturn(expectedFlashcards);

        List<Flashcard> result = getFlashcardsUseCase.execute(userId, certificationId, 0);

        assertThat(result).isEqualTo(expectedFlashcards);
        verify(userRepository).findById(userId);
        verify(freemiumGuardService).requireUnlimited(SubscriptionTier.FREE, "Flashcards & Spaced Repetition");
        verify(flashcardRepository).findDueByUserAndCertification(userId, certificationId, defaultLimit);
    }

    @Test
    @DisplayName("should use maximum limit when provided limit exceeds maximum allowed")
    public void execute_limit_greater_than_max_success() {
        int maxLimit = 50;
        List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard());
        when(flashcardRepository.findDueByUserAndCertification(any(), any(), eq(maxLimit))).thenReturn(expectedFlashcards);

        List<Flashcard> result = getFlashcardsUseCase.execute(userId, certificationId, 100);

        assertThat(result).isEqualTo(expectedFlashcards);
        verify(userRepository).findById(userId);
        verify(freemiumGuardService).requireUnlimited(SubscriptionTier.FREE, "Flashcards & Spaced Repetition");
        verify(flashcardRepository).findDueByUserAndCertification(userId, certificationId, maxLimit);
    }

    private User mockUser(SubscriptionTier tier) {
        User user = new User();
        user.setSubscriptionTier(tier);
        return user;
    }
}
```
