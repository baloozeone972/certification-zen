// certif-parent/certif-ai/src/test/java/com/certifapp/ai/service/ExplanationEnricherTest.java
package com.certifapp.ai.service;

import com.certifapp.domain.model.question.*;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

/**
 * Unit tests for {@link ExplanationEnricher}.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("ExplanationEnricher")
class ExplanationEnricherTest {

    @Mock private ChatLanguageModel lightModel;
    @Mock private PromptRenderer    promptRenderer;

    private ExplanationEnricher enricher;

    @BeforeEach
    void setUp() {
        enricher = new ExplanationEnricher(lightModel, promptRenderer);
    }

    @Test
    @DisplayName("Returns enriched explanation from model response")
    void enrich_shouldReturnEnrichedExplanation() {
        // Arrange
        Question q = buildQuestion("OCP21-VT-001", "What is Thread.ofVirtual()?",
                "Creates a virtual thread.");
        when(promptRenderer.render(anyString(), anyMap()))
                .thenReturn("Generated prompt text");
        when(lightModel.generate(anyString()))
                .thenReturn("  Enriched: Thread.ofVirtual() creates a virtual thread " +
                        "without blocking a platform thread.  ");

        // Act
        String result = enricher.enrich(q);

        // Assert
        assertThat(result).doesNotStartWith(" ");
        assertThat(result).contains("Thread.ofVirtual()");
        verify(lightModel).generate(anyString());
    }

    @Test
    @DisplayName("Falls back to original explanation on AI error")
    void enrich_onError_shouldFallBackToOriginal() {
        Question q = buildQuestion("OCP21-VT-002", "Question text", "Original explanation");
        when(promptRenderer.render(anyString(), anyMap())).thenReturn("prompt");
        when(lightModel.generate(anyString())).thenThrow(new RuntimeException("API error"));

        String result = enricher.enrich(q);

        assertThat(result).isEqualTo("Original explanation");
    }

    @Test
    @DisplayName("Handles null original explanation gracefully")
    void enrich_nullOriginalExplanation_shouldNotThrow() {
        Question q = buildQuestion("OCP21-VT-003", "Question text", null);
        when(promptRenderer.render(anyString(), anyMap())).thenReturn("prompt");
        when(lightModel.generate(anyString())).thenReturn("Generated explanation");

        assertThatCode(() -> enricher.enrich(q)).doesNotThrowAnyException();
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private static Question buildQuestion(String legacyId, String statement, String explanation) {
        UUID qId = UUID.randomUUID();
        return new Question(qId, legacyId, "ocp21", UUID.randomUUID(),
                statement, DifficultyLevel.MEDIUM, QuestionType.SINGLE_CHOICE,
                List.of(new QuestionOption(UUID.randomUUID(), qId, 'A', "Option A", true, 0)),
                explanation, null, ExplanationStatus.ORIGINAL,
                null, null, null, true, null);
    }

    private static java.util.Map<String, Object> anyMap() {
        return ArgumentMatchers.anyMap();
    }
}
