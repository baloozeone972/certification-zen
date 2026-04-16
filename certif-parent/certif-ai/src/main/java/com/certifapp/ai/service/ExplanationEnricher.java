// certif-parent/certif-ai/src/main/java/com/certifapp/ai/service/ExplanationEnricher.java
package com.certifapp.ai.service;

import com.certifapp.domain.model.question.Question;
import com.github.mustachejava.DefaultMustacheFactory;
import com.github.mustachejava.Mustache;
import com.github.mustachejava.MustacheFactory;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.io.StringReader;
import java.io.StringWriter;
import java.util.Map;

/**
 * AI service for enriching question explanations.
 *
 * <p>Uses the light model (Claude Haiku / Ollama) to rewrite terse
 * original explanations into more educational content.
 * Results are cached for 24h to avoid redundant API calls.</p>
 *
 * <p>Enriched explanations are saved as {@code AI_DRAFT} status —
 * a human admin must validate before they become {@code HUMAN_VALIDATED}.</p>
 */
@Service
public class ExplanationEnricher {

    private static final Logger log = LoggerFactory.getLogger(ExplanationEnricher.class);

    private final ChatLanguageModel lightModel;
    private final PromptRenderer    promptRenderer;

    public ExplanationEnricher(
            @Qualifier("lightModel") ChatLanguageModel lightModel,
            PromptRenderer promptRenderer) {
        this.lightModel     = lightModel;
        this.promptRenderer = promptRenderer;
    }

    /**
     * Generates an enriched explanation for a question using the AI model.
     * The result is cached by question ID.
     *
     * @param question the question to enrich
     * @return enriched explanation text (AI_DRAFT — requires human validation)
     */
    @Cacheable(value = "aiExplanations", key = "#question.id()")
    public String enrich(Question question) {
        log.debug("Enriching explanation for question: {}", question.legacyId());

        String prompt = promptRenderer.render("explanation_enrichment", Map.of(
                "question",        question.statement(),
                "explanation",     question.explanationOriginal() != null
                                       ? question.explanationOriginal() : "",
                "certificationId", question.certificationId(),
                "difficulty",      question.difficulty().toJson()
        ));

        try {
            String enriched = lightModel.generate(prompt);
            log.debug("Enrichment complete for question: {} ({} chars)",
                    question.legacyId(), enriched.length());
            return enriched.trim();
        } catch (Exception e) {
            log.error("Failed to enrich question {}: {}", question.legacyId(), e.getMessage());
            return question.explanationOriginal();
        }
    }
}
