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
 * Validates the SM-2 spaced repetition algorithm against the SuperMemo 2 specification.
 */
@DisplayName("SM2AlgorithmService")
class SM2AlgorithmServiceTest {

    private static final UUID USER_ID     = UUID.randomUUID();
    private static final UUID QUESTION_ID = UUID.randomUUID();

    private SM2AlgorithmService service;

    @BeforeEach
    void setUp() {
        service = new SM2AlgorithmService();
    }

    // ── initialSchedule() ────────────────────────────────────────────────────

    @Test
    @DisplayName("initialSchedule() → due today, EF=2.5, rep=0")
    void initialSchedule_shouldHaveCorrectDefaults() {
        SM2Schedule s = service.initialSchedule(USER_ID, QUESTION_ID);

        assertThat(s.userId()).isEqualTo(USER_ID);
        assertThat(s.questionId()).isEqualTo(QUESTION_ID);
        assertThat(s.easeFactor()).isEqualTo(SM2Schedule.DEFAULT_EASE_FACTOR);
        assertThat(s.repetitions()).isZero();
        assertThat(s.intervalDays()).isZero();
        assertThat(s.dueDate()).isEqualTo(LocalDate.now());
        assertThat(s.isDueToday()).isTrue();
    }

    // ── review() — correct answers (quality >= 3) ─────────────────────────────

    @Nested
    @DisplayName("Correct recall (quality >= 3)")
    class CorrectAnswers {

        @Test
        @DisplayName("First review → interval=1, rep=1")
        void firstCorrect_shouldSetInterval1() {
            SM2Schedule result = service.review(SM2Schedule.initial(USER_ID, QUESTION_ID), 4);
            assertThat(result.repetitions()).isEqualTo(1);
            assertThat(result.intervalDays()).isEqualTo(1);
            assertThat(result.dueDate()).isEqualTo(LocalDate.now().plusDays(1));
        }

        @Test
        @DisplayName("Second review → interval=6, rep=2")
        void secondCorrect_shouldSetInterval6() {
            SM2Schedule after1 = service.review(SM2Schedule.initial(USER_ID, QUESTION_ID), 4);
            SM2Schedule result = service.review(after1, 4);
            assertThat(result.repetitions()).isEqualTo(2);
            assertThat(result.intervalDays()).isEqualTo(6);
        }

        @Test
        @DisplayName("Third review → interval = round(prev * EF)")
        void thirdCorrect_shouldUseEaseFactor() {
            SM2Schedule after1 = service.review(SM2Schedule.initial(USER_ID, QUESTION_ID), 4);
            SM2Schedule after2 = service.review(after1, 4);
            SM2Schedule result = service.review(after2, 4);
            int expected = (int) Math.round(6 * after2.easeFactor());
            assertThat(result.intervalDays()).isEqualTo(expected);
            assertThat(result.repetitions()).isEqualTo(3);
        }

        @Test
        @DisplayName("Quality=5 → ease factor increases")
        void perfect_shouldIncreaseEF() {
            SM2Schedule initial = SM2Schedule.initial(USER_ID, QUESTION_ID);
            SM2Schedule result  = service.review(initial, 5);
            assertThat(result.easeFactor()).isGreaterThan(SM2Schedule.DEFAULT_EASE_FACTOR);
        }

        @Test
        @DisplayName("Quality=4 → ease factor unchanged (≈ 2.5)")
        void rating4_shouldKeepEF() {
            SM2Schedule after1 = service.review(SM2Schedule.initial(USER_ID, QUESTION_ID), 4);
            SM2Schedule after2 = service.review(after1, 4);
            SM2Schedule result = service.review(after2, 4);
            assertThat(result.easeFactor()).isEqualTo(2.5, within(0.001));
        }

        @Test
        @DisplayName("Quality=3 → ease factor decreases but stays >= 1.3")
        void hardCorrect_shouldDecreaseEFAboveMin() {
            SM2Schedule after1 = service.review(SM2Schedule.initial(USER_ID, QUESTION_ID), 4);
            SM2Schedule after2 = service.review(after1, 4);
            SM2Schedule result = service.review(after2, 3);
            assertThat(result.easeFactor())
                .isLessThan(SM2Schedule.DEFAULT_EASE_FACTOR)
                .isGreaterThanOrEqualTo(SM2Schedule.MIN_EASE_FACTOR);
        }
    }

    // ── review() — incorrect (quality < 3) ───────────────────────────────────

    @Nested
    @DisplayName("Incorrect recall (quality < 3)")
    class IncorrectAnswers {

        @ParameterizedTest(name = "quality={0} → reset interval=1, rep=0")
        @ValueSource(ints = {0, 1, 2})
        @DisplayName("Any failing rating → reset")
        void failingQuality_shouldResetSchedule(int quality) {
            // Build up to rep=3 first
            SM2Schedule s = SM2Schedule.initial(USER_ID, QUESTION_ID);
            s = service.review(s, 4);
            s = service.review(s, 4);
            s = service.review(s, 4);

            SM2Schedule result = service.review(s, quality);

            assertThat(result.repetitions()).isZero();
            assertThat(result.intervalDays()).isEqualTo(1);
            assertThat(result.dueDate()).isEqualTo(LocalDate.now().plusDays(1));
        }

        @Test
        @DisplayName("Failure → ease factor unchanged (per SM-2 spec)")
        void failure_shouldNotChangeEF() {
            SM2Schedule s = SM2Schedule.initial(USER_ID, QUESTION_ID);
            s = service.review(s, 4); // rep=1, EF slightly changed
            double efBefore = s.easeFactor();

            SM2Schedule result = service.review(s, 1);

            assertThat(result.easeFactor()).isEqualTo(efBefore, within(0.001));
        }
    }

    // ── ease factor floor ─────────────────────────────────────────────────────

    @Test
    @DisplayName("Repeated quality=3 → EF never drops below 1.3")
    void repeatedHard_efNeverBelowFloor() {
        SM2Schedule s = SM2Schedule.initial(USER_ID, QUESTION_ID);
        for (int i = 0; i < 30; i++) {
            s = service.review(s, 3);
        }
        assertThat(s.easeFactor()).isGreaterThanOrEqualTo(SM2Schedule.MIN_EASE_FACTOR);
    }

    // ── invalid quality ───────────────────────────────────────────────────────

    @ParameterizedTest(name = "quality={0} → IllegalArgumentException")
    @ValueSource(ints = {-1, 6, 100})
    @DisplayName("Out-of-range quality → IllegalArgumentException")
    void invalidQuality_shouldThrow(int quality) {
        SM2Schedule s = SM2Schedule.initial(USER_ID, QUESTION_ID);
        assertThatThrownBy(() -> service.review(s, quality))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessageContaining("0-5");
    }

    // ── computeNewEaseFactor() ────────────────────────────────────────────────

    @Test
    @DisplayName("computeNewEaseFactor(2.5, 5) → EF increases")
    void computeEF_perfect_shouldIncrease() {
        double result = service.computeNewEaseFactor(2.5, 5);
        assertThat(result).isGreaterThan(2.5);
    }

    @Test
    @DisplayName("computeNewEaseFactor at floor → never goes below 1.3")
    void computeEF_atFloor_shouldClamp() {
        double result = service.computeNewEaseFactor(1.3, 3);
        assertThat(result).isGreaterThanOrEqualTo(SM2Schedule.MIN_EASE_FACTOR);
    }
}
