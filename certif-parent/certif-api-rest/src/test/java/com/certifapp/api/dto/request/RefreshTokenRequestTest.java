package com.certifapp.api.dto.request;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.assertj.core.api.Assertions;

@ExtendWith(MockitoExtension.class)
public class RefreshTokenRequestTest {

    @InjectMocks
    private RefreshTokenRequest request;

    @Mock
    private String refreshToken;

    @BeforeEach
    public void setUp() {
        request = new RefreshTokenRequest("validRefreshToken");
    }

    @DisplayName("Nominal case: Valid refresh token is set")
    @Test
    public void testValidRefreshToken() {
        Assertions.assertThat(request.refreshToken()).isEqualTo("validRefreshToken");
    }

    @DisplayName("Edge case: Empty refresh token is not allowed")
    @Test
    public void testEmptyRefreshToken() {
        Assertions.assertThatExceptionOfType(NullPointerException.class)
                .isThrownBy(() -> new RefreshTokenRequest(""));
    }

    @DisplayName("Error case: Null refresh token is not allowed")
    @Test
    public void testNullRefreshToken() {
        Assertions.assertThatExceptionOfType(NullPointerException.class)
                .isThrownBy(() -> new RefreshTokenRequest(null));
    }
}
