package com.certifapp.api.controller;

import com.certifapp.api.dto.request.LoginRequest;
import com.certifapp.api.dto.request.RefreshTokenRequest;
import com.certifapp.api.dto.request.RegisterRequest;
import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.api.dto.response.TokenResponse;
import com.certifapp.domain.model.user.User;
import com.certifapp.domain.port.input.user.AuthenticateUserUseCase;
import com.certifapp.domain.port.input.user.RegisterUserUseCase;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.anyString;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class AuthControllerTest {

    @Mock
    private RegisterUserUseCase registerUseCase;

    @Mock
    private AuthenticateUserUseCase authUseCase;

    @Mock
    private JwtTokenProvider tokenProvider;

    @InjectMocks
    private AuthController authController;

    @BeforeEach
    public void setUp() {
        // Initialization code if needed
    }

    @Test
    @DisplayName("register_userRegistered_success")
    public void testRegisterUser_Registered_Success() {
        RegisterRequest request = new RegisterRequest("test@example.com", "password", "en", "UTC");
        User user = new User(1L, "USER");
        TokenResponse tokens = new TokenResponse("access_token", "refresh_token");

        when(registerUseCase.execute(any(RegisterUserUseCase.RegisterUserCommand.class))).thenReturn(user);
        when(tokenProvider.generateAccessToken(any(Long.class), any(String.class))).thenReturn(tokens.getAccess());
        when(tokenProvider.generateRefreshToken(any(Long.class))).thenReturn(tokens.getRefresh());

        ResponseEntity<ApiResponse<TokenResponse>> response = authController.register(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.CREATED);
        assertThat(response.getBody().getStatus()).isEqualTo("success");
        assertThat(response.getBody().getData()).isEqualTo(tokens);
    }

    @Test
    @DisplayName("register_userRegistrationFails_error")
    public void testRegisterUser_Registration_Fails_Error() {
        RegisterRequest request = new RegisterRequest("test@example.com", "password", "en", "UTC");

        when(registerUseCase.execute(any(RegisterUserUseCase.RegisterUserCommand.class))).thenThrow(new RuntimeException("Error"));

        ResponseEntity<ApiResponse<TokenResponse>> response = authController.register(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @Test
    @DisplayName("login_userAuthenticated_success")
    public void testLogin_User_Authenticated_Success() {
        LoginRequest request = new LoginRequest("test@example.com", "password");
        User user = new User(1L, "USER");

        when(authUseCase.execute(anyString(), anyString())).thenReturn(user);
        when(tokenProvider.generateAccessToken(any(Long.class), any(String.class))).thenReturn("access_token");
        when(tokenProvider.generateRefreshToken(any(Long.class))).thenReturn("refresh_token");

        ResponseEntity<ApiResponse<TokenResponse>> response = authController.login(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody().getStatus()).isEqualTo("success");
    }

    @Test
    @DisplayName("login_userAuthenticationFails_error")
    public void testLogin_User_Authentication_Fails_Error() {
        LoginRequest request = new LoginRequest("test@example.com", "password");

        when(authUseCase.execute(anyString(), anyString())).thenThrow(new RuntimeException("Error"));

        ResponseEntity<ApiResponse<TokenResponse>> response = authController.login(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @Test
    @DisplayName("refresh_tokenRefreshed_success")
    public void testRefresh_Token_Refreshed_Success() {
        RefreshTokenRequest request = new RefreshTokenRequest("refresh_token");
        Long userId = 1L;
        String accessToken = "access_token";
        String refreshToken = "new_refresh_token";

        when(tokenProvider.extractUserId(anyString())).thenReturn(userId);
        when(tokenProvider.generateAccessToken(any(Long.class), any(String.class))).thenReturn(accessToken);
        when(tokenProvider.generateRefreshToken(any(Long.class))).thenReturn(refreshToken);

        ResponseEntity<ApiResponse<TokenResponse>> response = authController.refresh(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody().getStatus()).isEqualTo("success");
    }

    @Test
    @DisplayName("refresh_tokenExpired_error")
    public void testRefresh_Token_Expired_Error() {
        RefreshTokenRequest request = new RefreshTokenRequest("expired_refresh_token");

        when(tokenProvider.extractUserId(anyString())).thenThrow(new RuntimeException("Invalid token"));

        ResponseEntity<ApiResponse<TokenResponse>> response = authController.refresh(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
    }
}
