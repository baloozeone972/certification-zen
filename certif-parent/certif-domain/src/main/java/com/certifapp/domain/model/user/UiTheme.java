// certif-domain/src/main/java/com/certifapp/domain/model/user/UiTheme.java
package com.certifapp.domain.model.user;

/**
 * UI colour theme preference stored in {@link UserPreferences}.
 *
 * <p>Maps to the {@code theme VARCHAR(10)} column in {@code user_preferences}.</p>
 */
public enum UiTheme {

    /**
     * Light background — default for new users.
     */
    LIGHT,

    /**
     * Dark background — reduced eye strain for night study.
     */
    DARK,

    /**
     * Follow the operating system / browser preference.
     */
    SYSTEM
}
