// certif-parent/certif-ai/src/main/java/com/certifapp/ai/service/WeeklyCoachReport.java
package com.certifapp.ai.service;

import dev.langchain4j.model.chat.ChatLanguageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * AI service generating personalized weekly coach reports.
 *
 * <p>Runs every Monday at 08:00 via {@code WeeklyCoachScheduler} in certif-infrastructure.
 * Uses the heavy model for richer, more personalized content.</p>
 *
 * <p>Report includes: performance summary, weak areas, 7-day study plan, motivation.</p>
 */
@Service
public class WeeklyCoachReport {

    private static final Logger log = LoggerFactory.getLogger(WeeklyCoachReport.class);

    private final ChatLanguageModel heavyModel;
    private final PromptRenderer    promptRenderer;

    public WeeklyCoachReport(
            @Qualifier("heavyModel") ChatLanguageModel heavyModel,
            PromptRenderer promptRenderer) {
        this.heavyModel    = heavyModel;
        this.promptRenderer = promptRenderer;
    }

    /**
     * Generates a personalized weekly coach report in Markdown.
     *
     * @param weekStart        the Monday date string (ISO format)
     * @param certificationId  the certification the user is preparing
     * @param sessionsCount    number of sessions completed this week
     * @param averageScore     average score percentage
     * @param bestScore        best score percentage
     * @param themeStats       list of theme performance maps
     * @param cardsDueToday    number of SM-2 cards due today
     * @param cardsReviewed    number of cards reviewed this week
     * @param averageEaseFactor average SM-2 ease factor
     * @return Markdown-formatted coach report
     */
    public String generate(String weekStart, String certificationId,
                           int sessionsCount, double averageScore, double bestScore,
                           java.util.List<java.util.Map<String, Object>> themeStats,
                           int cardsDueToday, int cardsReviewed, double averageEaseFactor) {

        log.info("Generating weekly coach report for week {} / {}", weekStart, certificationId);

        Map<String, Object> vars = Map.of(
                "weekStart",          weekStart,
                "certificationId",    certificationId,
                "sessionsCount",      sessionsCount,
                "averageScore",       String.format("%.1f", averageScore),
                "bestScore",          String.format("%.1f", bestScore),
                "themeStats",         themeStats,
                "cardsDueToday",      cardsDueToday,
                "cardsReviewed",      cardsReviewed,
                "averageEaseFactor",  String.format("%.2f", averageEaseFactor)
        );

        String prompt = promptRenderer.render("weekly_coach_report", vars);

        try {
            return heavyModel.generate(prompt);
        } catch (Exception e) {
            log.error("Failed to generate weekly report for {}: {}", weekStart, e.getMessage());
            return "# Rapport hebdomadaire

Erreur lors de la génération du rapport. "
                    + "Continuez vos révisions !";
        }
    }
}
