package com.certifapp.ai.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.certifapp.ai.service.DiagnosticAnalyzer.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class DiagnosticAnalyzerTest {

    @Mock
    private ChatLanguageModel lightModel;

    @Mock
    private PromptRenderer promptRenderer;

    @InjectMocks
    private DiagnosticAnalyzer diagnosticAnalyzer;

    @BeforeEach
    public void setUp() {
        when(lightModel.generate(anyString())).thenReturn("{\"skillMap\":{\"Java\":80},\"recommendations\":[{\"id\":\"cert1\",\"name\":\"Cert 1\"}]}");
    }

    @Test
    @DisplayName("analyze_nominal_case")
    public void analyze_nominal_case() {
        Map<String, Integer> scoreByDomain = new HashMap<>();
        scoreByDomain.put("Java", 80);
        List<Map<String, String>> certifications = List.of(Map.of("id", "cert1", "name", "Cert 1"));
        String roleType = "Software Engineer";

        Map<String, Object> result = diagnosticAnalyzer.analyze(scoreByDomain, certifications, roleType);

        assertThat(result).containsKeys("skillMap", "recommendations");
        assertThat((Map<String, Integer>) result.get("skillMap")).containsEntry("Java", 80);
        assertThat((List<Map<String, String>>) result.get("recommendations")).hasSize(1);
    }

    @Test
    @DisplayName("analyze_edge_case_empty_score_by_domain")
    public void analyze_edge_case_empty_score_by_domain() {
        Map<String, Integer> scoreByDomain = new HashMap<>();
        List<Map<String, String>> certifications = List.of(Map.of("id", "cert1", "name", "Cert 1"));
        String roleType = "Software Engineer";

        Map<String, Object> result = diagnosticAnalyzer.analyze(scoreByDomain, certifications, roleType);

        assertThat(result).containsKeys("skillMap", "recommendations");
        assertThat((Map<String, Integer>) result.get("skillMap")).isEmpty();
        assertThat((List<Map<String, String>>) result.get("recommendations")).hasSize(1);
    }

    @Test
    @DisplayName("analyze_edge_case_empty_certifications")
    public void analyze_edge_case_empty_certifications() {
        Map<String, Integer> scoreByDomain = new HashMap<>();
        List<Map<String, String>> certifications = Collections.emptyList();
        String roleType = "Software Engineer";

        Map<String, Object> result = diagnosticAnalyzer.analyze(scoreByDomain, certifications, roleType);

        assertThat(result).containsKeys("skillMap", "recommendations");
        assertThat((Map<String, Integer>) result.get("skillMap")).isEmpty();
        assertThat((List<Map<String, String>>) result.get("recommendations")).isEmpty();
    }

    @Test
    @DisplayName("analyze_error_case_exception_in_generate")
    public void analyze_error_case_exception_in_generate() {
        when(lightModel.generate(anyString())).thenThrow(new RuntimeException("Failed to generate response"));

        Map<String, Integer> scoreByDomain = new HashMap<>();
        List<Map<String, String>> certifications = List.of(Map.of("id", "cert1", "name", "Cert 1"));
        String roleType = "Software Engineer";

        Map<String, Object> result = diagnosticAnalyzer.analyze(scoreByDomain, certifications, roleType);

        assertThat(result).containsKeys("skillMap", "recommendations");
        assertThat((Map<String, Integer>) result.get("skillMap")).isEmpty();
        assertThat((List<Map<String, String>>) result.get("recommendations")).isEmpty();
    }
}
