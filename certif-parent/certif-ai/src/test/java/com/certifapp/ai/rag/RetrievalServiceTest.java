package com.certifapp.ai.rag;

import dev.langchain4j.data.segment.TextSegment;
import dev.langchain4j.store.embedding.EmbeddingMatch;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class RetrievalServiceTest {

    @Mock
    private VectorStoreAdapter vectorStore;

    @InjectMocks
    private RetrievalService retrievalService;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @Test
    @DisplayName("retrieveContext_queryWithMatches_expectedFormattedString")
    public void retrieveContext_queryWithMatches_expectedFormattedString() {
        String query = "Java programming";
        int maxResults = 2;
        List<EmbeddingMatch<TextSegment>> matches = List.of(
                new EmbeddingMatch<>(new TextSegment("Java is a class-based, object-oriented programming language.", Collections.singletonMap("source", "corpus"))),
                new EmbeddingMatch<>(new TextSegment("Python is also an object-oriented programming language.", Collections.singletonMap("source", "corpus")))
        );

        when(vectorStore.search(anyString(), anyInt(), anyDouble())).thenReturn(matches);

        String result = retrievalService.retrieveContext(query, maxResults);

        assertThat(result).isEqualTo(
                "### Source: corpus\nJava is a class-based, object-oriented programming language.\n---\n" +
                        "### Source: corpus\nPython is also an object-oriented programming language."
        );

        verify(vectorStore).search("Java programming", 2, 0.65);
    }

    @Test
    @DisplayName("retrieveContext_queryWithNoMatches_emptyString")
    public void retrieveContext_queryWithNoMatches_emptyString() {
        String query = "Unknown topic";
        int maxResults = 2;

        when(vectorStore.search(anyString(), anyInt(), anyDouble())).thenReturn(Collections.emptyList());

        String result = retrievalService.retrieveContext(query, maxResults);

        assertThat(result).isEmpty();

        verify(vectorStore).search("Unknown topic", 2, 0.65);
    }

    @Test
    @DisplayName("retrieveSources_queryWithMatches_expectedSourceReferences")
    public void retrieveSources_queryWithMatches_expectedSourceReferences() {
        String query = "Java programming";
        int maxResults = 2;
        List<EmbeddingMatch<TextSegment>> matches = List.of(
                new EmbeddingMatch<>(new TextSegment("", Collections.singletonMap("certificationId", "C1"))),
                new EmbeddingMatch<>(new TextSegment("", Collections.singletonMap("themeCode", "T1")))
        );

        when(vectorStore.search(anyString(), anyInt(), anyDouble())).thenReturn(matches);

        List<String> result = retrievalService.retrieveSources(query, maxResults);

        assertThat(result).isEqualTo(List.of("C1/T1"));

        verify(vectorStore).search("Java programming", 2, 0.65);
    }

    @Test
    @DisplayName("retrieveSources_queryWithNoMatches_emptyList")
    public void retrieveSources_queryWithNoMatches_emptyList() {
        String query = "Unknown topic";
        int maxResults = 2;

        when(vectorStore.search(anyString(), anyInt(), anyDouble())).thenReturn(Collections.emptyList());

        List<String> result = retrievalService.retrieveSources(query, maxResults);

        assertThat(result).isEmpty();

        verify(vectorStore).search("Unknown topic", 2, 0.65);
    }

    @Test
    @DisplayName("retrieveSources_queryWithMatches_distinctSources")
    public void retrieveSources_queryWithMatches_distinctSources() {
        String query = "Java programming";
        int maxResults = 3;
        List<EmbeddingMatch<TextSegment>> matches = List.of(
                new EmbeddingMatch<>(new TextSegment("", Collections.singletonMap("certificationId", "C1"))),
                new EmbeddingMatch<>(new TextSegment("", Collections.singletonMap("themeCode", "T1"))),
                new EmbeddingMatch<>(new TextSegment("", Collections.singletonMap("certificationId", "C2")))
        );

        when(vectorStore.search(anyString(), anyInt(), anyDouble())).thenReturn(matches);

        List<String> result = retrievalService.retrieveSources(query, maxResults);

        assertThat(result).isEqualTo(List.of("C1/T1", "C2"));

        verify(vectorStore).search("Java programming", 3, 0.65);
    }
}

