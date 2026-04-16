// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/controller/AuthController.java
package com.certifapp.api.controller;

import com.certifapp.api.dto.request.*;
import com.certifapp.api.dto.response.*;
import com.certifapp.api.security.JwtTokenProvider;
import com.certifapp.domain.model.user.User;
import com.certifapp.domain.port.input.user.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * REST controller for authentication endpoints.
 *
 * <p>All endpoints are public (no JWT required) — see {@code SecurityConfig}.</p>
 */
@RestController
@RequestMapping("/api/v1/auth")
@Tag(name = "Auth", description = "Registration, login and token refresh")
public class AuthController {

    private final RegisterUserUseCase     registerUseCase;
    private final AuthenticateUserUseCase authUseCase;
    private final JwtTokenProvider        tokenProvider;

    public AuthController(
            RegisterUserUseCase     registerUseCase,
            AuthenticateUserUseCase authUseCase,
            JwtTokenProvider        tokenProvider) {
        this.registerUseCase = registerUseCase;
        this.authUseCase     = authUseCase;
        this.tokenProvider   = tokenProvider;
    }

    /**
     * Register a new user account.
     *
     * @param request registration data
     * @return 201 Created with JWT token pair
     */
    @PostMapping("/register")
    @Operation(summary = "Register a new user account")
    public ResponseEntity<ApiResponse<TokenResponse>> register(
            @Valid @RequestBody RegisterRequest request) {

        RegisterUserUseCase.RegisterUserCommand command =
                new RegisterUserUseCase.RegisterUserCommand(
                        request.email(), request.password(),
                        request.locale(), request.timezone());

        User user = registerUseCase.execute(command);
        TokenResponse tokens = issueTokens(user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.created(tokens));
    }

    /**
     * Authenticate with email and password.
     *
     * @param request login credentials
     * @return 200 OK with JWT token pair
     */
    @PostMapping("/login")
    @Operation(summary = "Authenticate with email and password")
    public ResponseEntity<ApiResponse<TokenResponse>> login(
            @Valid @RequestBody LoginRequest request) {

        User user = authUseCase.execute(request.email(), request.password());
        return ResponseEntity.ok(ApiResponse.ok(issueTokens(user)));
    }

    /**
     * Refresh the access token using a valid refresh token.
     *
     * @param request the refresh token
     * @return 200 OK with new JWT token pair
     */
    @PostMapping("/refresh")
    @Operation(summary = "Refresh access token using a refresh token")
    public ResponseEntity<ApiResponse<TokenResponse>> refresh(
            @Valid @RequestBody RefreshTokenRequest request) {

        var userId = tokenProvider.extractUserId(request.refreshToken());
        // Reissue — role re-read from claims if needed; simplified here
        String access  = tokenProvider.generateAccessToken(userId, "USER");
        String refresh = tokenProvider.generateRefreshToken(userId);
        return ResponseEntity.ok(ApiResponse.ok(TokenResponse.of(access, refresh)));
    }

    // ── Helper ────────────────────────────────────────────────────────────────

    private TokenResponse issueTokens(User user) {
        String access  = tokenProvider.generateAccessToken(user.id(), user.role().name());
        String refresh = tokenProvider.generateRefreshToken(user.id());
        return TokenResponse.of(access, refresh);
    }
}
