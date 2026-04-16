// certif-parent/certif-api-rest/src/test/java/com/certifapp/api/security/JwtTokenProviderTest.java
package com.certifapp.api.security;

import io.jsonwebtoken.JwtException;
import org.junit.jupiter.api.*;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;

/**
 * Unit tests for {@link JwtTokenProvider}.
 */
@DisplayName("JwtTokenProvider")
class JwtTokenProviderTest {

    private JwtTokenProvider tokenProvider;
    private static final UUID USER_ID = UUID.randomUUID();
    // 64-char secret (512 bits) — safe for HS256
    private static final String SECRET =
            "test_jwt_secret_256_bits_minimum_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

    @BeforeEach
    void setUp() {
        tokenProvider = new JwtTokenProvider(SECRET, 900L, 604800L);
    }

    @Test
    @DisplayName("Access token is valid and contains user UUID")
    void generateAccessToken_shouldBeValidAndContainUserId() {
        String token = tokenProvider.generateAccessToken(USER_ID, "USER");

        assertThat(token).isNotBlank();
        assertThat(tokenProvider.isAccessToken(token)).isTrue();
        assertThat(tokenProvider.extractUserId(token)).isEqualTo(USER_ID);
    }

    @Test
    @DisplayName("Refresh token is NOT an access token")
    void generateRefreshToken_shouldNotBeAccessToken() {
        String token = tokenProvider.generateRefreshToken(USER_ID);

        assertThat(token).isNotBlank();
        assertThat(tokenProvider.isAccessToken(token)).isFalse();
        assertThat(tokenProvider.extractUserId(token)).isEqualTo(USER_ID);
    }

    @Test
    @DisplayName("Role claim is present in access token")
    void accessToken_shouldContainRoleClaim() {
        String token = tokenProvider.generateAccessToken(USER_ID, "ADMIN");

        var claims = tokenProvider.validateAndGetClaims(token);
        assertThat(claims.get("role", String.class)).isEqualTo("ADMIN");
    }

    @Test
    @DisplayName("Tampered token throws JwtException")
    void tamperedToken_shouldThrowJwtException() {
        String token = tokenProvider.generateAccessToken(USER_ID, "USER");
        String tampered = token.substring(0, token.length() - 5) + "XXXXX";

        assertThatThrownBy(() -> tokenProvider.validateAndGetClaims(tampered))
                .isInstanceOf(JwtException.class);
    }

    @Test
    @DisplayName("Expired token throws JwtException")
    void expiredToken_shouldThrowJwtException() {
        // Token with 0-second expiry
        JwtTokenProvider shortProvider = new JwtTokenProvider(SECRET, -1L, -1L);
        String token = shortProvider.generateAccessToken(USER_ID, "USER");

        assertThatThrownBy(() -> tokenProvider.validateAndGetClaims(token))
                .isInstanceOf(JwtException.class);
    }
}
