// certif-parent/certif-ai/src/main/java/com/certifapp/ai/service/DiagnosticAnalyzer.java
package com.certifapp.ai.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AI service analyzing diagnostic test results to build a skill map
 * and recommend certification paths.
 *
 * <p>Uses the light model for structured JSON output generation.</p>
 */
@Service
public class DiagnosticAnalyzer {

    private static final Logger log = LoggerFactory.getLogger(DiagnosticAnalyzer.class);

    private final ChatLanguageModel lightModel;
    private final PromptRenderer promptRenderer;
    private final ObjectMapper objectMapper;

    public DiagnosticAnalyzer(
            @Qualifier("lightModel") ChatLanguageModel lightModel,
            PromptRenderer promptRenderer,
            ObjectMapper objectMapper) {
        this.lightModel = lightModel;
        this.promptRenderer = promptRenderer;
        this.objectMapper = objectMapper;
    }

    /**
     * Analyzes diagnostic results to produce a skill map and certification recommendations.
     *
     * @param scoreByDomain  map of domain name → score percentage
     * @param certifications list of available certification summaries (id, name)
     * @param roleType       the user's declared role interest
     * @return map with "skillMap" and "recommendations" keys
     */
    public Map<String, Object> analyze(
            Map<String, Integer> scoreByDomain,
            List<Map<String, String>> certifications,
            String roleType) {

        log.info("Analyzing diagnostic results for role: {}", roleType);

        // Build template variables
        List<Map<String, String>> domainList = scoreByDomain.entrySet().stream()
                .map(e -> Map.of("domain", e.getKey(), "score", e.getValue().toString()))
                .toList();

        Map<String, Object> vars = new HashMap<>();
        vars.put("totalQuestions", scoreByDomain.size() * 10);
        vars.put("scoreByDomain", domainList);
        vars.put("certifications", certifications);
        vars.put("roleType", roleType != null ? roleType : "Software Developer");

        String prompt = promptRenderer.render("diagnostic_analysis", vars);

        try {
            String response = lightModel.generate(prompt);
            String json = response.replaceAll("json\\s*|", "").trim();
            return objectMapper.readValue(json, new TypeReference<>() {});
        } catch (Exception e) {
            log.error("Failed to analyze diagnostic: {}", e.getMessage());
            return Map.of(
                    "skillMap", Map.of(),
                    "recommendations", List.of()
            );
        }
    }
}