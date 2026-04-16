// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/user/RegisterUserUseCaseImpl.java
package com.certifapp.application.usecase.user;

import com.certifapp.domain.exception.DuplicateEmailException;
import com.certifapp.domain.model.user.*;
import com.certifapp.domain.port.input.user.RegisterUserUseCase;
import com.certifapp.domain.port.output.UserPreferencesRepository;
import com.certifapp.domain.port.output.UserRepository;

import java.time.OffsetDateTime;
import java.util.UUID;
import java.util.function.Function;

/**
 * Implementation of {@link RegisterUserUseCase}.
 *
 * <p>The {@code passwordEncoder} function is injected to decouple the domain from
 * BCrypt (which lives in certif-infrastructure). This keeps certif-application
 * framework-free.</p>
 */
public class RegisterUserUseCaseImpl implements RegisterUserUseCase {

    private final UserRepository            userRepository;
    private final UserPreferencesRepository preferencesRepository;
    /** BCrypt encoder injected from infrastructure — avoids Spring Security in domain. */
    private final Function<String, String>  passwordEncoder;

    public RegisterUserUseCaseImpl(
            UserRepository            userRepository,
            UserPreferencesRepository preferencesRepository,
            Function<String, String>  passwordEncoder) {
        this.userRepository       = userRepository;
        this.preferencesRepository = preferencesRepository;
        this.passwordEncoder      = passwordEncoder;
    }

    @Override
    public User execute(RegisterUserCommand command) {
        if (userRepository.existsByEmail(command.email())) {
            throw new DuplicateEmailException(command.email());
        }

        String hash = passwordEncoder.apply(command.password());

        String locale   = (command.locale()   != null && !command.locale().isBlank())
                ? command.locale()   : User.DEFAULT_LOCALE;
        String timezone = (command.timezone() != null && !command.timezone().isBlank())
                ? command.timezone() : User.DEFAULT_TIMEZONE;

        OffsetDateTime now = OffsetDateTime.now();
        User newUser = new User(
                UUID.randomUUID(), command.email(), hash,
                UserRole.USER, SubscriptionTier.FREE,
                locale, timezone, null, true, now, now);

        User saved = userRepository.save(newUser);

        // Create default preferences
        UserPreferences prefs = UserPreferences.defaultsFor(saved.id());
        preferencesRepository.save(prefs);

        return saved;
    }
}
