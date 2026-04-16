package com.certifapp.domain.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.util.function.Consumer;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class FreemiumGuardServiceTest {

    @Mock
    private SubscriptionTier tierMock;

    @InjectMocks
    private FreemiumGuardService freemiumGuardService;

    @BeforeEach
    public void setUp() {
        when(tierMock.hasAiFeatures()).thenReturn(true);
        when(tierMock.isUnlimited()).thenReturn(false);
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(tierMock);
    }

    @Test
    @DisplayName("checkDailyExamLimit_freeTierDailyLimitNotExceeded")
    public void checkDailyExamLimit_freeTierDailyLimitNotExceeded() throws FreemiumLimitExceededException {
        freemiumGuardService.checkDailyExamLimit(SubscriptionTier.FREE, Certification.FREE_DAILY_EXAM_LIMIT - 1);
    }

    @Test
    @DisplayName("checkDailyExamLimit_proTierNoException")
    public void checkDailyExamLimit_proTierNoException() throws FreemiumLimitExceededException {
        freemiumGuardService.checkDailyExamLimit(SubscriptionTier.PRO, Certification.FREE_DAILY_EXAM_LIMIT - 1);
    }

    @Test
    @DisplayName("checkDailyExamLimit_freeTierDailyLimitExceeded")
    public void checkDailyExamLimit_freeTierDailyLimitExceeded() {
        assertThatThrownBy(() -> freemiumGuardService.checkDailyExamLimit(SubscriptionTier.FREE, Certification.FREE_DAILY_EXAM_LIMIT))
                .isInstanceOf(FreemiumLimitExceededException.class)
                .hasMessage("daily exams");
    }

    @Test
    @DisplayName("effectiveQuestionCount_freeTierRequestWithinLimit")
    public void effectiveQuestionCount_freeTierRequestWithinLimit() {
        assertThat(freemiumGuardService.effectiveQuestionCount(SubscriptionTier.FREE, Certification.FREE_QUESTION_LIMIT + 1))
                .isEqualTo(Certification.FREE_QUESTION_LIMIT);
    }

    @Test
    @DisplayName("effectiveQuestionCount_proTierNoCapping")
    public void effectiveQuestionCount_proTierNoCapping() {
        assertThat(freemiumGuardService.effectiveQuestionCount(SubscriptionTier.PRO, Certification.FREE_QUESTION_LIMIT + 1))
                .isEqualTo(Certification.FREE_QUESTION_LIMIT + 1);
    }

    @Test
    @DisplayName("requirePro_freeTierException")
    public void requirePro_freeTierException() {
        assertThatThrownBy(() -> freemiumGuardService.requirePro(SubscriptionTier.FREE, "AI feature"))
                .isInstanceOf(SubscriptionRequiredException.class)
                .hasMessage("AI feature");
    }

    @Test
    @DisplayName("requirePro_proTierNoException")
    public void requirePro_proTierNoException() {
        freemunGuardService.requirePro(SubscriptionTier.PRO, "AI feature");
    }

    @Test
    @DisplayName("requireUnlimited_freeTierException")
    public void requireUnlimited_freeTierException() {
        assertThatThrownBy(() -> freemiumGuardService.requireUnlimited(SubscriptionTier.FREE, "Unlimited access"))
                .isInstanceOf(SubscriptionRequiredException.class)
                .hasMessage("Unlimited access");
    }

    @Test
    @DisplayName("requireUnlimited_proOrPackTierNoException")
    public void requireUnlimited_proOrPackTierNoException() {
        when(tierMock.isUnlimited()).thenReturn(true);
        freemiumGuardService.requireUnlimited(SubscriptionTier.PRO, "Unlimited access");
        freemiumGuardService.requireUnlimited(SubscriptionTier.PACK, "Unlimited access");
    }
}
