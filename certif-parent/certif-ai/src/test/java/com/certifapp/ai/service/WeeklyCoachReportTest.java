package com.certifapp.ai.service;

import dev.langchain4j.model.chat.ChatLanguageModel;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class WeeklyCoachReportTest {

    @Mock
    private ChatLanguageModel heavyModel;

    @Mock
    private PromptRenderer promptRenderer;

    @InjectMocks
    private WeeklyCoachReport weeklyCoachReport;

    @BeforeEach
    public void setUp() {
        // Additional setup if needed
    }

    @DisplayName("should generate a report with nominal data")
    @Test
    public void generate_report_nominalData() throws Exception {
        String weekStart = "2023-10-09";
        String certificationId = "cert123";
        int sessionsCount = 5;
        double averageScore = 85.6;
        double bestScore = 95.0;
        java.util.List<java.util.Map<String, Object>> themeStats = List.of(
                Map.of("theme", "Mathematics", "score", 92),
                Map.of("theme", "English", "score", 88)
        );
        int cardsDueToday = 10;
        int cardsReviewed = 45;
        double averageEaseFactor = 2.5;

        when(heavyModel.generate(anyString())).thenReturn("# Weekly Coach Report\n" +
                "\n" +
                "## Performance Summary\n" +
                "- **Week Start**: 2023-10-09\n" +
                "- **Certification ID**: cert123\n" +
                "- **Sessions Count**: 5\n" +
                "- **Average Score**: 85.6%\n" +
                "- **Best Score**: 95.0%\n" +
                "- **Theme Stats**: [Mathematics: 92%, English: 88%]\n" +
                "\n" +
                "## Motivation\n" +
                "Keep up the good work!");

        String result = weeklyCoachReport.generate(weekStart, certificationId,
                sessionsCount, averageScore, bestScore, themeStats,
                cardsDueToday, cardsReviewed, averageEaseFactor);

        assertThat(result).isEqualTo("# Weekly Coach Report\n" +
                "\n" +
                "## Performance Summary\n" +
                "- **Week Start**: 2023-10-09\n" +
                "- **Certification ID**: cert123\n" +
                "- **Sessions Count**: 5\n" +
                "- **Average Score**: 85.6%\n" +
                "- **Best Score**: 95.0%\n" +
                "- **Theme Stats**: [Mathematics: 92%, English: 88%]\n" +
                "\n" +
                "## Motivation\n" +
                "Keep up the good work!");

        verify(heavyModel, times(1)).generate(anyString());
        verify(promptRenderer, times(1)).render("weekly_coach_report", anyMap());
    }

    @DisplayName("should handle null themeStats")
    @Test
    public void generate_report_nullThemeStats() throws Exception {
        String weekStart = "2023-10-09";
        String certificationId = "cert123";
        int sessionsCount = 5;
        double averageScore = 85.6;
        double bestScore = 95.0;
        java.util.List<java.util.Map<String, Object>> themeStats = null;
        int cardsDueToday = 10;
        int cardsReviewed = 45;
        double averageEaseFactor = 2.5;

        when(heavyModel.generate(anyString())).thenReturn("# Weekly Coach Report\n" +
                "\n" +
                "## Performance Summary\n" +
                "- **Week Start**: 2023-10-09\n" +
                "- **Certification ID**: cert123\n" +
                "- **Sessions Count**: 5\n" +
                "- **Average Score**: 85.6%\n" +
                "- **Best Score**: 95.0%\n" +
                "- **Theme Stats**: []\n" +
                "\n" +
                "## Motivation\n" +
                "Keep up the good work!");

        String result = weeklyCoachReport.generate(weekStart, certificationId,
                sessionsCount, averageScore, bestScore, themeStats,
                cardsDueToday, cardsReviewed, averageEaseFactor);

        assertThat(result).isEqualTo("# Weekly Coach Report\n" +
                "\n" +
                "## Performance Summary\n" +
                "- **Week Start**: 2023-10-09\n" +
                "- **Certification ID**: cert123\n" +
                "- **Sessions Count**: 5\n" +
                "- **Average Score**: 85.6%\n" +
                "- **Best Score**: 95.0%\n" +
                "- **Theme Stats**: []\n" +
                "\n" +
                "## Motivation\n" +
                "Keep up the good work!");

        verify(heavyModel, times(1)).generate(anyString());
        verify(promptRenderer, times(1)).render("weekly_coach_report", anyMap());
    }

    @DisplayName("should handle empty themeStats")
    @Test
    public void generate_report_emptyThemeStats() throws Exception {
        String weekStart = "2023-10-09";
        String certificationId = "cert123";
        int sessionsCount = 5;
        double averageScore = 85.6;
        double bestScore = 95.0;
        java.util.List<java.util.Map<String, Object>> themeStats = List.of();
        int cardsDueToday = 10;
        int cardsReviewed = 45;
        double averageEaseFactor = 2.5;

        when(heavyModel.generate(anyString())).thenReturn("# Weekly Coach Report\n" +
                "\n" +
                "## Performance Summary\n" +
                "- **Week Start**: 2023-10-09\n" +
                "- **Certification ID**: cert123\n" +
                "- **Sessions Count**: 5\n" +
                "- **Average Score**: 85.6%\n" +
                "- **Best Score**: 95.0%\n" +
                "- **Theme Stats**: []\n" +
                "\n" +
                "## Motivation\n" +
                "Keep up the good work!");

        String result = weeklyCoachReport.generate(weekStart, certificationId,
                sessionsCount, averageScore, bestScore, themeStats,
                cardsDueToday, cardsReviewed, averageEaseFactor);

        assertThat(result).isEqualTo("# Weekly Coach Report\n" +
                "\n" +
                "## Performance Summary\n" +
                "- **Week Start**: 2023-10-09\n" +
                "- **Certification ID**: cert123\n" +
                "- **Sessions Count**: 5\n" +
                "- **Average Score**: 85.6%\n" +
                "- **Best Score**: 95.0%\n" +
                "- **Theme Stats**: []\n" +
                "\n" +
                "## Motivation\n" +
                "Keep up the good work!");

        verify(heavyModel, times(1)).generate(anyString());
        verify(promptRenderer, times(1)).render("weekly_coach_report", anyMap());
    }

    @DisplayName("should handle null heavyModel")
    @Test
    public void generate_report_nullHeavyModel() {
        when(heavyModel.generate(anyString())).thenThrow(new RuntimeException("Mocked error"));

        String weekStart = "2023-10-09";
        String certificationId = "cert123";
        int sessionsCount = 5;
        double averageScore = 85.6;
        double bestScore = 95.0;
        java.util.List<java.util.Map<String, Object>> themeStats = List.of(
                Map.of("theme", "Mathematics", "score", 92),
                Map.of("theme", "English", "score", 88)
        );
        int cardsDueToday = 10;
        int cardsReviewed = 45;
        double averageEaseFactor = 2.5;

        String result = weeklyCoachReport.generate(weekStart, certificationId,
                sessionsCount, averageScore, bestScore, themeStats,
                cardsDueToday, cardsReviewed, averageEaseFactor);

        assertThat(result).isEqualTo("# Rapport hebdomadaire

Erreur lors de la génération du rapport. "
                + "Continuez vos révisions !");

        verify(heavyModel, times(1)).generate(anyString());
    }
}
