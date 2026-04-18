// certif-parent/certif-domain/src/main/java/com/certifapp/domain/model/user/UserPreferences.java
package com.certifapp.domain.model.user;

import com.certifapp.domain.model.session.ExamMode;

import java.util.UUID;

/**
 * User's persisted UI and study preferences.
 *
 * <p>1-to-1 relationship with {@link User} — created at registration with defaults.
 * Maps to the {@code user_preferences} table in PostgreSQL.</p>
 *
 * @param userId                FK → users.id
 * @param theme                 UI colour theme ({@link UiTheme})
 * @param language              BCP-47 language tag for UI (may differ from user locale)
 * @param defaultMode           default exam mode when starting a new session
 * @param notificationsEnabled  whether to send push and email notifications
 * @param lastCertificationId   last selected certification slug — for quick resume
 * @param freeModeQuestionCount default question count slider value for FREE mode
 * @param freeModeDurationMin   default timer value in minutes for FREE mode (0 = unlimited)
 */
public record UserPreferences(
        UUID userId,
        UiTheme theme,
        String language,
        ExamMode defaultMode,
        boolean notificationsEnabled,
        String lastCertificationId,
        int freeModeQuestionCount,
        int freeModeDurationMin
) {
    /**
     * Compact constructor with defaults and validation.
     */
    public UserPreferences {
        if (userId == null) throw new IllegalArgumentException("userId must not be null");
        if (theme == null) theme = UiTheme.LIGHT;
        if (language == null || language.isBlank()) language = "fr";
        if (defaultMode == null) defaultMode = ExamMode.EXAM;
        if (freeModeQuestionCount < 1) freeModeQuestionCount = 30;
        if (freeModeDurationMin < 0) freeModeDurationMin = 60;
    }

    /**
     * Creates default preferences for a newly registered user.
     *
     * @param userId the user's UUID
     * @return preferences with sensible defaults
     */
    public static UserPreferences defaultsFor(UUID userId) {
        return new UserPreferences(userId, UiTheme.LIGHT, "fr",
                ExamMode.EXAM, true, null, 30, 60);
    }
}
