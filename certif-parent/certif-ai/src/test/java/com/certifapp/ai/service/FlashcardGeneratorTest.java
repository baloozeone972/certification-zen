package com.certifapp.ai.service;

import com.certifapp.domain.model.learning.Flashcard;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.eq;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class FlashcardGeneratorTest {

    @Mock
    private ChatLanguageModel lightModel;

    @Mock
    private PromptRenderer promptRenderer;

    @Mock
    private ObjectMapper objectMapper;

    @InjectMocks
    private FlashcardGenerator flashcardGenerator;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("should generate flashcards from course content")
    public void generateFromCourse_nominalCase() throws Exception {
        // Arrange
        UUID courseId = UUID.randomUUID();
        String certificationId = "cert123";
        String themeLabel = "Java Fundamentals";
        String content = "Some Markdown content...";
        int count = 5;
        List<Flashcard> expectedFlashcards = new ArrayList<>();

        when(lightModel.generate(anyString())).thenReturn("{\"front\":\"Front\", \"back\":\"Back\"}");
        when(objectMapper.readValue(anyString(), eq(new TypeReference<List<Map<String, String>>>() {
        }))).thenReturn(List.of());

        // Act
        List<Flashcard> actualFlashcards = flashcardGenerator.generateFromCourse(courseId, certificationId, themeLabel, content, count);

        // Assert
        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
    }

    @Test
    @DisplayName("should handle empty content")
    public void generateFromCourse_edgeCaseEmptyContent() throws Exception {
        // Arrange
        UUID courseId = UUID.randomUUID();
        String certificationId = "cert123";
        String themeLabel = "Java Fundamentals";
        String content = "";
        int count = 5;
        List<Flashcard> expectedFlashcards = new ArrayList<>();

        when(lightModel.generate(anyString())).thenReturn("{\"front\":\"Front\", \"back\":\"Back\"}");
        when(objectMapper.readValue(anyString(), eq(new TypeReference<List<Map<String, String>>>() {
        }))).thenReturn(List.of());

        // Act
        List<Flashcard> actualFlashcards = flashcardGenerator.generateFromCourse(courseId, certificationId, themeLabel, content, count);

        // Assert
        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
    }

    @Test
    @DisplayName("should handle large content")
    public void generateFromCourse_edgeCaseLargeContent() throws Exception {
        // Arrange
        UUID courseId = UUID.randomUUID();
        String certificationId = "cert123";
        String themeLabel = "Java Fundamentals";
        String content = "a".repeat(4000);
        int count = 5;
        List<Flashcard> expectedFlashcards = new ArrayList<>();

        when(lightModel.generate(anyString())).thenReturn("{\"front\":\"Front\", \"back\":\"Back\"}");
        when(objectMapper.readValue(anyString(), eq(new TypeReference<List<Map<String, String>>>() {
        }))).thenReturn(List.of());

        // Act
        List<Flashcard> actualFlashcards = flashcardGenerator.generateFromCourse(courseId, certificationId, themeLabel, content, count);

        // Assert
        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
    }

    @Test
    @DisplayName("should handle error in response parsing")
    public void generateFromCourse_errorCaseParsingError() throws Exception {
        // Arrange
        UUID courseId = UUID.randomUUID();
        String certificationId = "cert123";
        String themeLabel = "Java Fundamentals";
        String content = "Some Markdown content...";
        int count = 5;
        List<Flashcard> expectedFlashcards = new ArrayList<>();

        when(lightModel.generate(anyString())).thenReturn("{\"front\":\"Front\", \"back\":\"Back\"}");
        when(objectMapper.readValue(anyString(), eq(new TypeReference<List<Map<String, String>>>() {
        }))).thenThrow(new Exception("Parsing error"));

        // Act
        List<Flashcard> actualFlashcards = flashcardGenerator.generateFromCourse(courseId, certificationId, themeLabel, content, count);

        // Assert
        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
    }
}

