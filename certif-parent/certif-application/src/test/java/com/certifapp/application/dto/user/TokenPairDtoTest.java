package com.certifapp.application.dto.user;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.verifyNoInteractions;

public class TokenPairDtoTest {

    @Mock
    private TokenService mockTokenService;

    @InjectMocks
    private TokenPairDto tokenPairDto;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
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