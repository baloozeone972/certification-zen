// certif-parent/certif-ai/src/main/java/com/certifapp/ai/config/EmbeddingConfig.java
package com.certifapp.ai.config;

import dev.langchain4j.model.embedding.EmbeddingModel;
import dev.langchain4j.model.ollama.OllamaEmbeddingModel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import java.time.Duration;

/**
 * Embedding model configuration for pgvector RAG.
 *
 * <p>Embedding dimensions:
 * <ul>
 *   <li>local: nomic-embed-text → 768 dims</li>
 *   <li>prod: text-embedding-3-small (via OpenAI compat) → 1536 dims</li>
 * </ul>
 *
 * <p>The pgvector column is defined as {@code vector(1536)} in the schema.
 * For local 768-dim embeddings, zero-padding to 1536 is applied in
 * {@link com.certifapp.ai.rag.VectorStoreAdapter}.</p>
 */
@Configuration
public class EmbeddingConfig {

    @Bean("embeddingModel")
    @Profile("local")
    public EmbeddingModel ollamaEmbeddingModel(
            @Value("${certifapp.ai.ollama.base-url:http://localhost:11434}") String baseUrl,
            @Value("${certifapp.ai.ollama.embedding-model:nomic-embed-text}") String modelName) {
        return OllamaEmbeddingModel.builder()
                .baseUrl(baseUrl)
                .modelName(modelName)
                .timeout(Duration.ofSeconds(60))
                .build();
    }

    // Note: prod embedding model (Anthropic/OpenAI) configured via LangChain4j auto-config
    // using application-prod.yml properties: langchain4j.open-ai.embedding-model.*
}
