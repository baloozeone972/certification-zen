package com.certifapp.ai.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class PromptRendererTest {

    @Mock
    private InputStream inputStream;

    @InjectMocks
    private PromptRenderer promptRenderer;

    @BeforeEach
    public void setUp() {
        when(inputStream.readAllBytes()).thenReturn("{{name}} is a {{occupation}}.".getBytes());
    }

    @Test
    @DisplayName("renders template with variables")
    public void render_templateWithVariables_expectedRenderedString() {
        Map<String, Object> variables = new HashMap<>();
        variables.put("name", "John");
        variables.put("occupation", "Developer");

        String result = promptRenderer.render("testTemplate", variables);

        assertThat(result).isEqualTo("John is a Developer.");
    }

    @Test
    @DisplayName("renders template with null variable")
    public void render_templateWithNullVariable_expectedRenderedString() {
        Map<String, Object> variables = new HashMap<>();
        variables.put("name", "John");
        variables.put("occupation", null);

        String result = promptRenderer.render("testTemplate", variables);

        assertThat(result).isEqualTo("John is a .");
    }

    @Test
    @DisplayName("throws exception when template not found")
    public void render_templateNotFound_expectedException() {
        when(inputStream.readAllBytes()).thenReturn(null);
        when(getClass().getResourceAsStream(anyString())).thenReturn(null);

        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            promptRenderer.render("nonExistentTemplate", new HashMap<>());
        });

        assertThat(exception.getMessage()).isEqualTo("Prompt template not found: /prompts/nonExistentTemplate.mustache");
    }

    @Test
    @DisplayName("throws runtime exception when failed to load template")
    public void render_failedToLoadTemplate_expectedRuntimeException() {
        when(inputStream.readAllBytes()).thenThrow(new IOException("IO error"));
        when(getClass().getResourceAsStream(anyString())).thenReturn(inputStream);

        Exception exception = assertThrows(RuntimeException.class, () -> {
            promptRenderer.render("testTemplate", new HashMap<>());
        });

        assertThat(exception.getMessage()).isEqualTo("Failed to load prompt template: /prompts/testTemplate.mustache");
    }
}
