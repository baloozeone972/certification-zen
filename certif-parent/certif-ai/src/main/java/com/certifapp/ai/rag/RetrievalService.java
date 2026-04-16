// certif-parent/certif-ai/src/main/java/com/certifapp/ai/rag/RetrievalService.java
package com.certifapp.ai.rag;

import dev.langchain4j.data.segment.TextSegment;
import dev.langchain4j.store.embedding.EmbeddingMatch;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Service for semantic retrieval of relevant context for RAG.
 *
 * <p>Wraps {@link VectorStoreAdapter} with higher-level methods
 * that format retrieved context for prompt injection.</p>
 */
@Service
public class RetrievalService {

    private final VectorStoreAdapter vectorStore;

    public RetrievalService(VectorStoreAdapter vectorStore) {
        this.vectorStore = vectorStore;
    }

    /**
     * Retrieves relevant context as a formatted string for prompt injection.
     *
     * @param query      the user's question
     * @param maxResults maximum number of context segments
     * @return formatted context string ready for prompt injection
     */
    public String retrieveContext(String query, int maxResults) {
        List<EmbeddingMatch<TextSegment>> matches = vectorStore.search(query, maxResults, 0.65);

        if (matches.isEmpty()) {
            return "";
        }

        return matches.stream()
                .map(match -> {
                    String source = match.embedded().metadata().getString("source");
                    String content = match.embedded().text();
                    return String.format("### Source: %s
%s", source != null ? source : "corpus", content);
                })
                .collect(Collectors.joining("

---

"));
    }

    /**
     * Returns the top-K matching segments with their metadata.
     * Used by the chat assistant to cite sources in responses.
     *
     * @param query      the user's question
     * @param maxResults maximum number of results
     * @return list of source references (certificationId + themeCode)
     */
    public List<String> retrieveSources(String query, int maxResults) {
        return vectorStore.search(query, maxResults, 0.65).stream()
                .map(match -> {
                    String certId = match.embedded().metadata().getString("certificationId");
                    String theme  = match.embedded().metadata().getString("themeCode");
                    return certId != null ? certId + (theme != null ? "/" + theme : "") : "corpus";
                })
                .distinct()
                .toList();
    }
}
