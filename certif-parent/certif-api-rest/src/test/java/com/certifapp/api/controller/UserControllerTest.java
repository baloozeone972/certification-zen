package com.certifapp.api.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;
import static org.springframework.http.HttpStatus.*;

import java.util.Optional;
import java.util.UUID;

import com.certifapp.api.dto.request.UpdatePreferencesRequest;
import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.domain.exception.UserNotFoundException;
import com.certifapp.domain.model.user.UiTheme;
import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.user.User;
import com.certifapp.domain.model.user.UserPreferences;
import com.certifapp.domain.port.input.user.UpdateUserPreferencesUseCase;
import com.certifapp.domain.port.output.UserPreferencesRepository;
import com.certifapp.domain.port.output.UserRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.springframework.http.ResponseEntity;

@ExtendWith(MockitoExtension.class)
public class UserControllerTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private UserPreferencesRepository preferencesRepository;

    @Mock
    private UpdateUserPreferencesUseCase updatePrefsUseCase;

    @InjectMocks
    private UserController userController;

    @BeforeEach
    public void setUp() {
        when(CurrentUser.id()).thenReturn(UUID.randomUUID());
    }

    @Test
    @DisplayName("GetMe_nominal_case_returns_user_profile")
    public void getMe_nominal_case_returns_user_profile() {
        UUID userId = CurrentUser.id();
        User user = new User(userId, "test@example.com", "passwordHash", null);
        when(userRepository.findById(userId)).thenReturn(Optional.of(user));

        ResponseEntity<ApiResponse<User>> response = userController.getMe();

        assertThat(response.getStatusCode()).isEqualTo(OK);
        ApiResponse<User> apiResponse = response.getBody();
        assertThat(apiResponse).isNotNull();
        assertThat(apiResponse.getData()).isEqualTo(user);
    }

    @Test
    @DisplayName("GetMe_user_not_found_throws_exception")
    public void getMe_user_not_found_throws_exception() {
        UUID userId = CurrentUser.id();
        when(userRepository.findById(userId)).thenReturn(Optional.empty());

        ResponseEntity<ApiResponse<User>> response = userController.getMe();

        assertThat(response.getStatusCode()).isEqualTo(NOT_FOUND);
        ApiResponse<User> apiResponse = response.getBody();
        assertThat(apiResponse).isNotNull();
        assertThat(apiResponse.getMessage()).isEqualTo("User not found");
    }

    @Test
    @DisplayName("GetPreferences_nominal_case_returns_user_preferences")
    public void getPreferences_nominal_case_returns_user_preferences() {
        UUID userId = CurrentUser.id();
        UserPreferences prefs = new UserPreferences(userId, UiTheme.LIGHT, "en", ExamMode.CLASSIC, true);
        when(preferencesRepository.findByUserId(userId)).thenReturn(Optional.of(prefs));

        ResponseEntity<ApiResponse<UserPreferences>> response = userController.getPreferences();

        assertThat(response.getStatusCode()).isEqualTo(OK);
        ApiResponse<UserPreferences> apiResponse = response.getBody();
        assertThat(apiResponse).isNotNull();
        assertThat(apiResponse.getData()).isEqualTo(prefs);
    }

    @Test
    @DisplayName("GetPreferences_preferences_not_found_returns_default")
    public void getPreferences_preferences_not_found_returns_default() {
        UUID userId = CurrentUser.id();
        when(preferencesRepository.findByUserId(userId)).thenReturn(Optional.empty());

        ResponseEntity<ApiResponse<UserPreferences>> response = userController.getPreferences();

        assertThat(response.getStatusCode()).isEqualTo(OK);
        ApiResponse<UserPreferences> apiResponse = response.getBody();
        assertThat(apiResponse).isNotNull();
        assertThat(apiResponse.getData().getTheme()).isEqualTo(UiTheme.DEFAULT);
    }

    @Test
    @DisplayName("UpdatePreferences_nominal_case_updates_preferences")
    public void updatePreferences_nominal_case_updates_preferences() {
        UUID userId = CurrentUser.id();
        UpdatePreferencesRequest request = new UpdatePreferencesRequest("DARK", "en", ExamMode.QUICK, true);
        UiTheme theme = UiTheme.valueOf(request.theme().toUpperCase());
        ExamMode mode = ExamMode.valueOf(request.defaultMode());

        var command = new UpdateUserPreferencesUseCase.UpdatePreferencesCommand(userId, theme, request.language(), mode, request.notificationsEnabled());
        UserPreferences prefs = new UserPreferences(userId, theme, "en", mode, true);
        when(updatePrefsUseCase.execute(command)).thenReturn(prefs);

        ResponseEntity<ApiResponse<UserPreferences>> response = userController.updatePreferences(request);

        assertThat(response.getStatusCode()).isEqualTo(OK);
        ApiResponse<UserPreferences> apiResponse = response.getBody();
        assertThat(apiResponse).isNotNull();
        assertThat(apiResponse.getData()).isEqualTo(prefs);
    }

    @Test
    @DisplayName("UpdatePreferences_invalid_theme_throws_exception")
    public void updatePreferences_invalid_theme_throws_exception() {
        UUID userId = CurrentUser.id();
        UpdatePreferencesRequest request = new UpdatePreferencesRequest("INVALID", "en", ExamMode.QUICK, true);

        ResponseEntity<ApiResponse<UserPreferences>> response = userController.updatePreferences(request);

        assertThat(response.getStatusCode()).isEqualTo(BAD_REQUEST);
        ApiResponse<UserPreferences> apiResponse = response.getBody();
        assertThat(apiResponse).isNotNull();
        assertThat(apiResponse.getMessage()).startsWith("Invalid theme");
    }

    @Test
    @DisplayName("UpdatePreferences_invalid_mode_throws_exception")
    public void updatePreferences_invalid_mode_throws_exception() {
        UUID userId = CurrentUser.id();
        UpdatePreferencesRequest request = new UpdatePreferencesRequest("DARK", "en", "INVALID", true);

        ResponseEntity<ApiResponse<UserPreferences>> response = userController.updatePreferences(request);

        assertThat(response.getStatusCode()).isEqualTo(BAD_REQUEST);
        ApiResponse<UserPreferences> apiResponse = response.getBody();
        assertThat(apiResponse).isNotNull();
        assertThat(apiResponse.getMessage()).startsWith("Invalid mode");
    }
}
