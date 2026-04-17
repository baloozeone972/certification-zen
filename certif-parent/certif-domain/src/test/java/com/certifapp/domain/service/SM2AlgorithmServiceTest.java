// certif-parent/certif-domain/src/test/java/com/certifapp/domain/service/SM2AlgorithmServiceTest.java
package com.certifapp.domain.service;

import com.certifapp.domain.model.learning.SM2Schedule;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import java.time.LocalDate;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;

/**
 * Unit tests for {@link SM2AlgorithmService}.
 *
 * <p>Validates the SM-2 algorithm implementation against the original specification.</p>
 */
@DisplayName("SM2AlgorithmService")
class SM2AlgorithmServiceTest {

    private static final UUID USER_ID = UUID.randomUUID();
    private static final UUID QUESTION_ID = UUID.randomUUID();
    private SM2AlgorithmService sm2Service;

    @BeforeEach
    void setUp() {
        sm2Service = new SM2AlgorithmService();
    }

    // ─── review() ────────────────────────────────────────────────────────────

    @Test
    @DisplayName("initialSchedule() creates due today with default EF=2.5 and rep=0")
    void initialSchedule_shouldHaveCorrectDefaults() {
        SM2Schedule schedule = sm2Service.initialSchedule(USER_ID, QUESTION_ID);

        assertThat(schedule.userId()).isEqualTo(USER_ID);
        assertThat(schedule.questionId()).isEqualTo(QUESTION_ID);
        assertThat(schedule.easeFactor()).isEqualTo(SM2Schedule.DEFAULT_EASE_FACTOR);
        assertThat(schedule.repetitions()).isEqualTo(0);
        assertThat(schedule.intervalDays()).isEqualTo(0);
        assertThat(schedule.dueDate()).isEqualTo(LocalDate.now());
        assertThat(schedule.isDueToday()).isTrue();
    }

    @Nested
    @DisplayName("review() — correct answers (quality >= 3)")
    class CorrectAnswerTests {

        @Test
        @DisplayName("First correct review (rep=0) → interval=1, rep=1")
        void firstCorrectReview_shouldSetInterval1() {
            SM2Schedule initial = SM2Schedule.initial(USER_ID, QUESTION_ID);

            SM2Schedule result = sm2Service.review(initial, 4);

            assertThat(result.repetitions()).isEqualTo(1);
            assertThat(result.intervalDays()).isEqualTo(1);
            assertThat(result.dueDate()).isEqualTo(LocalDate.now().plusDays(1));
        }

        @Test
        @DisplayName("Second correct review (rep=1) → interval=6, rep=2")
        void secondCorrectReview_shouldSetInterval6() {
            SM2Schedule after1 = sm2Service.review(SM2Schedule.initial(USER_ID, QUESTION_ID), 4);

            SM2Schedule result = sm2Service.review(after1, 4);

            assertThat(result.repetitions()).isEqualTo(2);
            assertThat(result.intervalDays()).isEqualTo(6);
        }

        @Test
        @DisplayName("Third correct review (rep=2) → interval = round(prev * EF)")
        void thirdCorrectReview_shouldUseEaseFactor() {
            SM2Schedule after1 = sm2Service.review(SM2Schedule.initial(USER_ID, QUESTION_ID), 4);
            SM2Schedule after2 = sm2Service.review(after1, 4);

            SM2Schedule result = sm2Service.review(after2, 4);

            int expected = (int) Math.round(6 * after2.easeFactor());
            assertThat(result.intervalDays()).isEqualTo(expected);
            assertThat(result.repetitions()).isEqualTo(3);
        }

        @Test
        @DisplayName("Quality=5 (perfect) increases ease factor")
        void perfectQuality_shouldIncreaseEaseFactor() {
            SM2Schedule initial = SM2Schedule.initial(USER_ID, QUESTION_ID);
            double initialEf = initial.easeFactor();

            SM2Schedule result = sm2Service.review(initial, 5);

            assertThat(result.easeFactor()).isGreaterThan(initialEf);
        }

        @Test
        @DisplayName("Quality=3 (hard correct) decreases ease factor but stays >= 1.3")
        void hardCorrect_shouldDecreaseEaseFactorAboveMinimum() {
            SM2Schedule initial = SM2Schedule.initial(USER_ID, QUESTION_ID);

            SM2Schedule result = sm2Service.review(initial, 3);

            assertThat(result.easeFactor()).isLessThan(initial.easeFactor());
            assertThat(result.easeFactor()).isGreaterThanOrEqualTo(SM2Schedule.MIN_EASE_FACTOR);
        }
    }

    @Nested
    @DisplayName("review() — incorrect answers (quality < 3)")
    class IncorrectAnswerTests {

        @ParameterizedTest(name = "quality={0} resets repetitions to 0")
        @ValueSource(ints = {0, 1, 2})
        @DisplayName("Incorrect reviews reset repetitions and interval to 1")
        void incorrectReview_shouldResetRepetitions(int quality) {
            // Build a schedule with some history
            SM2Schedule withHistory = sm2Service.review(SM2Schedule.initial(USER_ID, QUESTION_ID), 4);
            withHistory = sm2Service.review(withHistory, 4); // rep=2, interval=6

            SM2Schedule result = sm2Service.review(withHistory, quality);

            assertThat(result.repetitions()).isEqualTo(0);
            assertThat(result.intervalDays()).isEqualTo(1);
            assertThat(result.dueDate()).isEqualTo(LocalDate.now().plusDays(1));
        }

        @Test
        @DisplayName("Incorrect review does NOT change ease factor (per SM-2 spec)")
        void incorrectReview_shouldNotChangeEaseFactor() {
            SM2Schedule initial = SM2Schedule.initial(USER_ID, QUESTION_ID);

            SM2Schedule result = sm2Service.review(initial, 1);

            assertThat(result.easeFactor()).isEqualTo(initial.easeFactor());
        }
    }

    // ─── computeNewEaseFactor() ───────────────────────────────────────────────

    @Nested
    @DisplayName("review() — edge cases")
    class EdgeCaseTests {

        @Test
        @DisplayName("Invalid quality (6) throws IllegalArgumentException")
        void invalidQuality_shouldThrow() {
            SM2Schedule initial = SM2Schedule.initial(USER_ID, QUESTION_ID);

            assertThatThrownBy(() -> sm2Service.review(initial, 6))
                    .isInstanceOf(IllegalArgumentException.class)
                    .hasMessageContaining("SM-2 quality must be 0-5");
        }

        @Test
        @DisplayName("Invalid quality (-1) throws IllegalArgumentException")
        void negativeQuality_shouldThrow() {
            SM2Schedule initial = SM2Schedule.initial(USER_ID, QUESTION_ID);

            assertThatThrownBy(() -> sm2Service.review(initial, -1))
                    .isInstanceOf(IllegalArgumentException.class);
        }

        @Test
        @DisplayName("EF never drops below 1.3 after many hard reviews")
        void repeatedHardReviews_shouldNotDropBelow1_3() {
            SM2Schedule schedule = SM2Schedule.initial(USER_ID, QUESTION_ID);

            for (int i = 0; i < 20; i++) {
                schedule = sm2Service.review(schedule, 3);
            }

            assertThat(schedule.easeFactor()).isGreaterThanOrEqualTo(SM2Schedule.MIN_EASE_FACTOR);
        }

        @Test
        @DisplayName("Due date is set correctly to today + interval days")
        void dueDate_shouldBeCorrectlyComputed() {
            SM2Schedule initial = SM2Schedule.initial(USER_ID, QUESTION_ID);

            SM2Schedule result = sm2Service.review(initial, 4);

            assertThat(result.dueDate())
                    .isEqualTo(LocalDate.now().plusDays(result.intervalDays()));
        }
    }

    // ─── initialSchedule() ───────────────────────────────────────────────────

    @Nested
    @DisplayName("computeNewEaseFactor()")
    class EaseFactorTests {

        @Test
        @DisplayName("Quality=5 formula: EF + 0.1 - 0*(0.08+0*0.02) = EF + 0.1")
        void quality5_shouldIncreaseBy01() {
            double result = sm2Service.computeNewEaseFactor(2.5, 5);
            assertThat(result).isCloseTo(2.6, within(0.001));
        }

        @Test
        @DisplayName("Quality=4 formula: EF + 0.1 - 1*(0.10) = EF")
        void quality4_shouldKeepEFUnchanged() {
            double result = sm2Service.computeNewEaseFactor(2.5, 4);
            assertThat(result).isCloseTo(2.5, within(0.001));
        }

        @Test
        @DisplayName("Quality=3 formula: EF - 0.14")
        void quality3_shouldDecreaseEF() {
            double result = sm2Service.computeNewEaseFactor(2.5, 3);
            assertThat(result).isCloseTo(2.36, within(0.001));
        }
    }
}
