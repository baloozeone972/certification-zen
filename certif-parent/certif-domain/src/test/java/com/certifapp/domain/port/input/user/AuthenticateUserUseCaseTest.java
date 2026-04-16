```java
package com.certifapp.domain.port.input.user;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import com.certifapp.domain.exception.InvalidCredentialsException;
import com.certifapp.domain.model.user.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class AuthenticateUserUseCaseTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private AuthenticateUserUseCase authenticateUserUseCase;

    @BeforeEach
    public void setUp() {
        // Setup common mock behaviors if needed
    }

    @Test
    @DisplayName("nominal case: authenticate a valid user")
    public void authenticateUser_validCredentials_UserReturned() throws InvalidCredentialsException {
        String email = "test@example.com";
        String password = "password123";
        User expectedUser = new User(email, "hashedPassword");

        when(userRepository.findByEmail(email)).thenReturn(expectedUser);
        when(passwordEncoder.matches(anyString(), anyString())).thenReturn(true);

        User authenticatedUser = authenticateUserUseCase.execute(email, password);

        assertThat(authenticatedUser).isEqualTo(expectedUser);
    }

    @Test
    @DisplayName("edge case: user not found")
    public void authenticateUser_userNotFound_InvalidCredentialsException() throws InvalidCredentialsException {
        String email = "test@example.com";
        String password = "password123";

        when(userRepository.findByEmail(email)).thenReturn(null);

        assertThatThrownBy(() -> authenticateUserUseCase.execute(email, password))
                .isInstanceOf(InvalidCredentialsException.class)
                .hasMessage("Invalid credentials");
    }

    @Test
    @DisplayName("edge case: invalid password")
    public void authenticateUser_invalidPassword_InvalidCredentialsException() throws InvalidCredentialsException {
        String email = "test@example.com";
        String password = "wrongpassword";
        User expectedUser = new User(email, "hashedPassword");

        when(userRepository.findByEmail(email)).thenReturn(expectedUser);
        when(passwordEncoder.matches(anyString(), anyString())).thenReturn(false);

        assertThatThrownBy(() -> authenticateUserUseCase.execute(email, password))
                .isInstanceOf(InvalidCredentialsException.class)
                .hasMessage("Invalid credentials");
    }
}
```
