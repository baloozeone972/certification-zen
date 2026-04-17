// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/controller/UserController.java
package com.certifapp.api.controller;

import com.certifapp.api.dto.request.UpdatePreferencesRequest;
import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.api.security.CurrentUser;
import com.certifapp.domain.model.user.UiTheme;
import com.certifapp.domain.model.user.User;
import com.certifapp.domain.model.user.UserPreferences;
import com.certifapp.domain.port.input.user.UpdateUserPreferencesUseCase;
import com.certifapp.domain.port.output.UserPreferencesRepository;
import com.certifapp.domain.port.output.UserRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * REST controller for user profile and preferences.
 */
@RestController
@RequestMapping("/api/v1/users")
@Tag(name = "Users", description = "User profile and preferences")
@SecurityRequirement(name = "BearerAuth")
public class UserController {

    private final UserRepository userRepository;
    private final UserPreferencesRepository preferencesRepository;
    private final UpdateUserPreferencesUseCase updatePrefsUseCase;

    public UserController(
            UserRepository userRepository,
            UserPreferencesRepository preferencesRepository,
            UpdateUserPreferencesUseCase updatePrefsUseCase) {
        this.userRepository = userRepository;
        this.preferencesRepository = preferencesRepository;
        this.updatePrefsUseCase = updatePrefsUseCase;
    }

    /**
     * Get the authenticated user's profile.
     *
     * @return 200 OK with user data (never includes passwordHash)
     */
    @GetMapping("/me")
    @Operation(summary = "Get current user profile")
    public ResponseEntity<ApiResponse<User>> getMe() {
        UUID userId = CurrentUser.id();
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new com.certifapp.domain.exception.UserNotFoundException(userId.toString()));
        return ResponseEntity.ok(ApiResponse.ok(user));
    }

    /**
     * Get the authenticated user's preferences.
     *
     * @return 200 OK with preferences
     */
    @GetMapping("/me/preferences")
    @Operation(summary = "Get current user preferences")
    public ResponseEntity<ApiResponse<UserPreferences>> getPreferences() {
        UUID userId = CurrentUser.id();
        UserPreferences prefs = preferencesRepository.findByUserId(userId)
                .orElseGet(() -> UserPreferences.defaultsFor(userId));
        return ResponseEntity.ok(ApiResponse.ok(prefs));
    }

    /**
     * Update the authenticated user's preferences (partial update).
     *
     * @param request partial preferences update
     * @return 200 OK with updated preferences
     */
    @PatchMapping("/me/preferences")
    @Operation(summary = "Update user preferences (partial update)")
    public ResponseEntity<ApiResponse<UserPreferences>> updatePreferences(
            @Valid @RequestBody UpdatePreferencesRequest request) {

        UUID userId = CurrentUser.id();
        UiTheme theme = request.theme() != null
                ? UiTheme.valueOf(request.theme().toUpperCase()) : null;
        ExamMode mode = request.defaultMode() != null
                ? com.certifapp.domain.model.session.ExamMode.valueOf(request.defaultMode()) : null;

        var command = new UpdateUserPreferencesUseCase.UpdatePreferencesCommand(
                userId, theme, request.language(), mode, request.notificationsEnabled());

        return ResponseEntity.ok(ApiResponse.ok(updatePrefsUseCase.execute(command)));
    }
}
