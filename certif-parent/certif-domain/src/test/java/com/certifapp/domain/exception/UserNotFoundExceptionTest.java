package com.certifapp.domain.exception;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class UserNotFoundExceptionTest {

    @DisplayName("UserNotFoundException should be thrown with identifier")
    @Test
    public void userNotFoundException_throwsExceptionWithIdentifier() {
        String identifier = "user123";

        assertThatThrownBy(() -> new UserNotFoundException(identifier))
                .isInstanceOf(UserNotFoundException.class)
                .hasMessage("User not found: " + identifier);
    }
}