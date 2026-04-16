// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/user/AuthenticateUserUseCaseImpl.java
package com.certifapp.application.usecase.user;

import com.certifapp.domain.exception.InvalidCredentialsException;
import com.certifapp.domain.model.user.User;
import com.certifapp.domain.port.input.user.AuthenticateUserUseCase;
import com.certifapp.domain.port.output.UserRepository;

import java.util.function.BiFunction;

/**
 * Implementation of {@link AuthenticateUserUseCase}.
 *
 * <p>The {@code passwordMatcher} function is injected from infrastructure
 * to compare a plain-text password against a BCrypt hash without coupling
 * the domain to Spring Security.</p>
 */
public class AuthenticateUserUseCaseImpl implements AuthenticateUserUseCase {

    private final UserRepository              userRepository;
    /** BCrypt matcher: (rawPassword, encodedHash) → matches. */
    private final BiFunction<String, String, Boolean> passwordMatcher;

    public AuthenticateUserUseCaseImpl(
            UserRepository                    userRepository,
            BiFunction<String, String, Boolean> passwordMatcher) {
        this.userRepository  = userRepository;
        this.passwordMatcher = passwordMatcher;
    }

    @Override
    public User execute(String email, String password) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(InvalidCredentialsException::new);

        if (!user.isActive()) {
            throw new InvalidCredentialsException();
        }

        boolean matches = passwordMatcher.apply(password, user.passwordHash());
        if (!matches) {
            throw new InvalidCredentialsException();
        }

        return user;
    }
}
