// certif-parent/certif-ai/src/main/java/com/certifapp/ai/service/CertPathAdvisor.java
package com.certifapp.ai.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * AI service recommending personalized certification learning paths.
 *
 * <p>Combines the user's diagnostic skill map, role type and project goal
 * to generate an ordered, justified certification roadmap.</p>
 */
@Service
public class CertPathAdvisor {

    private static final Logger log = LoggerFactory.getLogger(CertPathAdvisor.class);

    private final ChatLanguageModel lightModel;
    private final PromptRenderer    promptRenderer;
    private final ObjectMapper      objectMapper;

    public CertPathAdvisor(
            @Qualifier("lightModel") ChatLanguageModel lightModel,
            PromptRenderer promptRenderer,
            ObjectMapper objectMapper) {
        this.lightModel    = lightModel;
        this.promptRenderer = promptRenderer;
        this.objectMapper  = objectMapper;
    }

    /**
     * Generates a personalized certification path.
     *
     * @param roleType       the user's professional role
     * @param projectGoal    the user's stated goal
     * @param skillMap       current skill confidence (domain → 0.0-1.0)
     * @param certifications available certifications (id, name, examType, passingScore)
     * @return map with "steps" (ordered list) and "aiRationale" keys
     */
    public Map<String, Object> recommendPath(
            String roleType, String projectGoal,
            Map<String, Double> skillMap,
            List<Map<String, String>> certifications) {

        log.info("Generating cert path for role: {} / goal: {}", roleType, projectGoal);

        List<Map<String, String>> skillList = skillMap.entrySet().stream()
                .map(e -> Map.of("skill", e.getKey(),
                        "confidence", String.format("%.0f", e.getValue() * 100)))
                .toList();

        Map<String, Object> vars = new HashMap<>();
        vars.put("roleType",        roleType != null ? roleType : "Software Developer");
        vars.put("projectGoal",     projectGoal != null ? projectGoal : "Improve technical skills");
        vars.put("skillMap",        skillList);
        vars.put("certifications",  certifications);

        String prompt = promptRenderer.render("cert_path_advisor", vars);

        try {
            String response = lightModel.generate(prompt);
            String json = response.replaceAll("```json\s*|```", "").trim();
            return objectMapper.readValue(json, new TypeReference<>() {});
        } catch (Exception e) {
            log.error("Failed to generate cert path: {}", e.getMessage());
            return Map.of("steps", List.of(), "aiRationale", "");
        }
    }
}
