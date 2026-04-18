package com.certifapp.ai.service;

import dev.langchain4j.model.chat.ChatLanguageModel;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.anyMap;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class InterviewSimulatorTest {

    @Mock
    private ChatLanguageModel heavyModel;

    @Mock
    private PromptRenderer promptRenderer;

    @InjectMocks
    private InterviewSimulator interviewSimulator;

    @BeforeEach
    public void setUp() {
        when(heavyModel.generate(anyString())).thenReturn("Generated question");
        when(promptRenderer.render(anyString(), anyMap())).thenReturn("Rendered prompt");
    }

    @Test
    @DisplayName("should generate a technical interview question for nominal case")
    public void generateQuestion_nominalCase_success() {
        String result = interviewSimulator.generateQuestion("cert123", "Java", "Developer", "medium");
        assertThat(result).isEqualTo("Generated question");
    }

    @Test
    @DisplayName("should return default question text on heavy model exception")
    public void generateQuestion_exception_defaultText() {
        when(heavyModel.generate(anyString())).thenThrow(new RuntimeException("Exception"));
        String result = interviewSimulator.generateQuestion("cert123", "Java", "Developer", "medium");
        assertThat(result).isEqualTo("Expliquez les avantages des Virtual Threads en Java 21.");
    }

    @Test
    @DisplayName("should evaluate a candidate's interview answer for nominal case")
    public void evaluateAnswer_nominalCase_success() throws Exception {
        String json = "{\"score\":9,\"feedback\":\"Excellent réponse!\",\"keyPointsMissed\":[],\"strongPoints\":[\"Good understanding of the concept\"]}";
        when(heavyModel.generate(anyString())).thenReturn("json\n" + json + "\n");
        Map<String, Object> result = interviewSimulator.evaluateAnswer("cert123", "Question", "Answer", "Java");
        assertThat(result).isEqualTo(Map.of(
                "score", 9,
                "feedback", "Excellent réponse!",
                "keyPointsMissed", List.of(),
                "strongPoints", List.of("Good understanding of the concept")
        ));
    }

    @Test
    @DisplayName("should return default feedback on heavy model exception")
    public void evaluateAnswer_exception_defaultFeedback() {
        when(heavyModel.generate(anyString())).thenThrow(new RuntimeException("Exception"));
        Map<String, Object> result = interviewSimulator.evaluateAnswer("cert123", "Question", "Answer", "Java");
        assertThat(result).isEqualTo(Map.of(
                "score", 5,
                "feedback", "Évaluation non disponible. Continuez à pratiquer !",
                "keyPointsMissed", List.of(),
                "strongPoints", List.of()
        ));
    }

    @Test
    @DisplayName("should handle null roleType gracefully")
    public void generateQuestion_nullRoleType_success() {
        String result = interviewSimulator.generateQuestion("cert123", "Java", null, "medium");
        assertThat(result).isEqualTo("Generated question");
    }
}

