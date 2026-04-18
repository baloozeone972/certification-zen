// certif-domain/src/main/java/com/certifapp/domain/model/user/UiTheme.java
package com.certifapp.domain.model.user;

/**
 * UI colour theme preference stored in {@link UserPreferences}.
 *
 * <p>Maps to the {@code theme VARCHAR(10)} column in {@code user_preferences}.</p>
 */
public record UiTheme(
        String value
) {

    /**
     * Light background — default for new users.
     */
    public static final UiTheme LIGHT = new UiTheme("LIGHT");

    /**
     * Dark background — reduced eye strain for night study.
     */
    public static final UiTheme DARK = new UiTheme("DARK");

    /**
     * Follow the operating system / browser preference.
     */
    public static final UiTheme SYSTEM = new UiTheme("SYSTEM");
}