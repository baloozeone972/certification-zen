package com.certifapp.ai.config;

import dev.langchain4j.model.embedding.EmbeddingModel;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Value;

import java.time.Duration;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class EmbeddingConfigTest {

    @Mock
    private OllamaEmbeddingModel.Builder ollamaEmbeddingModelBuilder;

    @InjectMocks
    private EmbeddingConfig embeddingConfig;

    @Value("${certifapp.ai.ollama.base-url:http://localhost:11434}")
    private String baseUrl;

    @Value("${certifapp.ai.ollama.embedding-model:nomic-embed-text}")
    private String modelName;

    @BeforeEach
    public void setUp() {
        when(ollamaEmbeddingModelBuilder.baseUrl(baseUrl)).thenReturn(ollamaEmbeddingModelBuilder);
        when(ollamaEmbeddingModelBuilder.modelName(modelName)).thenReturn(ollamaEmbeddingModelBuilder);
        when(ollamaEmbeddingModelBuilder.timeout(Duration.ofSeconds(60))).thenReturn(ollamaEmbeddingModelBuilder);
    }

    @Test
    @DisplayName("nominal case: should return OllamaEmbeddingModel for local profile")
    public void ollamaEmbeddingModel_localProfile_returnOllamaEmbeddingModel() {
        EmbeddingModel result = embeddingConfig.ollamaEmbeddingModel(baseUrl, modelName);

        assertThat(result).isInstanceOf(OllamaEmbeddingModel.class);
        verify(ollamaEmbeddingModelBuilder, times(1)).baseUrl(baseUrl);
        verify(ollamaEmbeddingModelBuilder, times(1)).modelName(modelName);
        verify(ollamaEmbeddingModelBuilder, times(1)).timeout(Duration.ofSeconds(60));
    }

    @Test
    @DisplayName("edge case: should use default base URL if not provided")
    public void ollamaEmbeddingModel_noBaseUrl_returnOllamaEmbeddingModel() {
        String baseUrl = "";
        EmbeddingModel result = embeddingConfig.ollamaEmbeddingModel(baseUrl, modelName);

        assertThat(result).isInstanceOf(OllamaEmbeddingModel.class);
        verify(ollamaEmbeddingModelBuilder, times(1)).baseUrl("http://localhost:11434");
    }

    @Test
    @DisplayName("edge case: should use default model name if not provided")
    public void ollamaEmbeddingModel_noModelName_returnOllamaEmbeddingModel() {
        String modelName = "";
        EmbeddingModel result = embeddingConfig.ollamaEmbeddingModel(baseUrl, modelName);

        assertThat(result).isInstanceOf(OllamaEmbeddingModel.class);
        verify(ollamaEmbeddingModelBuilder, times(1)).modelName("nomic-embed-text");
    }

    @Test
    @DisplayName("error case: should throw IllegalArgumentException if baseUrl is null")
    public void ollamaEmbeddingModel_nullBaseUrl_throwIllegalArgumentException() {
        String baseUrl = null;

        assertThatThrownBy(() -> embeddingConfig.ollamaEmbeddingModel(baseUrl, modelName))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("baseUrl must not be null");
    }

    @Test
    @DisplayName("error case: should throw IllegalArgumentException if modelName is null")
    public void ollamaEmbeddingModel_nullModelName_throwIllegalArgumentException() {
        String modelName = null;

        assertThatThrownBy(() -> embeddingConfig.ollamaEmbeddingModel(baseUrl, modelName))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("modelName must not be null");
    }
}

