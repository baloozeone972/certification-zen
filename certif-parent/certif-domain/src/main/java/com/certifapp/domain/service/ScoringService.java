// certif-parent/certif-domain/src/main/java/com/certifapp/domain/service/ScoringService.java
package com.certifapp.domain.service;

import com.certifapp.domain.model.question.DifficultyLevel;
import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.session.DifficultyStats;
import com.certifapp.domain.model.session.ThemeStats;
import com.certifapp.domain.model.session.UserAnswer;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Pure domain service for exam scoring calculations.
 *
 * <p>No Spring, no JPA — this class is instantiable directly in unit tests.
 * All methods are stateless and operate on immutable Records.</p>
 *
 * <h2>Canonical scoring formula</h2>
 * <pre>
 *   percentage = correctCount * 100.0 / totalQuestions
 *   passed     = percentage >= certification.passingScore()
 * </pre>
 *
 * <p>Skipped questions (selectedOptionId = null) count as incorrect with no penalty.</p>
 */
public class ScoringService {

    /**
     * Evaluates all answers against the question corpus and computes the full score.
     *
     * @param answers        list of user answers for the session
     * @param questions      all questions drawn for the session (with options including isCorrect)
     * @param passingScore   minimum percentage to pass (e.g. 68 for OCP21)
     * @param totalQuestions total question count for percentage denominator
     * @return complete {@link ScoringResult}
     */
    public ScoringResult score(
            List<UserAnswer> answers,
            List<Question> questions,
            int passingScore,
            int totalQuestions) {

        Map<UUID, Question> questionMap = questions.stream()
                .collect(Collectors.toMap(Question::id, q -> q));

        // Evaluate correctness per answer
        List<UserAnswer> evaluated = answers.stream()
                .map(a -> evaluateAnswer(a, questionMap))
                .toList();

        long correctCount = evaluated.stream().filter(UserAnswer::isCorrect).count();
        double percentage = totalQuestions > 0
                ? (correctCount * 100.0) / totalQuestions
                : 0.0;
        boolean passed = percentage >= passingScore;

        List<ThemeStats> themeStats = calculateThemeStats(evaluated, questionMap);
        List<DifficultyStats> diffStats = calculateDifficultyStats(evaluated, questionMap);

        return new ScoringResult((int) correctCount, percentage, passed, themeStats, diffStats);
    }

    /**
     * Evaluates a single answer: checks if the selected option is correct.
     *
     * @param answer      the user answer to evaluate
     * @param questionMap map of question UUID to Question
     * @return a new {@link UserAnswer} with {@code isCorrect} set
     */
    public UserAnswer evaluateAnswer(UserAnswer answer, Map<UUID, Question> questionMap) {
        if (answer.isSkipped() || answer.selectedOptionId() == null) {
            return new UserAnswer(answer.id(), answer.sessionId(), answer.questionId(),
                    null, false, true, answer.responseTimeMs(), answer.answeredAt());
        }

        Question q = questionMap.get(answer.questionId());
        boolean correct = q != null && q.options().stream()
                .anyMatch(o -> answer.selectedOptionId().equals(o.id()) && o.isCorrect());

        return new UserAnswer(answer.id(), answer.sessionId(), answer.questionId(),
                answer.selectedOptionId(), correct, false,
                answer.responseTimeMs(), answer.answeredAt());
    }

    /**
     * Computes per-theme statistics from evaluated answers.
     *
     * @param evaluatedAnswers answers with {@code isCorrect} already set
     * @param questionMap      question lookup map
     * @return list of {@link ThemeStats} sorted by theme code
     */
    public List<ThemeStats> calculateThemeStats(
            List<UserAnswer> evaluatedAnswers,
            Map<UUID, Question> questionMap) {

        // Group answers by theme
        Map<String, int[]> themeCounters = new LinkedHashMap<>(); // [correct, wrong, skipped]

        for (UserAnswer answer : evaluatedAnswers) {
            Question q = questionMap.get(answer.questionId());
            if (q == null) continue;

            // Use themeId as string key — theme label resolved separately if needed
            String themeKey = q.themeId() != null ? q.themeId().toString() : "unknown";
            int[] counters = themeCounters.computeIfAbsent(themeKey, k -> new int[3]);

            if (answer.isSkipped()) {
                counters[2]++;
            } else if (answer.isCorrect()) {
                counters[0]++;
            } else {
                counters[1]++;
            }
        }

        return themeCounters.entrySet().stream()
                .map(e -> new ThemeStats(e.getKey(), e.getKey(),
                        e.getValue()[0], e.getValue()[1], e.getValue()[2]))
                .sorted(Comparator.comparing(ThemeStats::themeCode))
                .toList();
    }

    /**
     * Computes per-difficulty statistics from evaluated answers.
     * Skipped questions are excluded from this calculation.
     *
     * @param evaluatedAnswers answers with {@code isCorrect} already set
     * @param questionMap      question lookup map
     * @return list of {@link DifficultyStats} for each difficulty level present
     */
    public List<DifficultyStats> calculateDifficultyStats(
            List<UserAnswer> evaluatedAnswers,
            Map<UUID, Question> questionMap) {

        Map<DifficultyLevel, int[]> counters = new EnumMap<>(DifficultyLevel.class);
        for (DifficultyLevel d : DifficultyLevel.values()) {
            counters.put(d, new int[2]); // [correct, total]
        }

        for (UserAnswer answer : evaluatedAnswers) {
            if (answer.isSkipped()) continue;
            Question q = questionMap.get(answer.questionId());
            if (q == null) continue;

            int[] c = counters.get(q.difficulty());
            if (answer.isCorrect()) c[0]++;
            c[1]++;
        }

        return counters.entrySet().stream()
                .filter(e -> e.getValue()[1] > 0)
                .map(e -> new DifficultyStats(e.getKey(), e.getValue()[0], e.getValue()[1]))
                .sorted(Comparator.comparing(DifficultyStats::difficulty))
                .toList();
    }

    /**
     * Extracts wrong (answered incorrectly) questions from a session.
     *
     * @param evaluatedAnswers answers with {@code isCorrect} already set
     * @param questionMap      question lookup map
     * @return list of incorrectly answered questions (skipped excluded)
     */
    public List<Question> getWrongQuestions(
            List<UserAnswer> evaluatedAnswers,
            Map<UUID, Question> questionMap) {
        return evaluatedAnswers.stream()
                .filter(a -> !a.isSkipped() && !a.isCorrect())
                .map(a -> questionMap.get(a.questionId()))
                .filter(Objects::nonNull)
                .toList();
    }

    /**
     * Result of a scoring operation.
     *
     * @param correctCount number of correct answers
     * @param percentage   score percentage 0.0-100.0
     * @param passed       whether the passing threshold was met
     * @param themeStats   per-theme breakdown
     * @param diffStats    per-difficulty breakdown
     */
    public record ScoringResult(
            int correctCount,
            double percentage,
            boolean passed,
            List<ThemeStats> themeStats,
            List<DifficultyStats> diffStats
    ) {
    }
}
