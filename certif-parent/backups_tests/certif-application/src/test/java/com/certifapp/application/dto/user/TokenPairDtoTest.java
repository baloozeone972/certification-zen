package com.certifapp.application.dto.user;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class TokenPairDtoTest {

    @BeforeEach
    public void setUp() {
        // No setup required for this test case as no mocks or dependencies are used
    }

    @DisplayName("Test nominal case of TokenPairDto creation")
    @Test
    public void createTokenPairDto_nominalCase() {
        String accessToken = "exampleAccessToken";
        String refreshToken = "exampleRefreshToken";

        TokenPairDto tokenPairDto = TokenPairDto.of(accessToken, refreshToken);

        assertThat(tokenPairDto.accessToken()).isEqualTo(accessToken);
        assertThat(tokenPairDto.refreshToken()).isEqualTo(refreshToken);
        assertThat(tokenPairDto.expiresIn()).isEqualTo(900);
        assertThat(tokenPairDto.tokenType()).isEqualTo("Bearer");
    }

    @DisplayName("Test edge case of TokenPairDto creation with empty access token")
    @Test
    public void createTokenPairDto_edgeCaseEmptyAccessToken() {
        String accessToken = "";
        String refreshToken = "exampleRefreshToken";

        assertThrows(NullPointerException.class, () -> TokenPairDto.of(accessToken, refreshToken));
    }

    @DisplayName("Test edge case of TokenPairDto creation with empty refresh token")
    @Test
    public void createTokenPairDto_edgeCaseEmptyRefreshToken() {
        String accessToken = "exampleAccessToken";
        String refreshToken = "";

        assertThrows(NullPointerException.class, () -> TokenPairDto.of(accessToken, refreshToken));
    }

    @DisplayName("Test error case of TokenPairDto creation with null access token")
    @Test
    public void createTokenPairDto_errorCaseNullAccessToken() {
        String accessToken = null;
        String refreshToken = "exampleRefreshToken";

        assertThrows(NullPointerException.class, () -> TokenPairDto.of(accessToken, refreshToken));
    }

    @DisplayName("Test error case of TokenPairDto creation with null refresh token")
    @Test
    public void createTokenPairDto_errorCaseNullRefreshToken() {
        String accessToken = "exampleAccessToken";
        String refreshToken = null;

        assertThrows(NullPointerException.class, () -> TokenPairDto.of(accessToken, refreshToken));
    }

    @DisplayName("Verify no interactions with mocks")
    @Test
    public void verifyNoInteractionsWithMocks() {
        // No mocks to interact with in this test case
        verifyNoInteractions(mockTokenService);
    }
}

