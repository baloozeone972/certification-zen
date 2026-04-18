package com.certifapp.domain.port.input.user;

import com.certifapp.domain.exception.UserNotFoundException;
import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.user.UiTheme;
import com.certifapp.domain.model.user.UserPreferences;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class UpdateUserPreferencesUseCaseTest {

    private UpdateUserPreferencesUseCaseImpl updateUserPreferencesUseCase;

    @BeforeEach
    public void setUp() {
        updateUserPreferencesUseCase = new UpdateUserPreferencesUseCaseImpl();
    }

    @Test
    @DisplayName("should update user preferences with partial command")
    public void updatePreferences_nominalCase_success() {
        UUID userId = UUID.randomUUID();
        UiTheme theme = UiTheme.DARK;
        String language = "en";
        ExamMode defaultMode = ExamMode.NORMAL;
        Boolean notificationsEnabled = true;

        UpdateUserPreferencesUseCase.UpdatePreferencesCommand command =
                new UpdateUserPreferencesUseCase.UpdatePreferencesCommand(
                        userId, theme, language, defaultMode, notificationsEnabled
                );

        UserPreferences existingUserPreferences = UserPreferences.builder()
                .userId(userId)
                .theme(UiTheme.LIGHT)
                .language("fr")
                .defaultMode(ExamMode.EXPERT)
                .notificationsEnabled(false)
                .build();

        UserPreferences updatedUserPreferences = updateUserPreferencesUseCase.execute(command, existingUserPreferences);

        assertThat(updatedUserPreferences.getTheme()).isEqualTo(theme);
        assertThat(updatedUserPreferences.getLanguage()).isEqualTo(language);
        assertThat(updatedUserPreferences.getDefaultMode()).isEqualTo(defaultMode);
        assertThat(updatedUserPreferences.isNotificationsEnabled()).isEqualTo(notificationsEnabled);
    }

    @Test
    @DisplayName("should return existing preferences if command has null fields")
    public void updatePreferences_edgeCase_nullFields_success() {
        UUID userId = UUID.randomUUID();

        UpdateUserPreferencesUseCase.UpdatePreferencesCommand command =
                new UpdateUserPreferencesUseCase.UpdatePreferencesCommand(
                        userId, null, null, null, null
                );

        UserPreferences existingUserPreferences = UserPreferences.builder()
                .userId(userId)
                .theme(UiTheme.LIGHT)
                .language("fr")
                .defaultMode(ExamMode.EXPERT)
                .notificationsEnabled(false)
                .build();

        UserPreferences updatedUserPreferences = updateUserPreferencesUseCase.execute(command, existingUserPreferences);

        assertThat(updatedUserPreferences.getTheme()).isEqualTo(existingUserPreferences.getTheme());
        assertThat(updatedUserPreferences.getLanguage()).isEqualTo(existingUserPreferences.getLanguage());
        assertThat(updatedUserPreferences.getDefaultMode()).isEqualTo(existingUserPreferences.getDefaultMode());
        assertThat(updatedUserPreferences.isNotificationsEnabled()).isEqualTo(existingUserPreferences.isNotificationsEnabled());
    }

    @Test
    @DisplayName("should throw UserNotFoundException if user not found")
    public void updatePreferences_errorCase_userNotFound_throwsException() {
        UUID userId = UUID.randomUUID();

        UpdateUserPreferencesUseCase.UpdatePreferencesCommand command =
                new UpdateUserPreferencesUseCase.UpdatePreferencesCommand(
                        userId, null, null, null, null
                );

        assertThatThrownBy(() -> updateUserPreferencesUseCase.execute(command, null))
                .isInstanceOf(UserNotFoundException.class)
                .hasMessage("User not found");
    }
}