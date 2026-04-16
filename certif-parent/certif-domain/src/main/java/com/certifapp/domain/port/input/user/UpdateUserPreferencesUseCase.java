// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/user/UpdateUserPreferencesUseCase.java
package com.certifapp.domain.port.input.user;

import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.user.UiTheme;
import com.certifapp.domain.model.user.UserPreferences;
import java.util.UUID;

/**
 * Use case: update the UI and study preferences of a user.
 */
public interface UpdateUserPreferencesUseCase {

    /**
     * Partial update command — null fields mean "no change".
     *
     * @param userId                user to update
     * @param theme                 new UI theme (null = keep current)
     * @param language              new language tag (null = keep current)
     * @param defaultMode           new default exam mode (null = keep current)
     * @param notificationsEnabled  new notifications flag (null = keep current)
     */
    record UpdatePreferencesCommand(
            UUID     userId,
            UiTheme  theme,
            String   language,
            ExamMode defaultMode,
            Boolean  notificationsEnabled
    ) {}

    /**
     * @param command partial preferences update
     * @return the updated {@link UserPreferences}
     * @throws com.certifapp.domain.exception.UserNotFoundException if user not found
     */
    UserPreferences execute(UpdatePreferencesCommand command);
}
