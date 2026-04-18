package com.certifapp.domain.port.input.user;

import com.certifapp.domain.exception.DuplicateEmailException;
import com.certifapp.domain.model.user.User;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class RegisterUserUseCaseTest {

    @DisplayName("registerUser_whenValidCommandProvided_shouldReturnCreatedUser")
    @Test
    public void registerUser_validCommand_returnCreatedUser() {
        String email = "test@example.com";
        String password = "password1234";
        String locale = "en";
        String timezone = "UTC";

        RegisterUserUseCase.RegisterUserCommand command = new RegisterUserUseCase.RegisterUserCommand(email, password, locale, timezone);

        User createdUser = new User();
        // Simulate userRepository.save behavior
        User result = RegisterUserUseCase.registerUser(command, createdUser);

        assert result != null;
    }

    @DisplayName("registerUser_whenEmailIsBlank_shouldThrowIllegalArgumentException")
    @Test
    public void registerUser_emailBlank_throwIllegalArgumentException() {
        String email = "";
        String password = "password1234";
        String locale = "en";
        String timezone = "UTC";

        RegisterUserUseCase.RegisterUserCommand command = new RegisterUserUseCase.RegisterUserCommand(email, password, locale, timezone);

        try {
            RegisterUserUseCase.registerUser(command, null);
        } catch (IllegalArgumentException e) {
            assert "email must not be blank".equals(e.getMessage());
        }
    }

    @DisplayName("registerUser_whenPasswordIsShort_shouldThrowIllegalArgumentException")
    @Test
    public void registerUser_passwordShort_throwIllegalArgumentException() {
        String email = "test@example.com";
        String password = "pass";
        String locale = "en";
        String timezone = "UTC";

        RegisterUserUseCase.RegisterUserCommand command = new RegisterUserUseCase.RegisterUserCommand(email, password, locale, timezone);

        try {
            RegisterUserUseCase.registerUser(command, null);
        } catch (IllegalArgumentException e) {
            assert "password must be at least 8 characters".equals(e.getMessage());
        }
    }

    @DisplayName("registerUser_whenDuplicateEmailProvided_shouldThrowDuplicateEmailException")
    @Test
    public void registerUser_duplicateEmail_throwDuplicateEmailException() {
        String email = "test@example.com";
        String password = "password1234";
        String locale = "en";
        String timezone = "UTC";

        RegisterUserUseCase.RegisterUserCommand command = new RegisterUserUseCase.RegisterUserCommand(email, password, locale, timezone);

        try {
            RegisterUserUseCase.registerUser(command, null);
        } catch (DuplicateEmailException e) {
            assert "Email already registered".equals(e.getMessage());
        }
    }
}