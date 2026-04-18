package com.certifapp.domain.port.output;

import com.certifapp.domain.model.user.UserPreferences;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class UserPreferencesRepositoryTest {

    @BeforeEach
    public void setUp() {
        // Setup if needed
    }

    @Test
    @DisplayName("findByUserId_normal_case_user_preferences_found")
    public void findByUserId_normalCaseUserPreferencesFound() {
        UUID userId = UUID.randomUUID();
        UserPreferences preferences = new UserPreferences(userId);

        // Arrange
        var mockRepository = mock(UserPreferencesRepository.class);
        when(mockRepository.findByUserId(userId)).thenReturn(Optional.of(preferences));

        // Act
        var result = mockRepository.findByUserId(userId);

        // Assert
        assertThat(result).isPresent().contains(preferences);
    }

    @Test
    @DisplayName("findByUserId_edge_case_user_preferences_not_found")
    public void findByUserId_edgeCaseUserPreferencesNotFound() {
        UUID userId = UUID.randomUUID();

        // Arrange
        var mockRepository = mock(UserPreferencesRepository.class);
        when(mockRepository.findByUserId(userId)).thenReturn(Optional.empty());

        // Act
        var result = mockRepository.findByUserId(userId);

        // Assert
        assertThat(result).isNotPresent();
    }

    @Test
    @DisplayName("save_normal_case_user_preferences_saved")
    public void save_normalCaseUserPreferencesSaved() {
        UserPreferences preferences = new UserPreferences(UUID.randomUUID());

        // Arrange
        var mockRepository = mock(UserPreferencesRepository.class);
        when(mockRepository.save(preferences)).thenReturn(preferences);

        // Act
        var result = mockRepository.save(preferences);

        // Assert
        assertThat(result).isEqualTo(preferences);
    }

    @Test
    @DisplayName("save_error_case_exception_thrown")
    public void save_errorCaseExceptionThrown() {
        UserPreferences preferences = new UserPreferences(UUID.randomUUID());

        // Arrange
        var mockRepository = mock(UserPreferencesRepository.class);
        when(mockRepository.save(any(UserPreferences.class))).thenThrow(new RuntimeException("Mocked Exception"));

        // Act & Assert
        assertThatThrownBy(() -> mockRepository.save(preferences))
                .isInstanceOf(RuntimeException.class)
                .hasMessage("Mocked Exception");
    }
}