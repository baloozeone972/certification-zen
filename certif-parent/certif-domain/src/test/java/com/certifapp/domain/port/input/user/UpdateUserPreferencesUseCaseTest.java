```java
package com.certifapp.domain.port.input.user;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import com.certifapp.domain.exception.UserNotFoundException;
import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.user.UiTheme;
import com.certifapp.domain.model.user.UserPreferences;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class UpdateUserPreferencesUseCaseTest {

    @Mock
    private UserPreferencesRepository userPreferencesRepository;

    @InjectMocks
    private UpdateUserPreferencesUseCaseImpl updateUserPreferencesUseCase;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(userPreferencesRepository);
    }

    @Test
    @DisplayName("should update user preferences with partial command")
    public void updatePreferences_nominalCase_success() throws UserNotFoundException {
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

        when(userPreferencesRepository.findByUserId(userId)).thenReturn(existingUserPreferences);
        when(userPreferencesRepository.save(any(UserPreferences.class))).thenReturn(existingUserPreferences);

        UserPreferences updatedUserPreferences = updateUserPreferencesUseCase.execute(command);

        assertThat(updatedUserPreferences.getTheme()).isEqualTo(theme);
        assertThat(updatedUserPreferences.getLanguage()).isEqualTo(language);
        assertThat(updatedUserPreferences.getDefaultMode()).isEqualTo(defaultMode);
        assertThat(updatedUserPreferences.isNotificationsEnabled()).isEqualTo(notificationsEnabled);

        verify(userPreferencesRepository).save(any(UserPreferences.class));
    }

    @Test
    @DisplayName("should return existing preferences if command has null fields")
    public void updatePreferences_edgeCase_nullFields_success() throws UserNotFoundException {
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

        when(userPreferencesRepository.findByUserId(userId)).thenReturn(existingUserPreferences);

        UserPreferences updatedUserPreferences = updateUserPreferencesUseCase.execute(command);

        assertThat(updatedUserPreferences.getTheme()).isEqualTo(existingUserPreferences.getTheme());
        assertThat(updatedUserPreferences.getLanguage()).isEqualTo(existingUserPreferences.getLanguage());
        assertThat(updatedUserPreferences.getDefaultMode()).isEqualTo(existingUserPreferences.getDefaultMode());
        assertThat(updatedUserPreferences.isNotificationsEnabled()).isEqualTo(existingUserPreferences.isNotificationsEnabled());

        verifyNoMoreInteractions(userPreferencesRepository);
    }

    @Test
    @DisplayName("should throw UserNotFoundException if user not found")
    public void updatePreferences_errorCase_userNotFound_throwsException() throws UserNotFoundException {
        UUID userId = UUID.randomUUID();

        UpdateUserPreferencesUseCase.UpdatePreferencesCommand command =
                new UpdateUserPreferencesUseCase.UpdatePreferencesCommand(
                        userId, null, null, null, null
                );

        when(userPreferencesRepository.findByUserId(userId)).thenReturn(null);

        assertThatThrownBy(() -> updateUserPreferencesUseCase.execute(command))
                .isInstanceOf(UserNotFoundException.class)
                .hasMessage("User not found");

        verifyNoMoreInteractions(userPreferencesRepository);
    }
}
```
