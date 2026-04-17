package com.certifapp.domain.port.output;

import com.certifapp.domain.model.user.UserPreferences;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserPreferencesRepositoryTest {

    @Mock
    private UserPreferencesRepository userPreferencesRepository;

    @InjectMocks
    private UserPreferencesRepositoryImpl userPreferencesRepositoryImpl;

    @BeforeEach
    public void setUp() {
        // Setup if needed
    }

    @Test
    @DisplayName("findByUserId_nomal_case_user_preferences_found")
    public void findByUserId_normalCaseUserPreferencesFound() {
        UUID userId = UUID.randomUUID();
        UserPreferences preferences = new UserPreferences(userId);
        when(userPreferencesRepository.findByUserId(userId)).thenReturn(Optional.of(preferences));

        Optional<UserPreferences> result = userPreferencesRepositoryImpl.findByUserId(userId);

        assertThat(result).isPresent().contains(preferences);
        verify(userPreferencesRepository, times(1)).findByUserId(userId);
    }

    @Test
    @DisplayName("findByUserId_edge_case_user_preferences_not_found")
    public void findByUserId_edgeCaseUserPreferencesNotFound() {
        UUID userId = UUID.randomUUID();
        when(userPreferencesRepository.findByUserId(userId)).thenReturn(Optional.empty());

        Optional<UserPreferences> result = userPreferencesRepositoryImpl.findByUserId(userId);

        assertThat(result).isNotPresent();
        verify(userPreferencesRepository, times(1)).findByUserId(userId);
    }

    @Test
    @DisplayName("save_nomal_case_user_preferences_saved")
    public void save_normalCaseUserPreferencesSaved() {
        UserPreferences preferences = new UserPreferences(UUID.randomUUID());
        when(userPreferencesRepository.save(preferences)).thenReturn(preferences);

        UserPreferences result = userPreferencesRepositoryImpl.save(preferences);

        assertThat(result).isEqualTo(preferences);
        verify(userPreferencesRepository, times(1)).save(preferences);
    }

    @Test
    @DisplayName("save_error_case_exception_thrown")
    public void save_errorCaseExceptionThrown() {
        UserPreferences preferences = new UserPreferences(UUID.randomUUID());
        when(userPreferencesRepository.save(any(UserPreferences.class))).thenThrow(new RuntimeException("Mocked Exception"));

        assertThatThrownBy(() -> userPreferencesRepositoryImpl.save(preferences))
                .isInstanceOf(RuntimeException.class)
                .hasMessage("Mocked Exception");

        verify(userPreferencesRepository, times(1)).save(any(UserPreferences.class));
    }
}

