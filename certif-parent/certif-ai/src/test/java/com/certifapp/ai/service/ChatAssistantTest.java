// certif-parent/certif-ai/src/test/java/com/certifapp/ai/service/ChatAssistantTest.java
package com.certifapp.ai.service;

import com.certifapp.ai.rag.RetrievalService;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;

/**
 * Unit tests for {@link ChatAssistant}.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("ChatAssistant")
class ChatAssistantTest {

    @Mock private ChatLanguageModel heavyModel;
    @Mock private RetrievalService  retrievalService;
    @Mock private PromptRenderer    promptRenderer;

    private ChatAssistant chatAssistant;

    @BeforeEach
    void setUp() {
        chatAssistant = new ChatAssistant(heavyModel, retrievalService, promptRenderer);
    }

    @Test
    @DisplayName("chat() returns AI response with RAG context")
    void chat_shouldReturnAiResponseWithRagContext() {
        // Arrange
        when(retrievalService.retrieveContext(anyString(), anyInt()))
                .thenReturn("Context from corpus");
        when(retrievalService.retrieveSources(anyString(), anyInt()))
                .thenReturn(List.of("ocp21/virtual_threads"));
        when(promptRenderer.render(anyString(), anyMap()))
                .thenReturn("System prompt with context");
        when(heavyModel.generate(anyString()))
                .thenReturn("Virtual threads are lightweight threads managed by the JVM.");

        // Act
        String response = chatAssistant.chat(
                "What are virtual threads?", null, "ocp21", "PRO");

        // Assert
        assertThat(response).contains("Virtual threads");
        verify(retrievalService).retrieveContext("What are virtual threads?", 5);
        verify(heavyModel).generate(anyString());
    }

    @Test
    @DisplayName("chat() returns fallback message on AI error")
    void chat_onError_shouldReturnFallbackMessage() {
        when(retrievalService.retrieveContext(anyString(), anyInt())).thenReturn("");
        when(retrievalService.retrieveSources(anyString(), anyInt())).thenReturn(List.of());
        when(promptRenderer.render(anyString(), anyMap())).thenReturn("prompt");
        when(heavyModel.generate(anyString())).thenThrow(new RuntimeException("Network error"));

        String response = chatAssistant.chat("Question?", null, "ocp21", "PRO");

        assertThat(response).contains("erreur");
    }

    @Test
    @DisplayName("chat() with existing sessionId reuses context")
    void chat_withSessionId_shouldReuseSession() {
        UUID sessionId = UUID.randomUUID();
        when(retrievalService.retrieveContext(anyString(), anyInt())).thenReturn("");
        when(retrievalService.retrieveSources(anyString(), anyInt())).thenReturn(List.of());
        when(promptRenderer.render(anyString(), anyMap())).thenReturn("prompt");
        when(heavyModel.generate(anyString())).thenReturn("Answer");

        // Two calls with same session ID
        chatAssistant.chat("Question 1?", sessionId, "ocp21", "PRO");
        chatAssistant.chat("Question 2?", sessionId, "ocp21", "PRO");

        verify(heavyModel, times(2)).generate(anyString());
    }

    private static java.util.Map<String, Object> anyMap() {
        return ArgumentMatchers.anyMap();
    }
}
