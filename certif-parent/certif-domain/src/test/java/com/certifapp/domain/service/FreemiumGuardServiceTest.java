package com.certifapp.domain.service;

import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.model.user.SubscriptionTier;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class FreemiumGuardServiceTest {

    @Test
    @DisplayName("checkDailyExamLimit_freeTierDailyLimitNotExceeded")
    public void checkDailyExamLimit_freeTierDailyLimitNotExceeded() throws FreemiumLimitExceededException {
        // Arrange
        var freemiumGuardService = new FreemiumGuardService();

        // Act
        freemiumGuardService.checkDailyExamLimit(SubscriptionTier.FREE, Certification.FREE_DAILY_EXAM_LIMIT - 1);

        // Assert
    }

    @Test
    @DisplayName("checkDailyExamLimit_proTierNoException")
    public void checkDailyExamLimit_proTierNoException() throws FreemiumLimitExceededException {
        // Arrange
        var freemiumGuardService = new FreemiumGuardService();

        // Act
        freemiumGuardService.checkDailyExamLimit(SubscriptionTier.PRO, Certification.FREE_DAILY_EXAM_LIMIT - 1);

        // Assert
    }

    @Test
    @DisplayName("checkDailyExamLimit_freeTierDailyLimitExceeded")
    public void checkDailyExamLimit_freeTierDailyLimitExceeded() {
        // Arrange
        var freemiumGuardService = new FreemiumGuardService();

        // Act & Assert
        assertThatThrownBy(() -> freemiumGuardService.checkDailyExamLimit(SubscriptionTier.FREE, Certification.FREE_DAILY_EXAM_LIMIT))
                .isInstanceOf(FreemiumLimitExceededException.class)
                .hasMessage("daily exams");
    }

    @Test
    @DisplayName("effectiveQuestionCount_freeTierRequestWithinLimit")
    public void effectiveQuestionCount_freeTierRequestWithinLimit() {
        // Arrange
        var freemiumGuardService = new FreemiumGuardService();

        // Act & Assert
        assertThat(freemiumGuardService.effectiveQuestionCount(SubscriptionTier.FREE, Certification.FREE_QUESTION_LIMIT + 1))
                .isEqualTo(Certification.FREE_QUESTION_LIMIT);
    }

    @Test
    @DisplayName("effectiveQuestionCount_proTierNoCapping")
    public void effectiveQuestionCount_proTierNoCapping() {
        // Arrange
        var freemiumGuardService = new FreemiumGuardService();

        // Act & Assert
        assertThat(freemiumGuardService.effectiveQuestionCount(SubscriptionTier.PRO, Certification.FREE_QUESTION_LIMIT + 1))
                .isEqualTo(Certification.FREE_QUESTION_LIMIT + 1);
    }

    @Test
    @DisplayName("requirePro_freeTierException")
    public void requirePro_freeTierException() {
        // Arrange
        var freemiumGuardService = new FreemiumGuardService();

        // Act & Assert
        assertThatThrownBy(() -> freemiumGuardService.requirePro(SubscriptionTier.FREE, "AI feature"))
                .isInstanceOf(SubscriptionRequiredException.class)
                .hasMessage("AI feature");
    }

    @Test
    @DisplayName("requirePro_proTierNoException")
    public void requirePro_proTierNoException() {
        // Arrange
        var freemiumGuardService = new FreemiumGuardService();

        // Act
        freemiumGuardService.requirePro(SubscriptionTier.PRO, "AI feature");

        // Assert
    }

    @Test
    @DisplayName("requireUnlimited_freeTierException")
    public void requireUnlimited_freeTierException() {
        // Arrange
        var freemiumGuardService = new FreemiumGuardService();

        // Act & Assert
        assertThatThrownBy(() -> freemiumGuardService.requireUnlimited(SubscriptionTier.FREE, "Unlimited access"))
                .isInstanceOf(SubscriptionRequiredException.class)
                .hasMessage("Unlimited access");
    }

    @Test
    @DisplayName("requireUnlimited_proOrPackTierNoException")
    public void requireUnlimited_proOrPackTierNoException() {
        // Arrange
        var freemiumGuardService = new FreemiumGuardService();

        // Act
        freemiumGuardService.requireUnlimited(SubscriptionTier.PRO, "Unlimited access");
        freemiumGuardService.requireUnlimited(SubscriptionTier.PACK, "Unlimited access");

        // Assert
    }
}