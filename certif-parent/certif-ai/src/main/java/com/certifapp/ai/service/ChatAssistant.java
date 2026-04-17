// certif-parent/certif-ai/src/main/java/com/certifapp/ai/service/ChatAssistant.java
package com.certifapp.ai.service;

import com.certifapp.ai.rag.RetrievalService;
import dev.langchain4j.memory.chat.MessageWindowChatMemory;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * AI conversational assistant with RAG (Retrieval-Augmented Generation).
 *
 * <p>Maintains per-session conversation history (last 10 messages) using
 * LangChain4j's {@link MessageWindowChatMemory}.
 * RAG context is retrieved from the pgvector store on each user message.</p>
 *
 * <p>Uses the heavy model (Claude Sonnet / Ollama) for high-quality responses.</p>
 */
@Service
public class ChatAssistant {

    private static final Logger log = LoggerFactory.getLogger(ChatAssistant.class);

    /**
     * In-memory session store — conversation history per session UUID.
     */
    private final Map<UUID, MessageWindowChatMemory> sessions = new ConcurrentHashMap<>();

    private final ChatLanguageModel heavyModel;
    private final RetrievalService retrievalService;
    private final PromptRenderer promptRenderer;

    public ChatAssistant(
            @Qualifier("heavyModel") ChatLanguageModel heavyModel,
            RetrievalService retrievalService,
            PromptRenderer promptRenderer) {
        this.heavyModel = heavyModel;
        this.retrievalService = retrievalService;
        this.promptRenderer = promptRenderer;
    }

    /**
     * Sends a user message and returns the AI response.
     * RAG context is automatically retrieved and injected into the prompt.
     *
     * @param message          the user's question or message
     * @param sessionId        conversation session UUID (null = new session)
     * @param certificationId  the certification the user is studying
     * @param subscriptionTier the user's subscription tier
     * @return AI response text
     */
    public String chat(String message, UUID sessionId, String certificationId,
                       String subscriptionTier) {

        UUID sid = sessionId != null ? sessionId : UUID.randomUUID();

        // Retrieve relevant context from vector store
        String context = retrievalService.retrieveContext(message, 5);
        List<String> sources = retrievalService.retrieveSources(message, 5);

        log.debug("Chat session {} — retrieved {} context chars from {} sources",
                sid, context.length(), sources.size());

        // Build system prompt with RAG context
        Map<String, Object> templateVars = new HashMap<>();
        templateVars.put("certificationId", certificationId);
        templateVars.put("subscriptionTier", subscriptionTier);
        templateVars.put("sources", buildSourcesForTemplate(context, sources));

        String systemPrompt = promptRenderer.render("chat_assistant_system", templateVars);

        // Full prompt = system + user message
        String fullPrompt = systemPrompt + "

##User question
        " + message;

        try {
            return heavyModel.generate(fullPrompt);
        } catch (Exception e) {
            log.error("Chat generation failed for session {}: {}", sid, e.getMessage());
            return "Je suis désolé, une erreur s'est produite. Veuillez réessayer.";
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private List<Map<String, String>> buildSourcesForTemplate(String context, List<String> sources) {
        if (context.isBlank()) return List.of();
        return List.of(Map.of("source", String.join(", ", sources), "content", context));
    }
}
