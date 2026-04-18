// certif-parent/certif-domain/src/test/java/com/certifapp/domain/service/ScoringServiceTest.java
package com.certifapp.domain.service;

import java.util.UUID;

import com.certifapp.domain.model.question.*;
import com.certifapp.domain.model.session.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.util.*;

import static org.assertj.core.api.Assertions.*;

/**
 * Unit tests for {@link ScoringService}.
 *
 * <p>Uses the AAA pattern (Arrange / Act / Assert).
 * No Spring context — pure domain logic only.</p>
 */
@DisplayName("ScoringService")
class ScoringServiceTest {

    private ScoringService scoringService;

    // Fixed UUIDs for reproducible tests
    private static final UUID Q1  = UUID.fromString("00000000-0000-0000-0000-000000000001");
    private static final UUID Q2  = UUID.fromString("00000000-0000-0000-0000-000000000002");
    private static final UUID Q3  = UUID.fromString("00000000-0000-0000-0000-000000000003");
    private static final UUID O1A = UUID.fromString("00000000-0000-0000-0001-000000000001"); // correct
    private static final UUID O1B = UUID.fromString("00000000-0000-0000-0001-000000000002");
    private static final UUID O2A = UUID.fromString("00000000-0000-0000-0002-000000000001"); // correct
    private static final UUID O2B = UUID.fromString("00000000-0000-0000-0002-000000000002");
    private static final UUID O3A = UUID.fromString("00000000-0000-0000-0003-000000000001"); // correct
    private static final UUID O3B = UUID.fromString("00000000-0000-0000-0003-000000000002");

    private static final UUID THEME_ID   = UUID.randomUUID();
    private static final UUID SESSION_ID = UUID.randomUUID();
    private static final UUID USER_ID    = UUID.randomUUID();

    private List<Question> questions;

    @BeforeEach
    void setUp() {
        scoringService = new ScoringService();

        questions = List.of(
            buildQuestion(Q1, "What is Java?", DifficultyLevel.EASY,
                "virtual_threads", THEME_ID,
                List.of(
                    new QuestionOption(O1A, Q1, 'A', "A programming language", true,  0),
                    new QuestionOption(O1B, Q1, 'B', "A coffee brand",         false, 1)
                )),
            buildQuestion(Q2, "What is JVM?", DifficultyLevel.MEDIUM,
                "virtual_threads", THEME_ID,
                List.of(
                    new QuestionOption(O2A, Q2, 'A', "Java Virtual Machine", true,  0),
                    new QuestionOption(O2B, Q2, 'B', "Java Version Manager",  false, 1)
                )),
            buildQuestion(Q3, "What is GC?", DifficultyLevel.HARD,
                "pattern_matching", UUID.randomUUID(),
                List.of(
                    new QuestionOption(O3A, Q3, 'A', "Garbage Collector", true,  0),
                    new QuestionOption(O3B, Q3, 'B', "Global Context",    false, 1)
                ))
        );
    }

    // ─── score() ────────────────────────────────────────────────────────────

    @Nested
    @DisplayName("score()")
    class ScoreTests {

        @Test
        @DisplayName("3 correct answers out of 3 → 100%, passed")
        void allCorrect_shouldReturn100Percent() {
            // Arrange
            List<UserAnswer> answers = List.of(
                answered(SESSION_ID, Q1, O1A),
                answered(SESSION_ID, Q2, O2A),
                answered(SESSION_ID, Q3, O3A)
            );

            // Act
            ScoringService.ScoringResult result = scoringService.score(answers, questions, 68, 3);

            // Assert
            assertThat(result.correctCount()).isEqualTo(3);
            assertThat(result.percentage()).isEqualTo(100.0);
            assertThat(result.passed()).isTrue();
        }

        @Test
        @DisplayName("0 correct answers → 0%, not passed")
        void noneCorrect_shouldReturn0Percent() {
            List<UserAnswer> answers = List.of(
                answered(SESSION_ID, Q1, O1B),
                answered(SESSION_ID, Q2, O2B),
                answered(SESSION_ID, Q3, O3B)
            );

            ScoringService.ScoringResult result = scoringService.score(answers, questions, 68, 3);

            assertThat(result.correctCount()).isEqualTo(0);
            assertThat(result.percentage()).isEqualTo(0.0);
            assertThat(result.passed()).isFalse();
        }

        @Test
        @DisplayName("2 correct out of 3 (66.7%) with passing score 68% → not passed")
        void twoOutOfThreeBelow68_shouldNotPass() {
            List<UserAnswer> answers = List.of(
                answered(SESSION_ID, Q1, O1A),
                answered(SESSION_ID, Q2, O2A),
                answered(SESSION_ID, Q3, O3B)
            );

            ScoringService.ScoringResult result = scoringService.score(answers, questions, 68, 3);

            assertThat(result.correctCount()).isEqualTo(2);
            assertThat(result.percentage()).isCloseTo(66.67, within(0.01));
            assertThat(result.passed()).isFalse();
        }

        @Test
        @DisplayName("Skipped questions count as incorrect, no penalty")
        void skippedQuestion_countsAsIncorrect() {
            List<UserAnswer> answers = List.of(
                answered(SESSION_ID, Q1, O1A),
                UserAnswer.skipped(SESSION_ID, Q2),
                UserAnswer.skipped(SESSION_ID, Q3)
            );

            ScoringService.ScoringResult result = scoringService.score(answers, questions, 68, 3);

            assertThat(result.correctCount()).isEqualTo(1);
            assertThat(result.percentage()).isCloseTo(33.33, within(0.01));
            assertThat(result.passed()).isFalse();
        }

        @Test
        @DisplayName("Passing exactly at threshold (68/100) → passed")
        void exactlyAtThreshold_shouldPass() {
            // 68 correct out of 100 = 68.0%
            ScoringService.ScoringResult result =
                scoringService.score(List.of(), List.of(), 68, 100);

            // 0 correct out of 100 = 0% — used here just to test the boundary
            // Build a scenario with 68 correct
            List<UserAnswer> answers = buildNAnswers(SESSION_ID, Q1, O1A, O1B, 68, 32);
            List<Question> qs = Collections.nCopies(100,
                buildQuestion(Q1, "Q", DifficultyLevel.EASY, "t", THEME_ID,
                    List.of(new QuestionOption(O1A, Q1, 'A', "Correct", true, 0),
                            new QuestionOption(O1B, Q1, 'B', "Wrong",   false, 1))));

            result = scoringService.score(answers, qs, 68, 100);

            assertThat(result.percentage()).isEqualTo(68.0);
            assertThat(result.passed()).isTrue();
        }

        @Test
        @DisplayName("totalQuestions = 0 → percentage = 0.0, no exception")
        void zeroTotalQuestions_shouldReturn0() {
            ScoringService.ScoringResult result =
                scoringService.score(List.of(), List.of(), 68, 0);

            assertThat(result.percentage()).isEqualTo(0.0);
            assertThat(result.passed()).isFalse();
        }
    }

    // ─── calculateThemeStats() ───────────────────────────────────────────────

    @Nested
    @DisplayName("calculateThemeStats()")
    class ThemeStatsTests {

        @Test
        @DisplayName("Returns correct counts grouped by theme")
        void shouldGroupByTheme() {
            List<UserAnswer> answers = List.of(
                answered(SESSION_ID, Q1, O1A), // correct, theme = virtual_threads
                answered(SESSION_ID, Q2, O2B), // wrong,   theme = virtual_threads
                UserAnswer.skipped(SESSION_ID, Q3) // skipped, theme = pattern_matching
            );

            Map<UUID, Question> questionMap = questions.stream()
                .collect(java.util.stream.Collectors.toMap(Question::id, q -> q));

            List<ThemeStats> stats =
                scoringService.calculateThemeStats(answers, questionMap);

            assertThat(stats).hasSize(2);
            ThemeStats vt = stats.stream()
                .filter(s -> s.themeCode().equals(THEME_ID.toString()))
                .findFirst().orElseThrow();
            assertThat(vt.correct()).isEqualTo(1);
            assertThat(vt.wrong()).isEqualTo(1);
            assertThat(vt.skipped()).isEqualTo(0);
            assertThat(vt.total()).isEqualTo(2);
        }

        @Test
        @DisplayName("percentage() returns 0.0 when total is 0")
        void emptyTheme_percentageIsZero() {
            ThemeStats empty = new ThemeStats("t", "Theme", 0, 0, 0);
            assertThat(empty.percentage()).isEqualTo(0.0);
        }

        @Test
        @DisplayName("percentage() computes correctly for known values")
        void percentageComputation() {
            ThemeStats stats = new ThemeStats("t", "Theme", 3, 1, 0);
            assertThat(stats.total()).isEqualTo(4);
            assertThat(stats.percentage()).isEqualTo(75.0);
        }
    }

    // ─── getWrongQuestions() ─────────────────────────────────────────────────

    @Nested
    @DisplayName("getWrongQuestions()")
    class WrongQuestionsTests {

        @Test
        @DisplayName("Returns only incorrectly answered questions, not skipped")
        void shouldExcludeSkipped() {
            List<UserAnswer> answers = List.of(
                answered(SESSION_ID, Q1, O1A), // correct
                answered(SESSION_ID, Q2, O2B), // wrong
                UserAnswer.skipped(SESSION_ID, Q3) // skipped
            );

            Map<UUID, Question> qMap = questions.stream()
                .collect(java.util.stream.Collectors.toMap(Question::id, q -> q));

            // Evaluate first
            List<UserAnswer> evaluated = answers.stream()
                .map(a -> scoringService.evaluateAnswer(a, qMap))
                .toList();

            List<Question> wrong = scoringService.getWrongQuestions(evaluated, qMap);

            assertThat(wrong).hasSize(1);
            assertThat(wrong.get(0).id()).isEqualTo(Q2);
        }
    }

    // ─── Helpers ─────────────────────────────────────────────────────────────

    private static UserAnswer answered(UUID sessionId, UUID questionId, UUID optionId) {
        return UserAnswer.answered(sessionId, questionId, optionId, 1000L);
    }

    private static Question buildQuestion(UUID id, String stmt, DifficultyLevel diff,
                                          String themeCode, UUID themeId,
                                          List<QuestionOption> opts) {
        return new Question(id, "L-" + id, "ocp21", themeId, stmt,
                diff, QuestionType.SINGLE_CHOICE, opts,
                "Explanation", null, ExplanationStatus.ORIGINAL,
                null, null, null, true, null);
    }

    private static List<UserAnswer> buildNAnswers(
            UUID sessionId, UUID questionId,
            UUID correctOpt, UUID wrongOpt,
            int nCorrect, int nWrong) {
        List<UserAnswer> list = new ArrayList<>();
        for (int i = 0; i < nCorrect; i++)
            list.add(UserAnswer.answered(sessionId, questionId, correctOpt, 1000L));
        for (int i = 0; i < nWrong; i++)
            list.add(UserAnswer.answered(sessionId, questionId, wrongOpt, 1000L));
        return list;
    }
}
