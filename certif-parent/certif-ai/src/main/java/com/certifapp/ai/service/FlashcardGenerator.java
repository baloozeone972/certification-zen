// certif-parent/certif-ai/src/main/java/com/certifapp/ai/service/FlashcardGenerator.java
package com.certifapp.ai.service;

import com.certifapp.domain.model.learning.Flashcard;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * AI service for generating flashcards from course content.
 *
 * <p>Uses the light model to generate concise front/back flashcard pairs
 * optimized for spaced-repetition review (SM-2 algorithm).</p>
 */
@Service
public class FlashcardGenerator {

    private static final Logger log = LoggerFactory.getLogger(FlashcardGenerator.class);

    private final ChatLanguageModel lightModel;
    private final PromptRenderer promptRenderer;
    private final ObjectMapper objectMapper;

    public FlashcardGenerator(
            @Qualifier("lightModel") ChatLanguageModel lightModel,
            PromptRenderer promptRenderer,
            ObjectMapper objectMapper) {
        this.lightModel = lightModel;
        this.promptRenderer = promptRenderer;
        this.objectMapper = objectMapper;
    }

    /**
     * Generates flashcards from course content.
     *
     * @param courseId        the source course UUID
     * @param certificationId the certification context
     * @param themeLabel      the theme display name
     * @param content         the course Markdown content
     * @param count           number of flashcards to generate (default 10)
     * @return list of generated flashcards (AI_GENERATED flag = true)
     */
    public List<Flashcard> generateFromCourse(
            UUID courseId, String certificationId, String themeLabel,
            String content, int count) {

        log.info("Generating {} flashcards for course: {} / {}", count, certificationId, themeLabel);

        // Truncate content to avoid token limits
        String truncated = content.length() > 3000 ? content.substring(0, 3000) : content;

        String prompt = promptRenderer.render("flashcard_generation", Map.of(
                "certificationId", certificationId,
                "themeLabel", themeLabel,
                "content", truncated,
                "count", String.valueOf(count)
        ));

        try {
            String response = lightModel.generate(prompt);
            // Strip potential markdown code fences
            String json = response.replaceAll("json\\s*|", "").trim();
            List<Map<String, String>> raw = objectMapper.readValue(
                    json, new TypeReference<>() {
                    });

            return raw.stream()
                    .filter(m -> m.containsKey("front") && m.containsKey("back"))
                    .map(m -> Flashcard.fromCourse(
                            courseId,
                            m.get("front"),
                            m.get("back"),
                            m.getOrDefault("codeExample", ""),
                            true))
                    .toList();

        } catch (Exception e) {
            log.error("Failed to generate flashcards for {}/{}: {}",
                    certificationId, themeLabel, e.getMessage());
            return new ArrayList<>();
        }
    }
}