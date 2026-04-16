// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/user/AuthenticateUserUseCase.java
package com.certifapp.domain.port.input.user;

import com.certifapp.domain.model.user.User;

/**
 * Use case: authenticate a user with email and password, returning the matched User.
 *
 * <p>Token generation is handled by the API layer (certif-api-rest),
 * not by this use case.</p>
 */
public interface AuthenticateUserUseCase {
    /**
     * @param email    user email
     * @param password plain-text password (compared against BCrypt hash)
     * @return the authenticated {@link User}
     * @throws com.certifapp.domain.exception.InvalidCredentialsException if credentials invalid
     */
    User execute(String email, String password);
}
