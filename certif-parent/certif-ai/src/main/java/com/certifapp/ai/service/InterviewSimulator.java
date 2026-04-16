// certif-parent/certif-ai/src/main/java/com/certifapp/ai/service/InterviewSimulator.java
package com.certifapp.ai.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * AI service simulating technical job interviews.
 *
 * <p>Generates contextual interview questions and provides structured feedback
 * on the candidate's answers using the heavy model.</p>
 */
@Service
public class InterviewSimulator {

    private static final Logger log = LoggerFactory.getLogger(InterviewSimulator.class);

    private final ChatLanguageModel heavyModel;
    private final PromptRenderer    promptRenderer;
    private final ObjectMapper      objectMapper;

    public InterviewSimulator(
            @Qualifier("heavyModel") ChatLanguageModel heavyModel,
            PromptRenderer promptRenderer,
            ObjectMapper objectMapper) {
        this.heavyModel    = heavyModel;
        this.promptRenderer = promptRenderer;
        this.objectMapper  = objectMapper;
    }

    /**
     * Generates a technical interview question for a given domain and difficulty.
     *
     * @param certificationId the certification context
     * @param domain          technical domain (e.g. "Virtual Threads", "DynamoDB")
     * @param roleType        the target job role (e.g. "Java Developer")
     * @param difficulty      easy | medium | hard
     * @return the generated interview question text
     */
    public String generateQuestion(String certificationId, String domain,
                                   String roleType, String difficulty) {
        String prompt = promptRenderer.render("interview_question", Map.of(
                "certificationId", certificationId,
                "domain",          domain,
                "roleType",        roleType != null ? roleType : "Software Developer",
                "difficulty",      difficulty
        ));

        try {
            return heavyModel.generate(prompt).trim();
        } catch (Exception e) {
            log.error("Failed to generate interview question: {}", e.getMessage());
            return "Expliquez les avantages des Virtual Threads en Java 21.";
        }
    }

    /**
     * Evaluates a candidate's interview answer and returns structured feedback.
     *
     * @param certificationId the certification context
     * @param questionText    the interview question
     * @param userAnswer      the candidate's answer
     * @param domain          technical domain
     * @return map with score (0-10), feedback, keyPointsMissed, strongPoints
     */
    public Map<String, Object> evaluateAnswer(String certificationId, String questionText,
                                               String userAnswer, String domain) {
        String prompt = promptRenderer.render("interview_feedback", Map.of(
                "certificationId", certificationId,
                "questionText",    questionText,
                "userAnswer",      userAnswer,
                "domain",          domain
        ));

        try {
            String response = heavyModel.generate(prompt);
            String json = response.replaceAll("```json\s*|```", "").trim();
            return objectMapper.readValue(json, new TypeReference<>() {});
        } catch (Exception e) {
            log.error("Failed to evaluate interview answer: {}", e.getMessage());
            return Map.of(
                    "score",           5,
                    "feedback",        "Évaluation non disponible. Continuez à pratiquer !",
                    "keyPointsMissed", List.of(),
                    "strongPoints",    List.of()
            );
        }
    }
}
