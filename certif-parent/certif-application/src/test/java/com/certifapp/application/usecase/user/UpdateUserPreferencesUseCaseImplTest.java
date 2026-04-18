package com.certifapp.application.usecase.user;

import com.certifapp.domain.exception.UserNotFoundException;
import com.certifapp.domain.model.user.UserId;
import com.certifapp.domain.model.user.UserPreferences;
import com.certifapp.domain.port.input.user.UpdateUserPreferencesUseCase.UpdatePreferencesCommand;
import com.certifapp.domain.port.output.UserPreferencesRepository;
import com.certifapp.domain.port.output.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class UpdateUserPreferencesUseCaseImplTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private UserPreferencesRepository preferencesRepository;

    @InjectMocks
    private UpdateUserPreferencesUseCaseImpl useCase;

    @BeforeEach
    public void setUp() {
        when(userRepository.findById(any(UserId.class))).thenReturn(Optional.empty());
    }

    @Test
    @DisplayName("Should update user preferences with partial values")
    public void updateUserPreferences_partiallyUpdated() throws UserNotFoundException {
        // Arrange
        UserId userId = new UserId(1L);
        UpdatePreferencesCommand command = new UpdatePreferencesCommand(userId, "dark", null, "en", true);

        UserPreferences existingPrefs = UserPreferences.defaultsFor(userId);
        when(preferencesRepository.findByUserId(userId)).thenReturn(Optional.of(existingPrefs));

        // Act
        UserPreferences updatedPrefs = useCase.execute(command);

        // Assert
        assertThat(updatedPrefs.getTheme()).isEqualTo("dark");
        assertThat(updatedPrefs.getLanguage()).isEqualTo(existingPrefs.getLanguage());
        assertThat(updatedPrefs.getDefaultMode()).isEqualTo(existingPrefs.getDefaultMode());
        assertThat(updatedPrefs.isNotificationsEnabled()).isEqualTo(true);
    }

    @Test
    @DisplayName("Should return default preferences if none exist")
    public void updateUserPreferences_defaultPreferences() throws UserNotFoundException {
        // Arrange
        UserId userId = new UserId(1L);
        UpdatePreferencesCommand command = new UpdatePreferencesCommand(userId, "dark", null, "en", true);

        when(preferencesRepository.findByUserId(userId)).thenReturn(Optional.empty());

        // Act
        UserPreferences updatedPrefs = useCase.execute(command);

        // Assert
        assertThat(updatedPrefs.getTheme()).isEqualTo("dark");
        assertThat(updatedPrefs.getLanguage()).isEqualTo("en");
        assertThat(updatedPrefs.getDefaultMode()).isNull();
        assertThat(updatedPrefs.isNotificationsEnabled()).isEqualTo(true);
    }

    @Test
    @DisplayName("Should throw UserNotFoundException if user does not exist")
    public void updateUserPreferences_userNotFound() {
        // Arrange
        UserId userId = new UserId(1L);
        UpdatePreferencesCommand command = new UpdatePreferencesCommand(userId, "dark", null, "en", true);

        // Act & Assert
        assertThatThrownBy(() -> useCase.execute(command))
                .isInstanceOf(UserNotFoundException.class)
                .hasMessage(userId.toString());
    }
}