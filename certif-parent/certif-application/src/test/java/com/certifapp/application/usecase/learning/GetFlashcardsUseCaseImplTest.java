// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/learning/GetFlashcardsUseCaseImplTest.java
package com.certifapp.application.usecase.learning;

import com.certifapp.domain.exception.SubscriptionRequiredException;
import com.certifapp.domain.model.learning.Flashcard;
import com.certifapp.domain.model.user.*;
import com.certifapp.domain.port.input.learning.GetFlashcardsUseCase.GetFlashcardsCommand;
import com.certifapp.domain.port.output.FlashcardRepository;
import com.certifapp.domain.port.output.UserRepository;
import com.certifapp.domain.service.FreemiumGuardService;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.*;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("GetFlashcardsUseCaseImpl")
class GetFlashcardsUseCaseImplTest {

    @Mock FlashcardRepository  flashcardRepository;
    @Mock UserRepository       userRepository;
    @Mock FreemiumGuardService freemiumGuardService;
    @InjectMocks GetFlashcardsUseCaseImpl useCase;

    private static final UUID USER_ID = UUID.randomUUID();

    private User buildUser(SubscriptionTier tier) {
        return new User(USER_ID, "u@test.com", "$2a$12$h", UserRole.USER,
                tier, "fr", "Europe/Paris", null, true,
                OffsetDateTime.now(), OffsetDateTime.now());
    }

    @Test @DisplayName("PRO user — returns flashcards due")
    void proUser_returnsFlashcards() {
        when(userRepository.findById(USER_ID)).thenReturn(Optional.of(buildUser(SubscriptionTier.PRO)));
        when(flashcardRepository.findDueByUserAndCertification(any(), any(), anyInt()))
            .thenReturn(List.of());
        var cmd = new GetFlashcardsCommand(USER_ID, "ocp21", 10);
        assertThat(useCase.execute(cmd)).isEmpty();
    }

    @Test @DisplayName("FREE user — SubscriptionRequiredException thrown")
    void freeUser_throwsException() {
        when(userRepository.findById(USER_ID)).thenReturn(Optional.of(buildUser(SubscriptionTier.FREE)));
        doThrow(new SubscriptionRequiredException("flashcards"))
            .when(freemiumGuardService).requirePro(eq(SubscriptionTier.FREE), any());
        var cmd = new GetFlashcardsCommand(USER_ID, "ocp21", 10);
        assertThatThrownBy(() -> useCase.execute(cmd))
            .isInstanceOf(SubscriptionRequiredException.class);
    }
}
