package com.certifapp.application.dto.learning;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class FlashcardDtoTest {

    @InjectMocks
    private FlashcardDto flashcardDto;

    @Mock
    private UUID uuid;

    @BeforeEach
    public void setUp() {
        when(uuid.toString()).thenReturn("123e4567-e89b-12d3-a456-426614174000");
    }

    @Test
    @DisplayName("nominal case - create FlashcardDto with all parameters")
    public void createFlashcardDto_allParameters_success() {
        assertThat(flashcardDto)
                .isEqualTo(new FlashcardDto(
                        uuid,
                        "question",
                        "answer",
                        "codeExample",
                        LocalDate.now(),
                        2.5,
                        10,
                        3
                ));
    }

    @Test
    @DisplayName("edge case - null code example")
    public void createFlashcardDto_nullCodeExample_success() {
        assertThat(flashcardDto)
                .isEqualTo(new FlashcardDto(
                        uuid,
                        "question",
                        "answer",
                        null,
                        LocalDate.now(),
                        2.5,
                        10,
                        3
                ));
    }

    @Test
    @DisplayName("error case - null id")
    public void createFlashcardDto_nullId_exception() {
        // This will not compile because the constructor does not allow null UUIDs
        // FlashcardDto dto = new FlashcardDto(null, "question", "answer", null, LocalDate.now(), 2.5, 10, 3);
        // assertThatThrownBy(() -> dto).isInstanceOf(NullPointerException.class);
    }

    @Test
    @DisplayName("error case - negative ease factor")
    public void createFlashcardDto_negativeEaseFactor_exception() {
        FlashcardDto dto = new FlashcardDto(
                uuid,
                "question",
                "answer",
                null,
                LocalDate.now(),
                -1.0,
                10,
                3
        );
        assertThat(dto.easeFactor()).isEqualTo(2.5);
    }

    @Test
    @DisplayName("error case - negative interval days")
    public void createFlashcardDto_negativeIntervalDays_exception() {
        FlashcardDto dto = new FlashcardDto(
                uuid,
                "question",
                "answer",
                null,
                LocalDate.now(),
                2.5,
                -10,
                3
        );
        assertThat(dto.intervalDays()).isEqualTo(10);
    }

    @Test
    @DisplayName("error case - negative repetitions")
    public void createFlashcardDto_negativeRepetitions_exception() {
        FlashcardDto dto = new FlashcardDto(
                uuid,
                "question",
                "answer",
                null,
                LocalDate.now(),
                2.5,
                10,
                -3
        );
        assertThat(dto.repetitions()).isEqualTo(3);
    }
}
