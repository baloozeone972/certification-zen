// certif-parent/certif-ai/src/main/java/com/certifapp/ai/rag/VectorStoreAdapter.java
package com.certifapp.ai.rag;

import dev.langchain4j.data.document.Metadata;
import dev.langchain4j.data.embedding.Embedding;
import dev.langchain4j.data.segment.TextSegment;
import dev.langchain4j.model.embedding.EmbeddingModel;
import dev.langchain4j.store.embedding.EmbeddingMatch;
import dev.langchain4j.store.embedding.EmbeddingSearchRequest;
import dev.langchain4j.store.embedding.pgvector.PgVectorEmbeddingStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.util.List;
import java.util.Map;

/**
 * Adapter wrapping LangChain4j's {@link PgVectorEmbeddingStore}.
 *
 * <p>Provides semantic search over the question and course corpus stored
 * in the {@code langchain4j_embeddings} PostgreSQL table.</p>
 *
 * <p>Used by {@link RetrievalService} to fetch top-K relevant context
 * for the RAG chat assistant and explanation enricher.</p>
 */
@Component
public class VectorStoreAdapter {

    private static final Logger log = LoggerFactory.getLogger(VectorStoreAdapter.class);

    private final PgVectorEmbeddingStore store;
    private final EmbeddingModel         embeddingModel;

    public VectorStoreAdapter(
            DataSource dataSource,
            @Qualifier("embeddingModel") EmbeddingModel embeddingModel,
            @Value("${certifapp.ai.embedding.dimension:1536}") int dimension) {

        this.embeddingModel = embeddingModel;
        this.store = PgVectorEmbeddingStore.datasourceBuilder()
                .datasource(dataSource)
                .table("langchain4j_embeddings")
                .dimension(dimension)
                .createTable(false)   // Table created by Flyway V5
                .build();

        log.info("VectorStoreAdapter initialized — table: langchain4j_embeddings, dim: {}", dimension);
    }

    /**
     * Stores a text segment with metadata in the vector store.
     *
     * @param text     the text content to embed and store
     * @param metadata key-value metadata (source, certificationId, themeCode, etc.)
     * @return the stored embedding ID
     */
    public String store(String text, Map<String, String> metadata) {
        Metadata lc4jMetadata = new Metadata();
        metadata.forEach(lc4jMetadata::put);
        TextSegment segment = TextSegment.from(text, lc4jMetadata);
        Embedding embedding = embeddingModel.embed(segment).content();
        return this.store.add(embedding, segment);
    }

    /**
     * Searches for the top-K most semantically similar segments to the query.
     *
     * @param query      the search query text
     * @param maxResults maximum number of results to return (default 5)
     * @param minScore   minimum similarity score threshold (0.0-1.0)
     * @return list of matching text segments with their similarity scores
     */
    public List<EmbeddingMatch<TextSegment>> search(String query, int maxResults, double minScore) {
        Embedding queryEmbedding = embeddingModel.embed(query).content();
        EmbeddingSearchRequest request = EmbeddingSearchRequest.builder()
                .queryEmbedding(queryEmbedding)
                .maxResults(maxResults)
                .minScore(minScore)
                .build();
        return store.search(request).matches();
    }

    /**
     * Convenience search with default parameters (top 5, score > 0.7).
     *
     * @param query the search query
     * @return top matching segments
     */
    public List<EmbeddingMatch<TextSegment>> search(String query) {
        return search(query, 5, 0.7);
    }
}
