package com.certifapp.domain.model.session;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.time.OffsetDateTime;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class UserAnswerTest {

    @InjectMocks
    private UserAnswer userAnswer;

    @Mock
    private UUID uuid;

    @BeforeEach
    public void setUp() {
        when(uuid.randomUUID()).thenReturn(UUID.randomUUID());
    }

    @Test
    @DisplayName("should create a skipped question with no timestamps")
    public void skipped_question_skipped_with_no_timestamps() {
        UserAnswer result = UserAnswer.skipped(UUID.randomUUID(), UUID.randomUUID());

        assertThat(result).isEqualTo(new UserAnswer(
            null, 
            UUID.randomUUID(), 
            UUID.randomUUID(), 
            null, 
            false, 
            true, 
            null, 
            null
        ));
    }

    @Test
    @DisplayName("should create an answered question with current timestamp")
    public void answered_question_answered_with_current_timestamp() {
        UserAnswer result = UserAnswer.answered(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(), 100L);

        assertThat(result).isEqualTo(new UserAnswer(
            null, 
            UUID.randomUUID(), 
            UUID.randomUUID(), 
            UUID.randomUUID(), 
            false, 
            false, 
            100L, 
            OffsetDateTime.now()
        ));
    }

    @Test
    @DisplayName("should auto-correct isSkipped when selectedOptionId is null")
    public void compact_constructor_auto_correct_isSkipped() {
        UserAnswer result = new UserAnswer(
            UUID.randomUUID(), 
            UUID.randomUUID(), 
            UUID.randomUUID(), 
            null, 
            false, 
            false, 
            100L, 
            OffsetDateTime.now()
        );

        assertThat(result).isEqualTo(new UserAnswer(
            UUID.randomUUID(), 
            UUID.randomUUID(), 
            UUID.randomUUID(), 
            null, 
            true, 
            true, 
            100L, 
            OffsetDateTime.now()
        ));
    }

    @Test
    @DisplayName("should throw IllegalArgumentException when isSkipped is true and selectedOptionId is not null")
    public void compact_constructor_throw_exception_when_isSkipped_and_selectedOptionId_not_null() {
        UUID sessionId = UUID.randomUUID();
        UUID questionId = UUID.randomUUID();

        assertThrows(IllegalArgumentException.class, () -> 
            new UserAnswer(
                UUID.randomUUID(), 
                sessionId, 
                questionId, 
                UUID.randomUUID(), 
                false, 
                true, 
                100L, 
                OffsetDateTime.now()
            )
        );
    }

    @Test
    @DisplayName("should throw IllegalArgumentException when responseTimeMs is negative")
    public void compact_constructor_throw_exception_when_responseTimeMs_negative() {
        assertThrows(IllegalArgumentException.class, () -> 
            new UserAnswer(
                UUID.randomUUID(), 
                UUID.randomUUID(), 
                UUID.randomUUID(), 
                null, 
                false, 
                false, 
                -1L, 
                OffsetDateTime.now()
            )
        );
    }
}
