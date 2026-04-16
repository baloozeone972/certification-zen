```java
package com.certifapp.ai.config;

import dev.langchain4j.model.anthropic.AnthropicChatModel;
import dev.langchain4j.model.ollama.OllamaChatModel;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;

import java.time.Duration;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class ModelRouterConfigTest {

    @Mock
    private OllamaChatModel ollamaLightModelMock;
    @Mock
    private OllamaChatModel ollamaHeavyModelMock;
    @Mock
    private OllamaStreamingChatModel ollamaStreamingModelMock;
    @Mock
    private AnthropicChatModel claudeLightModelMock;
    @Mock
    private AnthropicChatModel claudeHeavyModelMock;
    @Mock
    private AnthropicStreamingChatModel claudeStreamingModelMock;

    @InjectMocks
    private ModelRouterConfig modelRouterConfig;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("local profile - ollamaLightModel bean creation")
    public void testOllamaLightModelBeanCreation() {
        when(modelRouterConfig.ollamaLightModel(anyString(), anyString())).thenReturn(ollamaLightModelMock);

        ChatLanguageModel lightModel = modelRouterConfig.ollamaLightModel("http://localhost:11434", "llama3.1:8b-instruct-q4_K_M");

        assertThat(lightModel).isSameAs(ollamaLightModelMock);
        verify(modelRouterConfig, times(1)).ollamaLightModel(anyString(), anyString());
    }

    @Test
    @DisplayName("local profile - ollamaHeavyModel bean creation")
    public void testOllamaHeavyModelBeanCreation() {
        when(modelRouterConfig.ollamaHeavyModel(anyString(), anyString())).thenReturn(ollamaHeavyModelMock);

        ChatLanguageModel heavyModel = modelRouterConfig.ollamaHeavyModel("http://localhost:11434", "llama3.1:8b-instruct-q4_K_M");

        assertThat(heavyModel).isSameAs(ollamaHeavyModelMock);
        verify(modelRouterConfig, times(1)).ollamaHeavyModel(anyString(), anyString());
    }

    @Test
    @DisplayName("local profile - ollamaStreamingModel bean creation")
    public void testOllamaStreamingModelBeanCreation() {
        when(modelRouterConfig.ollamaStreamingModel(anyString(), anyString())).thenReturn(ollamaStreamingModelMock);

        StreamingChatLanguageModel streamingModel = modelRouterConfig.ollamaStreamingModel("http://localhost:11434", "llama3.1:8b-instruct-q4_K_M");

        assertThat(streamingModel).isSameAs(ollamaStreamingModelMock);
        verify(modelRouterConfig, times(1)).ollamaStreamingModel(anyString(), anyString());
    }

    @Test
    @DisplayName("prod profile - claudeLightModel bean creation")
    public void testClaudeLightModelBeanCreation() {
        when(modelRouterConfig.claudeLightModel(anyString(), anyString())).thenReturn(claudeLightModelMock);

        ChatLanguageModel lightModel = modelRouterConfig.claudeLightModel("apiKey", "claude-3-haiku-20240307");

        assertThat(lightModel).isSameAs(claudeLightModelMock);
        verify(modelRouterConfig, times(1)).claudeLightModel(anyString(), anyString());
    }

    @Test
    @DisplayName("prod profile - claudeHeavyModel bean creation")
    public void testClaudeHeavyModelBeanCreation() {
        when(modelRouterConfig.claudeHeavyModel(anyString(), anyString())).thenReturn(claudeHeavyModelMock);

        ChatLanguageModel heavyModel = modelRouterConfig.claudeHeavyModel("apiKey", "claude-sonnet-4-6");

        assertThat(heavyModel).isSameAs(claudeHeavyModelMock);
        verify(modelRouterConfig, times(1)).claudeHeavyModel(anyString(), anyString());
    }

    @Test
    @DisplayName("prod profile - claudeStreamingModel bean creation")
    public void testClaudeStreamingModelBeanCreation() {
        when(modelRouterConfig.claudeStreamingModel(anyString(), anyString())).thenReturn(claudeStreamingModelMock);

        StreamingChatLanguageModel streamingModel = modelRouterConfig.claudeStreamingModel("apiKey", "claude-sonnet-4-6");

        assertThat(streamingModel).isSameAs(claudeStreamingModelMock);
        verify(modelRouterConfig, times(1)).claudeStreamingModel(anyString(), anyString());
    }

    @Test
    @DisplayName("error case - missing value for baseUrl")
    public void testMissingBaseUrl() {
        when(modelRouterConfig.ollamaLightModel("", "modelName")).thenThrow(new IllegalArgumentException());

        IllegalArgumentException exception = null;
        try {
            modelRouterConfig.ollamaLightModel("", "modelName");
        } catch (IllegalArgumentException e) {
            exception = e;
        }

        assertThat(exception).isNotNull();
        verify(modelRouterConfig, times(1)).ollamaLightModel(anyString(), anyString());
    }

    @Test
    @DisplayName("error case - missing value for modelName")
    public void testMissingModelName() {
        when(modelRouterConfig.ollamaLightModel("baseUrl", "")).thenThrow(new IllegalArgumentException());

        IllegalArgumentException exception = null;
        try {
            modelRouterConfig.ollamaLightModel("baseUrl", "");
        } catch (IllegalArgumentException e) {
            exception = e;
        }

        assertThat(exception).isNotNull();
        verify(modelRouterConfig, times(1)).ollamaLightModel(anyString(), anyString());
    }
}
```
