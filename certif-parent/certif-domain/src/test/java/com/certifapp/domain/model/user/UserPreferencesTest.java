```java
package com.certifapp.domain.model.user;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.junit.jupiter.api.extension.ExtendWith;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserPreferencesTest {

    @Mock
    private User user;

    @InjectMocks
    private UserPreferences userPreferences;

    @BeforeEach
    public void setUp() {
        // Initialization if needed
    }

    @Test
    @DisplayName("Should create defaults with provided userId")
    public void defaultsFor_withUserId_ShouldCreateDefaults() {
        UUID userId = UUID.randomUUID();
        UserPreferences preferences = UserPreferences.defaultsFor(userId);

        assertThat(preferences).isNotNull();
        assertThat(preferences.userId()).isEqualTo(userId);
        assertThat(preferences.theme()).isEqualTo(UiTheme.LIGHT);
        assertThat(preferences.language()).isEqualTo("fr");
        assertThat(preferences.defaultMode()).isEqualTo(ExamMode.EXAM);
        assertThat(preferences.notificationsEnabled()).isTrue();
        assertThat(preferences.lastCertificationId()).isNull();
        assertThat(preferences.freeModeQuestionCount()).isEqualTo(30);
        assertThat(preferences.freeModeDurationMin()).isEqualTo(60);
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for null userId")
    public void UserPreferences_withNullUserId_ShouldThrowException() {
        UUID userId = null;

        assertThatThrownBy(() -> new UserPreferences(userId, UiTheme.LIGHT, "fr",
                ExamMode.EXAM, true, null, 30, 60))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("userId must not be null");
    }

    @Test
    @DisplayName("Should use default theme if null")
    public void UserPreferences_withNullTheme_ShouldUseDefaultTheme() {
        UUID userId = UUID.randomUUID();
        UserPreferences preferences = new UserPreferences(userId, null, "fr",
                ExamMode.EXAM, true, null, 30, 60);

        assertThat(preferences.theme()).isEqualTo(UiTheme.LIGHT);
    }

    @Test
    @DisplayName("Should use default language if blank")
    public void UserPreferences_withBlankLanguage_ShouldUseDefaultLanguage() {
        UUID userId = UUID.randomUUID();
        UserPreferences preferences = new UserPreferences(userId, UiTheme.LIGHT, "",
                ExamMode.EXAM, true, null, 30, 60);

        assertThat(preferences.language()).isEqualTo("fr");
    }

    @Test
    @DisplayName("Should use default mode if null")
    public void UserPreferences_withNullDefaultMode_ShouldUseDefaultMode() {
        UUID userId = UUID.randomUUID();
        UserPreferences preferences = new UserPreferences(userId, UiTheme.LIGHT, "fr",
                null, true, null, 30, 60);

        assertThat(preferences.defaultMode()).isEqualTo(ExamMode.EXAM);
    }

    @Test
    @DisplayName("Should use default question count if less than 1")
    public void UserPreferences_withFreeModeQuestionCountLessThanOne_ShouldUseDefaultQuestionCount() {
        UUID userId = UUID.randomUUID();
        UserPreferences preferences = new UserPreferences(userId, UiTheme.LIGHT, "fr",
                ExamMode.EXAM, true, null, 0, 60);

        assertThat(preferences.freeModeQuestionCount()).isEqualTo(30);
    }

    @Test
    @DisplayName("Should use default duration if less than 0")
    public void UserPreferences_withFreeModeDurationMinLessThanZero_ShouldUseDefaultDuration() {
        UUID userId = UUID.randomUUID();
        UserPreferences preferences = new UserPreferences(userId, UiTheme.LIGHT, "fr",
                ExamMode.EXAM, true, null, 30, -1);

        assertThat(preferences.freeModeDurationMin()).isEqualTo(60);
    }
}
```
