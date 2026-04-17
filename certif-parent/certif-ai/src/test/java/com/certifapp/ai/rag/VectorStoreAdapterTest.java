package com.certifapp.ai.rag;

import dev.langchain4j.data.embedding.Embedding;
import dev.langchain4j.data.segment.TextSegment;
import dev.langchain4j.model.embedding.EmbeddingModel;
import dev.langchain4j.store.embedding.EmbeddingMatch;
import dev.langchain4j.store.embedding.EmbeddingSearchRequest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class VectorStoreAdapterTest {

    @Mock
    private DataSource dataSource;

    @Mock
    private EmbeddingModel embeddingModel;

    @InjectMocks
    private VectorStoreAdapter vectorStoreAdapter;

    @BeforeEach
    public void setUp() {
        when(dataSource.getConnection()).thenReturn(null);
        when(embeddingModel.embed(any(TextSegment.class)).content()).thenReturn(new Embedding(new double[1536]));
    }

    @Test
    @DisplayName("store_textWithMetadata_storesEmbeddingAndReturnsId")
    public void store_textWithMetadata_storesEmbeddingAndReturnsId() {
        Map<String, String> metadata = new HashMap<>();
        metadata.put("source", "test_source");
        String text = "test_text";
        String storedId = vectorStoreAdapter.store(text, metadata);

        verify(embeddingModel).embed(any(TextSegment.class));
        verify(vectorStoreAdapter.store).add(any(Embedding.class), any(TextSegment.class));

        assertThat(storedId).isNotNull();
    }

    @Test
    @DisplayName("search_queryWithMaxResultsAndMinScore_returnsTopKMatches")
    public void search_queryWithMaxResultsAndMinScore_returnsTopKMatches() {
        String query = "test_query";
        int maxResults = 3;
        double minScore = 0.8;

        List<EmbeddingMatch<TextSegment>> matches = vectorStoreAdapter.search(query, maxResults, minScore);

        verify(embeddingModel).embed(eq(query));
        verify(vectorStoreAdapter.store).search(any(EmbeddingSearchRequest.class));

        assertThat(matches).hasSize(maxResults);
    }

    @Test
    @DisplayName("search_queryWithDefaultParams_returnsTop5Matches")
    public void search_queryWithDefaultParams_returnsTop5Matches() {
        String query = "test_query";

        List<EmbeddingMatch<TextSegment>> matches = vectorStoreAdapter.search(query);

        verify(embeddingModel).embed(eq(query));
        verify(vectorStoreAdapter.store).search(any(EmbeddingSearchRequest.class));

        assertThat(matches).hasSize(5);
    }

    @Test
    @DisplayName("store_emptyMetadata_storesEmbeddingAndReturnsId")
    public void store_emptyMetadata_storesEmbeddingAndReturnsId() {
        Map<String, String> metadata = new HashMap<>();
        String text = "test_text";
        String storedId = vectorStoreAdapter.store(text, metadata);

        verify(embeddingModel).embed(any(TextSegment.class));
        verify(vectorStoreAdapter.store).add(any(Embedding.class), any(TextSegment.class));

        assertThat(storedId).isNotNull();
    }

    @Test
    @DisplayName("search_nullQuery_returnsEmptyList")
    public void search_nullQuery_returnsEmptyList() {
        List<EmbeddingMatch<TextSegment>> matches = vectorStoreAdapter.search(null);

        verify(embeddingModel, never()).embed(any(TextSegment.class));
        verify(vectorStoreAdapter.store, never()).search(any(EmbeddingSearchRequest.class));

        assertThat(matches).isEmpty();
    }

    @Test
    @DisplayName("search_emptyQuery_returnsEmptyList")
    public void search_emptyQuery_returnsEmptyList() {
        List<EmbeddingMatch<TextSegment>> matches = vectorStoreAdapter.search("");

        verify(embeddingModel, never()).embed(any(TextSegment.class));
        verify(vectorStoreAdapter.store, never()).search(any(EmbeddingSearchRequest.class));

        assertThat(matches).isEmpty();
    }

    @Test
    @DisplayName("store_nullMetadata_storesEmbeddingAndReturnsId")
    public void store_nullMetadata_storesEmbeddingAndReturnsId() {
        String text = "test_text";
        String storedId = vectorStoreAdapter.store(text, null);

        verify(embeddingModel).embed(any(TextSegment.class));
        verify(vectorStoreAdapter.store).add(any(Embedding.class), any(TextSegment.class));

        assertThat(storedId).isNotNull();
    }
}

