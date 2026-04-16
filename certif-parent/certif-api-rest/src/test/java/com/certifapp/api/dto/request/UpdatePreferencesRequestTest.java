```java
package com.certifapp.api.dto.request;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

@ExtendWith(MockitoExtension.class)
public class UpdatePreferencesRequestTest {

    @InjectMocks
    private UpdatePreferencesRequest updatePreferencesRequest;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @AfterEach
    public void tearDown() {
        // Teardown code if needed
    }

    @Test
    @DisplayName("Should create a valid UpdatePreferencesRequest with all fields")
    public void shouldCreateValidUpdatePreferencesRequestWithAllFields() {
        String theme = "light";
        String language = "en-US";
        String defaultMode = "EXAM";
        Boolean notificationsEnabled = true;

        updatePreferencesRequest = new UpdatePreferencesRequest(theme, language, defaultMode, notificationsEnabled);

        Assertions.assertThat(updatePreferencesRequest.theme()).isEqualTo(theme);
        Assertions.assertThat(updatePreferencesRequest.language()).isEqualTo(language);
        Assertions.assertThat(updatePreferencesRequest.defaultMode()).isEqualTo(defaultMode);
        Assertions.assertThat(updatePreferencesRequest.notificationsEnabled()).isEqualTo(notificationsEnabled);
    }

    @Test
    @DisplayName("Should create a valid UpdatePreferencesRequest with some fields null")
    public void shouldCreateValidUpdatePreferencesRequestWithSomeFieldsNull() {
        String theme = "light";
        String language = null;
        String defaultMode = "EXAM";
        Boolean notificationsEnabled = true;

        updatePreferencesRequest = new UpdatePreferencesRequest(theme, language, defaultMode, notificationsEnabled);

        Assertions.assertThat(updatePreferencesRequest.theme()).isEqualTo(theme);
        Assertions.assertThat(updatePreferencesRequest.language()).isNull();
        Assertions.assertThat(updatePreferencesRequest.defaultMode()).isEqualTo(defaultMode);
        Assertions.assertThat(updatePreferencesRequest.notificationsEnabled()).isEqualTo(notificationsEnabled);
    }

    @Test
    @DisplayName("Should create a valid UpdatePreferencesRequest with all fields null")
    public void shouldCreateValidUpdatePreferencesRequestWithAllFieldsNull() {
        updatePreferencesRequest = new UpdatePreferencesRequest(null, null, null, null);

        Assertions.assertThat(updatePreferencesRequest.theme()).isNull();
        Assertions.assertThat(updatePreferencesRequest.language()).isNull();
        Assertions.assertThat(updatePreferencesRequest.defaultMode()).isNull();
        Assertions.assertThat(updatePreferencesRequest.notificationsEnabled()).isNull();
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for invalid theme value")
    public void shouldThrowIllegalArgumentExceptionForInvalidThemeValue() {
        String theme = "invalid";
        String language = "en-US";
        String defaultMode = "EXAM";
        Boolean notificationsEnabled = true;

        Assertions.assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new UpdatePreferencesRequest(theme, language, defaultMode, notificationsEnabled))
                .withMessage("Invalid theme value");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for invalid defaultMode value")
    public void shouldThrowIllegalArgumentExceptionForInvalidDefaultModeValue() {
        String theme = "light";
        String language = "en-US";
        String defaultMode = "INVALID";
        Boolean notificationsEnabled = true;

        Assertions.assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new UpdatePreferencesRequest(theme, language, defaultMode, notificationsEnabled))
                .withMessage("Invalid default mode value");
    }
}
```
