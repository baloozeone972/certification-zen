// certif-domain/src/main/java/com/certifapp/domain/model/user/SubscriptionTier.java
package com.certifapp.domain.model.user;

/**
 * Subscription level of a {@link User}, governing access to premium features.
 *
 * <p>Business rules enforced by {@code FreemiumGuardService}:</p>
 * <ul>
 *   <li>{@code FREE} — 2 exams/day per certification, 20 questions max per session.</li>
 *   <li>{@code PRO} — unlimited exams, flashcards, AI coach, PDF export, all certifications.</li>
 *   <li>{@code PACK} — unlimited access to one specific certification (one-time purchase).</li>
 * </ul>
 *
 * <p>Maps to the {@code subscription_tier VARCHAR(20)} column in {@code users}.</p>
 */
public enum SubscriptionTier {

    /**
     * Freemium — limited daily exams and question count.
     */
    FREE,

    /**
     * Monthly subscription — 9.99 €/month, unlimited everything.
     */
    PRO,

    /**
     * One-time purchase — 4.99 €, single certification, permanent access.
     */
    PACK;

    /**
     * Returns {@code true} if this tier grants unlimited exam access.
     *
     * @return {@code true} for {@code PRO} and {@code PACK}
     */
    public boolean isUnlimited() {
        return this == PRO || this == PACK;
    }

    /**
     * Returns {@code true} if this tier includes AI-powered features
     * (coach report, chat assistant, interview simulator, adaptive plan).
     *
     * @return {@code true} only for {@code PRO}
     */
    public boolean hasAiFeatures() {
        return this == PRO;
    }
}
