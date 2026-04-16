// certif-parent/certif-ai/src/main/java/com/certifapp/ai/service/CourseGenerator.java
package com.certifapp.ai.service;

import dev.langchain4j.model.chat.ChatLanguageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**
 * AI service generating preparatory course content in Markdown.
 *
 * <p>Generates comprehensive study guides for each theme of a certification.
 * The generated content is saved with {@code AI_GENERATED} status and requires
 * human review before being published to users.</p>
 *
 * <p>Uses the light model — content generation is a structured task
 * where Haiku performs well at lower cost.</p>
 */
@Service
public class CourseGenerator {

    private static final Logger log = LoggerFactory.getLogger(CourseGenerator.class);

    private final ChatLanguageModel lightModel;
    private final PromptRenderer    promptRenderer;

    public CourseGenerator(
            @Qualifier("lightModel") ChatLanguageModel lightModel,
            PromptRenderer promptRenderer) {
        this.lightModel    = lightModel;
        this.promptRenderer = promptRenderer;
    }

    /**
     * Generates a Markdown course for a specific theme.
     *
     * @param certificationId the certification (e.g. "ocp21")
     * @param themeLabel      the theme display name (e.g. "Virtual Threads")
     * @param sampleQuestions list of question statements for context (max 10)
     * @return Markdown-formatted course content
     */
    public String generateCourse(String certificationId, String themeLabel,
                                  List<String> sampleQuestions) {

        log.info("Generating course: {} / {}", certificationId, themeLabel);

        List<Map<String, String>> qList = sampleQuestions.stream()
                .limit(10)
                .map(q -> Map.of("statement", q))
                .toList();

        Map<String, Object> vars = new HashMap<>();
        vars.put("certificationId", certificationId);
        vars.put("themeLabel",      themeLabel);
        vars.put("questions",       qList);

        String prompt = promptRenderer.render("course_generation", vars);

        try {
            String content = lightModel.generate(prompt);
            log.info("Course generated for {}/{}: {} chars",
                    certificationId, themeLabel, content.length());
            return content.trim();
        } catch (Exception e) {
            log.error("Failed to generate course for {}/{}: {}",
                    certificationId, themeLabel, e.getMessage());
            return "# " + themeLabel + "

Contenu en cours de génération...";
        }
    }
}
