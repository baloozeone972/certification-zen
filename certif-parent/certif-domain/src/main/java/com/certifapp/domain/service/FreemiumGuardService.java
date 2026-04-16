// certif-parent/certif-domain/src/main/java/com/certifapp/domain/service/FreemiumGuardService.java
package com.certifapp.domain.service;

import com.certifapp.domain.exception.FreemiumLimitExceededException;
import com.certifapp.domain.exception.SubscriptionRequiredException;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.user.SubscriptionTier;

/**
 * Pure domain service enforcing freemium access rules.
 *
 * <p>All limits are defined as constants on {@link Certification} and validated here
 * before any use case creates or returns content.</p>
 */
public class FreemiumGuardService {

    /**
     * Verifies that a FREE-tier user has not exceeded their daily exam limit.
     *
     * @param tier          user subscription tier
     * @param todayExamCount number of exams already started today for this certification
     * @throws FreemiumLimitExceededException if the daily limit is exceeded
     */
    public void checkDailyExamLimit(SubscriptionTier tier, int todayExamCount) {
        if (tier == SubscriptionTier.FREE
                && todayExamCount >= Certification.FREE_DAILY_EXAM_LIMIT) {
            throw FreemiumLimitExceededException.dailyExams();
        }
    }

    /**
     * Caps the question count for FREE-tier users.
     *
     * @param tier           user subscription tier
     * @param requestedCount number of questions requested
     * @return the effective question count (capped for FREE users)
     */
    public int effectiveQuestionCount(SubscriptionTier tier, int requestedCount) {
        if (tier == SubscriptionTier.FREE) {
            return Math.min(requestedCount, Certification.FREE_QUESTION_LIMIT);
        }
        return requestedCount;
    }

    /**
     * Verifies that a user has a PRO subscription to access AI features.
     *
     * @param tier        user subscription tier
     * @param featureName feature name for the error message
     * @throws SubscriptionRequiredException if user is not PRO
     */
    public void requirePro(SubscriptionTier tier, String featureName) {
        if (!tier.hasAiFeatures()) {
            throw new SubscriptionRequiredException(featureName);
        }
    }

    /**
     * Verifies that a user has at least PRO or PACK subscription for unlimited access.
     *
     * @param tier        user subscription tier
     * @param featureName feature name for the error message
     * @throws SubscriptionRequiredException if user is FREE
     */
    public void requireUnlimited(SubscriptionTier tier, String featureName) {
        if (!tier.isUnlimited()) {
            throw new SubscriptionRequiredException(featureName);
        }
    }
}
