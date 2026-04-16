// certif-parent/certif-ai/src/main/java/com/certifapp/ai/config/ModelRouterConfig.java
package com.certifapp.ai.config;

import dev.langchain4j.model.anthropic.AnthropicChatModel;
import dev.langchain4j.model.anthropic.AnthropicStreamingChatModel;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.chat.StreamingChatLanguageModel;
import dev.langchain4j.model.ollama.OllamaChatModel;
import dev.langchain4j.model.ollama.OllamaStreamingChatModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import java.time.Duration;

/**
 * LangChain4j ModelRouter configuration.
 *
 * <p>Routes text generation to the appropriate LLM based on the active Spring profile:
 * <ul>
 *   <li><b>local</b> — Ollama running on localhost:11434 (llama3.1:8b-instruct)</li>
 *   <li><b>prod</b>  — Anthropic Claude API (haiku for light tasks, sonnet for heavy)</li>
 * </ul>
 *
 * <p>Two model tiers are exposed as beans:
 * <ul>
 *   <li>{@code lightModel} — fast/cheap: enrichissement, flashcards, résumés</li>
 *   <li>{@code heavyModel} — powerful: RAG chat, coach report, interview simulator</li>
 * </ul>
 */
@Configuration
public class ModelRouterConfig {

    private static final Logger log = LoggerFactory.getLogger(ModelRouterConfig.class);

    // ── LOCAL profile — Ollama ─────────────────────────────────────────────────

    /**
     * Light model — local Ollama (profil local uniquement).
     * llama3.1:8b-instruct-q4_K_M : 5Go RAM, acceptable pour dev.
     */
    @Bean("lightModel")
    @Profile("local")
    public ChatLanguageModel ollamaLightModel(
            @Value("${certifapp.ai.ollama.base-url:http://localhost:11434}") String baseUrl,
            @Value("${certifapp.ai.ollama.light-model:llama3.1:8b-instruct-q4_K_M}") String modelName) {
        log.info("AI ModelRouter [local] lightModel → Ollama {} @ {}", modelName, baseUrl);
        return OllamaChatModel.builder()
                .baseUrl(baseUrl)
                .modelName(modelName)
                .temperature(0.3)
                .timeout(Duration.ofSeconds(120))
                .build();
    }

    /**
     * Heavy model — local Ollama (même modèle en dev, simplifié).
     */
    @Bean("heavyModel")
    @Profile("local")
    public ChatLanguageModel ollamaHeavyModel(
            @Value("${certifapp.ai.ollama.base-url:http://localhost:11434}") String baseUrl,
            @Value("${certifapp.ai.ollama.heavy-model:llama3.1:8b-instruct-q4_K_M}") String modelName) {
        log.info("AI ModelRouter [local] heavyModel → Ollama {} @ {}", modelName, baseUrl);
        return OllamaChatModel.builder()
                .baseUrl(baseUrl)
                .modelName(modelName)
                .temperature(0.5)
                .timeout(Duration.ofSeconds(180))
                .build();
    }

    /**
     * Streaming model — local Ollama (pour le chat en temps réel).
     */
    @Bean("streamingModel")
    @Profile("local")
    public StreamingChatLanguageModel ollamaStreamingModel(
            @Value("${certifapp.ai.ollama.base-url:http://localhost:11434}") String baseUrl,
            @Value("${certifapp.ai.ollama.heavy-model:llama3.1:8b-instruct-q4_K_M}") String modelName) {
        return OllamaStreamingChatModel.builder()
                .baseUrl(baseUrl)
                .modelName(modelName)
                .temperature(0.5)
                .timeout(Duration.ofSeconds(180))
                .build();
    }

    // ── PROD profile — Anthropic Claude ──────────────────────────────────────

    /**
     * Light model — prod Claude Haiku (rapide, économique).
     * Coût estimé : ~0.01-0.05€ par appel.
     * Usages : enrichissement explications, génération flashcards, résumés cours.
     */
    @Bean("lightModel")
    @Profile("prod")
    public ChatLanguageModel claudeLightModel(
            @Value("${anthropic.api-key}") String apiKey,
            @Value("${certifapp.ai.anthropic.light-model:claude-3-haiku-20240307}") String modelName) {
        log.info("AI ModelRouter [prod] lightModel → Claude {}", modelName);
        return AnthropicChatModel.builder()
                .apiKey(apiKey)
                .modelName(modelName)
                .temperature(0.3)
                .maxTokens(2048)
                .timeout(Duration.ofSeconds(60))
                .build();
    }

    /**
     * Heavy model — prod Claude Sonnet (puissant, plus coûteux).
     * Coût estimé : ~0.10-0.20€ par appel.
     * Usages : chat RAG, rapport coach, simulateur entretien, diagnostic.
     */
    @Bean("heavyModel")
    @Profile("prod")
    public ChatLanguageModel claudeHeavyModel(
            @Value("${anthropic.api-key}") String apiKey,
            @Value("${certifapp.ai.anthropic.heavy-model:claude-sonnet-4-6}") String modelName) {
        log.info("AI ModelRouter [prod] heavyModel → Claude {}", modelName);
        return AnthropicChatModel.builder()
                .apiKey(apiKey)
                .modelName(modelName)
                .temperature(0.5)
                .maxTokens(4096)
                .timeout(Duration.ofSeconds(120))
                .build();
    }

    /**
     * Streaming model — prod Claude Sonnet (chat en temps réel).
     */
    @Bean("streamingModel")
    @Profile("prod")
    public StreamingChatLanguageModel claudeStreamingModel(
            @Value("${anthropic.api-key}") String apiKey,
            @Value("${certifapp.ai.anthropic.heavy-model:claude-sonnet-4-6}") String modelName) {
        return AnthropicStreamingChatModel.builder()
                .apiKey(apiKey)
                .modelName(modelName)
                .temperature(0.5)
                .maxTokens(4096)
                .timeout(Duration.ofSeconds(120))
                .build();
    }
}
