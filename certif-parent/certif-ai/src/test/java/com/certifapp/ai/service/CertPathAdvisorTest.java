```java
package com.certifapp.ai.service;

import com.fasterxml.jackson.core.type.TypeReference;
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

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CertPathAdvisorTest {

    @Mock
    private ChatLanguageModel lightModel;

    @Mock
    private PromptRenderer promptRenderer;

    @InjectMocks
    private CertPathAdvisor certPathAdvisor;

    @BeforeEach
    public void setUp() {
        when(lightModel.generate(anyString())).thenReturn("```json\n" +
                "{\"steps\":[\"Cert1\",\"Cert2\"], \"aiRationale\":\"Reasons here\"}\n" +
                "```");
        when(promptRenderer.render(anyString(), anyMap())).thenReturn("{\"renderedPrompt\":\"prompt\"}");
    }

    @Test
    @DisplayName("should generate a personalized certification path with nominal data")
    public void recommendPath_nominalCase() throws Exception {
        Map<String, Double> skillMap = new HashMap<>();
        skillMap.put("Java", 0.8);
        skillMap.put("Spring", 0.5);

        List<Map<String, String>> certifications = List.of(
                Map.of("id", "Cert1", "name", "Cert1", "examType", "Exam1", "passingScore", "80"),
                Map.of("id", "Cert2", "name", "Cert2", "examType", "Exam2", "passingScore", "75")
        );

        Map<String, Object> result = certPathAdvisor.recommendPath("Software Engineer", "Improve technical skills", skillMap, certifications);

        assertThat(result.get("steps")).isEqualTo(List.of("Cert1", "Cert2"));
        assertThat(result.get("aiRationale")).isEqualTo("Reasons here");
    }

    @Test
    @DisplayName("should handle null roleType and projectGoal")
    public void recommendPath_nullRoleAndProject() throws Exception {
        Map<String, Double> skillMap = new HashMap<>();
        skillMap.put("Java", 0.8);
        skillMap.put("Spring", 0.5);

        List<Map<String, String>> certifications = List.of(
                Map.of("id", "Cert1", "name", "Cert1", "examType", "Exam1", "passingScore", "80"),
                Map.of("id", "Cert2", "name", "Cert2", "examType", "Exam2", "passingScore", "75")
        );

        Map<String, Object> result = certPathAdvisor.recommendPath(null, null, skillMap, certifications);

        assertThat(result.get("steps")).isEqualTo(List.of("Cert1", "Cert2"));
        assertThat(result.get("aiRationale")).isEqualTo("Reasons here");
    }

    @Test
    @DisplayName("should handle empty skillMap")
    public void recommendPath_emptySkillMap() throws Exception {
        Map<String, Double> skillMap = new HashMap<>();

        List<Map<String, String>> certifications = List.of(
                Map.of("id", "Cert1", "name", "Cert1", "examType", "Exam1", "passingScore", "80"),
                Map.of("id", "Cert2", "name", "Cert2", "examType", "Exam2", "passingScore", "75")
        );

        Map<String, Object> result = certPathAdvisor.recommendPath("Software Engineer", "Improve technical skills", skillMap, certifications);

        assertThat(result.get("steps")).isEqualTo(List.of("Cert1", "Cert2"));
        assertThat(result.get("aiRationale")).isEqualTo("Reasons here");
    }

    @Test
    @DisplayName("should handle empty certifications list")
    public void recommendPath_emptyCertifications() throws Exception {
        Map<String, Double> skillMap = new HashMap<>();
        skillMap.put("Java", 0.8);
        skillMap.put("Spring", 0.5);

        List<Map<String, String>> certifications = Collections.emptyList();

        Map<String, Object> result = certPathAdvisor.recommendPath("Software Engineer", "Improve technical skills", skillMap, certifications);

        assertThat(result.get("steps")).isEqualTo(List.of());
        assertThat(result.get("aiRationale")).isEqualTo("");
    }

    @Test
    @DisplayName("should handle exception from lightModel.generate")
    public void recommendPath_exceptionCase() throws Exception {
        when(lightModel.generate(anyString())).thenThrow(new RuntimeException("Mocked error"));

        Map<String, Double> skillMap = new HashMap<>();
        skillMap.put("Java", 0.8);
        skillMap.put("Spring", 0.5);

        List<Map<String, String>> certifications = List.of(
                Map.of("id", "Cert1", "name", "Cert1", "examType", "Exam1", "passingScore", "80"),
                Map.of("id", "Cert2", "name", "Cert2", "examType", "Exam2", "passingScore", "75")
        );

        Map<String, Object> result = certPathAdvisor.recommendPath("Software Engineer", "Improve technical skills", skillMap, certifications);

        assertThat(result.get("steps")).isEqualTo(List.of());
        assertThat(result.get("aiRationale")).isEqualTo("");
    }

    @Test
    @DisplayName("should log error and return empty path on exception")
    public void recommendPath_logError() throws Exception {
        when(lightModel.generate(anyString())).thenThrow(new RuntimeException("Mocked error"));

        Map<String, Double> skillMap = new HashMap<>();
        skillMap.put("Java", 0.8);
        skillMap.put("Spring", 0.5);

        List<Map<String, String>> certifications = List.of(
                Map.of("id", "Cert1", "name", "Cert1", "examType", "Exam1", "passingScore", "80"),
                Map.of("id", "Cert2", "name", "Cert2", "examType", "Exam2", "passingScore", "75")
        );

        certPathAdvisor.recommendPath("Software Engineer", "Improve technical skills", skillMap, certifications);

        verify(lightModel).generate(anyString());
    }
}
```
