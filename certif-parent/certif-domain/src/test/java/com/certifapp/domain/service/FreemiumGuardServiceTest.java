// certif-parent/certif-domain/src/test/java/com/certifapp/domain/service/FreemiumGuardServiceTest.java
package com.certifapp.domain.service;

import com.certifapp.domain.exception.FreemiumLimitExceededException;
import com.certifapp.domain.exception.SubscriptionRequiredException;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.model.user.SubscriptionTier;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.*;

/**
 * Unit tests for {@link FreemiumGuardService}.
 */
@DisplayName("FreemiumGuardService")
class FreemiumGuardServiceTest {

    private FreemiumGuardService service;

    @BeforeEach
    void setUp() {
        service = new FreemiumGuardService();
    }

    // ── checkDailyExamLimit ───────────────────────────────────────────────────

    @Nested
    @DisplayName("checkDailyExamLimit()")
    class CheckDailyExamLimit {

        @Test
        @DisplayName("FREE under limit → no exception")
        void freeBelowLimit_shouldNotThrow() {
            assertThatCode(() ->
                    service.checkDailyExamLimit(SubscriptionTier.FREE, Certification.FREE_DAILY_EXAM_LIMIT - 1)
            ).doesNotThrowAnyException();
        }

        @Test
        @DisplayName("FREE at limit → FreemiumLimitExceededException")
        void freeAtLimit_shouldThrow() {
            assertThatThrownBy(() ->
                    service.checkDailyExamLimit(SubscriptionTier.FREE, Certification.FREE_DAILY_EXAM_LIMIT)
            ).isInstanceOf(FreemiumLimitExceededException.class);
        }

        @Test
        @DisplayName("FREE over limit → FreemiumLimitExceededException")
        void freeOverLimit_shouldThrow() {
            assertThatThrownBy(() ->
                    service.checkDailyExamLimit(SubscriptionTier.FREE, Certification.FREE_DAILY_EXAM_LIMIT + 5)
            ).isInstanceOf(FreemiumLimitExceededException.class);
        }

        @Test
        @DisplayName("PRO at limit → no exception")
        void proAtLimit_shouldNotThrow() {
            assertThatCode(() ->
                    service.checkDailyExamLimit(SubscriptionTier.PRO, Certification.FREE_DAILY_EXAM_LIMIT)
            ).doesNotThrowAnyException();
        }

        @Test
        @DisplayName("PACK at limit → no exception")
        void packAtLimit_shouldNotThrow() {
            assertThatCode(() ->
                    service.checkDailyExamLimit(SubscriptionTier.PACK, Certification.FREE_DAILY_EXAM_LIMIT)
            ).doesNotThrowAnyException();
        }
    }

    // ── effectiveQuestionCount ────────────────────────────────────────────────

    @Nested
    @DisplayName("effectiveQuestionCount()")
    class EffectiveQuestionCount {

        @Test
        @DisplayName("FREE requests more than limit → capped at limit")
        void freeTierOverLimit_shouldCap() {
            int result = service.effectiveQuestionCount(SubscriptionTier.FREE, Certification.FREE_QUESTION_LIMIT + 10);
            assertThat(result).isEqualTo(Certification.FREE_QUESTION_LIMIT);
        }

        @Test
        @DisplayName("FREE requests less than limit → not capped")
        void freeTierUnderLimit_shouldNotCap() {
            int result = service.effectiveQuestionCount(SubscriptionTier.FREE, 5);
            assertThat(result).isEqualTo(5);
        }

        @Test
        @DisplayName("PRO no capping")
        void proTier_shouldNotCap() {
            int requested = Certification.FREE_QUESTION_LIMIT + 10;
            assertThat(service.effectiveQuestionCount(SubscriptionTier.PRO, requested)).isEqualTo(requested);
        }

        @Test
        @DisplayName("PACK no capping")
        void packTier_shouldNotCap() {
            int requested = Certification.FREE_QUESTION_LIMIT + 10;
            assertThat(service.effectiveQuestionCount(SubscriptionTier.PACK, requested)).isEqualTo(requested);
        }
    }

    // ── requirePro ───────────────────────────────────────────────────────────

    @Nested
    @DisplayName("requirePro()")
    class RequirePro {

        @Test
        @DisplayName("PRO → no exception")
        void pro_shouldNotThrow() {
            assertThatCode(() -> service.requirePro(SubscriptionTier.PRO, "AI feature"))
                    .doesNotThrowAnyException();
        }

        @Test
        @DisplayName("FREE → SubscriptionRequiredException")
        void free_shouldThrow() {
            assertThatThrownBy(() -> service.requirePro(SubscriptionTier.FREE, "AI feature"))
                    .isInstanceOf(SubscriptionRequiredException.class);
        }

        @Test
        @DisplayName("PACK → SubscriptionRequiredException (AI is PRO-only)")
        void pack_shouldThrow() {
            assertThatThrownBy(() -> service.requirePro(SubscriptionTier.PACK, "AI feature"))
                    .isInstanceOf(SubscriptionRequiredException.class);
        }
    }

    // ── requireUnlimited ─────────────────────────────────────────────────────

    @Nested
    @DisplayName("requireUnlimited()")
    class RequireUnlimited {

        @Test
        @DisplayName("FREE → SubscriptionRequiredException")
        void free_shouldThrow() {
            assertThatThrownBy(() -> service.requireUnlimited(SubscriptionTier.FREE, "Unlimited"))
                    .isInstanceOf(SubscriptionRequiredException.class);
        }

        @Test
        @DisplayName("PRO → no exception")
        void pro_shouldNotThrow() {
            assertThatCode(() -> service.requireUnlimited(SubscriptionTier.PRO, "Unlimited"))
                    .doesNotThrowAnyException();
        }

        @Test
        @DisplayName("PACK → no exception")
        void pack_shouldNotThrow() {
            assertThatCode(() -> service.requireUnlimited(SubscriptionTier.PACK, "Unlimited"))
                    .doesNotThrowAnyException();
        }
    }
}
