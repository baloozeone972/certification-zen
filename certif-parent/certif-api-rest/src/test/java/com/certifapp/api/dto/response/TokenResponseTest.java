package com.certifapp.api.dto.response;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class TokenResponseTest {

    @InjectMocks
    private TokenResponse tokenResponse;

    @BeforeEach
    public void setUp() {
        // Setup if needed
    }

    @Test
    @DisplayName("should create a new instance with provided access and refresh tokens")
    public void of_accessAndRefreshTokens_newInstanceCreated() {
        String accessToken = "access_token";
        String refreshToken = "refresh_token";

        TokenResponse result = TokenResponse.of(accessToken, refreshToken);

        assertThat(result).isNotNull();
        assertThat(result.accessToken()).isEqualTo(accessToken);
        assertThat(result.refreshToken()).isEqualTo(refreshToken);
        assertThat(result.expiresIn()).isEqualTo(900);
        assertThat(result.tokenType()).isEqualTo("Bearer");
    }

    @Test
    @DisplayName("should create a new instance with default values when access and refresh tokens are null")
    public void of_nullAccessAndRefreshTokens_newInstanceCreatedWithDefaults() {
        TokenResponse result = TokenResponse.of(null, null);

        assertThat(result).isNotNull();
        assertThat(result.accessToken()).isEqualTo("access_token");
        assertThat(result.refreshToken()).isEqualTo("refresh_token");
        assertThat(result.expiresIn()).isEqualTo(900);
        assertThat(result.tokenType()).isEqualTo("Bearer");
    }

    @Test
    @DisplayName("should create a new instance with default values when access token is null")
    public void of_nullAccessToken_newInstanceCreatedWithDefaults() {
        TokenResponse result = TokenResponse.of(null, "refresh_token");

        assertThat(result).isNotNull();
        assertThat(result.accessToken()).isEqualTo("access_token");
        assertThat(result.refreshToken()).isEqualTo("refresh_token");
        assertThat(result.expiresIn()).isEqualTo(900);
        assertThat(result.tokenType()).isEqualTo("Bearer");
    }

    @Test
    @DisplayName("should create a new instance with default values when refresh token is null")
    public void of_nullRefreshToken_newInstanceCreatedWithDefaults() {
        TokenResponse result = TokenResponse.of("access_token", null);

        assertThat(result).isNotNull();
        assertThat(result.accessToken()).isEqualTo("access_token");
        assertThat(result.refreshToken()).isEqualTo("refresh_token");
        assertThat(result.expiresIn()).isEqualTo(900);
        assertThat(result.tokenType()).isEqualTo("Bearer");
    }

    @Test
    @DisplayName("should create a new instance with default values when access and refresh tokens are empty strings")
    public void of_emptyAccessAndRefreshTokens_newInstanceCreatedWithDefaults() {
        TokenResponse result = TokenResponse.of("", "");

        assertThat(result).isNotNull();
        assertThat(result.accessToken()).isEqualTo("access_token");
        assertThat(result.refreshToken()).isEqualTo("refresh_token");
        assertThat(result.expiresIn()).isEqualTo(900);
        assertThat(result.tokenType()).isEqualTo("Bearer");
    }

    @Test
    @DisplayName("should create a new instance with default values when access token is empty string")
    public void of_emptyAccessToken_newInstanceCreatedWithDefaults() {
        TokenResponse result = TokenResponse.of("", "refresh_token");

        assertThat(result).isNotNull();
        assertThat(result.accessToken()).isEqualTo("access_token");
        assertThat(result.refreshToken()).isEqualTo("refresh_token");
        assertThat(result.expiresIn()).isEqualTo(900);
        assertThat(result.tokenType()).isEqualTo("Bearer");
    }

    @Test
    @DisplayName("should create a new instance with default values when refresh token is empty string")
    public void of_emptyRefreshToken_newInstanceCreatedWithDefaults() {
        TokenResponse result = TokenResponse.of("access_token", "");

        assertThat(result).isNotNull();
        assertThat(result.accessToken()).isEqualTo("access_token");
        assertThat(result.refreshToken()).isEqualTo("refresh_token");
        assertThat(result.expiresIn()).isEqualTo(900);
        assertThat(result.tokenType()).isEqualTo("Bearer");
    }
}

