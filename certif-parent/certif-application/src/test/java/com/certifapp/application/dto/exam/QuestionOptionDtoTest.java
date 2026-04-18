package com.certifapp.application.dto.exam;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verifyNoInteractions;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class QuestionOptionDtoTest {

    @Mock
    private SomeDependency someDependency; // Replace with actual dependency if any

    @InjectMocks
    private QuestionOptionDto questionOptionDto;

    @BeforeEach
    public void setUp() {
        // Initialization code if needed
    }

    @AfterEach
    public void tearDown() {
        verifyNoInteractions(someDependency);
    }

    @Test
    @DisplayName("Constructor with valid parameters should initialize the object correctly")
    public void constructor_validParameters_shouldInitializeObjectCorrectly() {
        UUID id = UUID.randomUUID();
        char label = 'A';
        String text = "Option A";

        QuestionOptionDto dto = new QuestionOptionDto(id, label, text);

        assertThat(dto.id()).isEqualTo(id);
        assertThat(dto.label()).isEqualTo(label);
        assertThat(dto.text()).isEqualTo(text);
    }

    @Test
    @DisplayName("Constructor with null UUID should throw NullPointerException")
    public void constructor_nullUUID_shouldThrowNullPointerException() {
        char label = 'A';
        String text = "Option A";

        assertThatExceptionOfType(NullPointerException.class)
            .isThrownBy(() -> new QuestionOptionDto(null, label, text));
    }

    @Test
    @DisplayName("Constructor with empty text should throw IllegalArgumentException")
    public void constructor_emptyText_shouldThrowIllegalArgumentException() {
        UUID id = UUID.randomUUID();
        char label = 'A';
        String text = "";

        assertThatExceptionOfType(IllegalArgumentException.class)
            .isThrownBy(() -> new QuestionOptionDto(id, label, text));
    }

    @Test
    @DisplayName("Constructor with null label should throw NullPointerException")
    public void constructor_nullLabel_shouldThrowNullPointerException() {
        UUID id = UUID.randomUUID();
        String label = null;
        String text = "Option A";

        assertThatExceptionOfType(NullPointerException.class)
            .isThrownBy(() -> new QuestionOptionDto(id, label.charAt(0), text));
    }
}
