```java
package com.certifapp.ai.service;

import dev.langchain4j.model.chat.ChatLanguageModel;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CourseGeneratorTest {

    @Mock
    private ChatLanguageModel lightModel;

    @Mock
    private PromptRenderer promptRenderer;

    @InjectMocks
    private CourseGenerator courseGenerator;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @Test
    @DisplayName("generateCourse_nominalCase_success")
    public void testGenerateCourse_NominalCase_Success() throws Exception {
        String certificationId = "ocp21";
        String themeLabel = "Virtual Threads";
        List<String> sampleQuestions = List.of("Question 1", "Question 2");

        when(promptRenderer.render(anyString(), anyMap())).thenReturn("Prompt Rendered");
        when(lightModel.generate(anyString())).thenReturn("Course Content");

        String result = courseGenerator.generateCourse(certificationId, themeLabel, sampleQuestions);

        assertThat(result).isEqualTo("Course Content");
        verify(lightModel, times(1)).generate("Prompt Rendered");
    }

    @Test
    @DisplayName("generateCourse_emptySampleQuestions_success")
    public void testGenerateCourse_EmptySampleQuestions_Success() throws Exception {
        String certificationId = "ocp21";
        String themeLabel = "Virtual Threads";
        List<String> sampleQuestions = List.of();

        when(promptRenderer.render(anyString(), anyMap())).thenReturn("Prompt Rendered");
        when(lightModel.generate(anyString())).thenReturn("Course Content");

        String result = courseGenerator.generateCourse(certificationId, themeLabel, sampleQuestions);

        assertThat(result).isEqualTo("Course Content");
        verify(lightModel, times(1)).generate("Prompt Rendered");
    }

    @Test
    @DisplayName("generateCourse_nullSampleQuestions_success")
    public void testGenerateCourse_NullSampleQuestions_Success() throws Exception {
        String certificationId = "ocp21";
        String themeLabel = "Virtual Threads";
        List<String> sampleQuestions = null;

        when(promptRenderer.render(anyString(), anyMap())).thenReturn("Prompt Rendered");
        when(lightModel.generate(anyString())).thenReturn("Course Content");

        String result = courseGenerator.generateCourse(certificationId, themeLabel, sampleQuestions);

        assertThat(result).isEqualTo("Course Content");
        verify(lightModel, times(1)).generate("Prompt Rendered");
    }

    @Test
    @DisplayName("generateCourse_exceptionThrown_failure")
    public void testGenerateCourse_ExceptionThrown_Failure() throws Exception {
        String certificationId = "ocp21";
        String themeLabel = "Virtual Threads";
        List<String> sampleQuestions = List.of("Question 1", "Question 2");

        when(promptRenderer.render(anyString(), anyMap())).thenReturn("Prompt Rendered");
        doThrow(new RuntimeException("Test Exception")).when(lightModel).generate(anyString());

        String result = courseGenerator.generateCourse(certificationId, themeLabel, sampleQuestions);

        assertThat(result).isEqualTo("# Virtual Threads

Contenu en cours de génération...");
        verify(lightModel, times(1)).generate("Prompt Rendered");
    }
}
```
