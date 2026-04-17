// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/user/RegisterUserUseCase.java
package com.certifapp.domain.port.input.user;

import com.certifapp.domain.model.user.User;

/**
 * Use case: register a new user account.
 */
public interface RegisterUserUseCase {

    /**
     * @param command registration data
     * @return the created {@link User} (without passwordHash exposed)
     * @throws com.certifapp.domain.exception.DuplicateEmailException if email already registered
     */
    User execute(RegisterUserCommand command);

    /**
     * Registration command.
     *
     * @param email    user email address (will be lowercased)
     * @param password plain-text password (hashed by the implementation)
     * @param locale   BCP-47 locale (e.g. "fr", "en")
     * @param timezone IANA timezone (e.g. "Europe/Paris")
     */
    record RegisterUserCommand(String email, String password, String locale, String timezone) {
        public RegisterUserCommand {
            if (email == null || email.isBlank())
                throw new IllegalArgumentException("email must not be blank");
            if (password == null || password.length() < 8)
                throw new IllegalArgumentException("password must be at least 8 characters");
        }
    }
}
