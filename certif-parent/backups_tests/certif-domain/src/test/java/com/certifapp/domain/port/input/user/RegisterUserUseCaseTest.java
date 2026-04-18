package com.certifapp.domain.port.input.user;

import com.certifapp.domain.exception.DuplicateEmailException;
import com.certifapp.domain.model.user.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class RegisterUserUseCaseTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private RegisterUserUseCase registerUserUseCase;

    @BeforeEach
    public void setUp() {
        // Initialize any mocks or setup here if needed
    }

    @DisplayName("registerUser_whenValidCommandProvided_shouldReturnCreatedUser")
    @Test
    public void registerUser_validCommand_returnCreatedUser() throws DuplicateEmailException {
        String email = "test@example.com";
        String password = "password1234";
        String locale = "en";
        String timezone = "UTC";

        RegisterUserUseCase.RegisterUserCommand command = new RegisterUserUseCase.RegisterUserCommand(email, password, locale, timezone);

        User createdUser = new User();
        when(userRepository.save(any(User.class))).thenReturn(createdUser);

        User result = registerUserUseCase.execute(command);

        assertThat(result).isNotNull();
        verify(userRepository, times(1)).save(any(User.class));
    }

    @DisplayName("registerUser_whenEmailIsBlank_shouldThrowIllegalArgumentException")
    @Test
    public void registerUser_emailBlank_throwIllegalArgumentException() {
        String email = "";
        String password = "password1234";
        String locale = "en";
        String timezone = "UTC";

        RegisterUserUseCase.RegisterUserCommand command = new RegisterUserUseCase.RegisterUserCommand(email, password, locale, timezone);

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            registerUserUseCase.execute(command);
        });

        assertThat(exception.getMessage()).isEqualTo("email must not be blank");
    }

    @DisplayName("registerUser_whenPasswordIsShort_shouldThrowIllegalArgumentException")
    @Test
    public void registerUser_passwordShort_throwIllegalArgumentException() {
        String email = "test@example.com";
        String password = "pass";
        String locale = "en";
        String timezone = "UTC";

        RegisterUserUseCase.RegisterUserCommand command = new RegisterUserUseCase.RegisterUserCommand(email, password, locale, timezone);

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            registerUserUseCase.execute(command);
        });

        assertThat(exception.getMessage()).isEqualTo("password must be at least 8 characters");
    }

    @DisplayName("registerUser_whenDuplicateEmailProvided_shouldThrowDuplicateEmailException")
    @Test
    public void registerUser_duplicateEmail_throwDuplicateEmailException() throws DuplicateEmailException {
        String email = "test@example.com";
        String password = "password1234";
        String locale = "en";
        String timezone = "UTC";

        RegisterUserUseCase.RegisterUserCommand command = new RegisterUserUseCase.RegisterUserCommand(email, password, locale, timezone);

        when(userRepository.save(any(User.class))).thenThrow(new DuplicateEmailException("Email already registered"));

        assertThrows(DuplicateEmailException.class, () -> {
            registerUserUseCase.execute(command);
        });
    }
}

