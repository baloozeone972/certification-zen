// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/user/UpdateUserPreferencesUseCaseImpl.java
package com.certifapp.application.usecase.user;

import com.certifapp.domain.exception.UserNotFoundException;
import com.certifapp.domain.model.user.UserPreferences;
import com.certifapp.domain.port.input.user.UpdateUserPreferencesUseCase;
import com.certifapp.domain.port.output.UserPreferencesRepository;
import com.certifapp.domain.port.output.UserRepository;

/**
 * Implementation of {@link UpdateUserPreferencesUseCase}.
 *
 * <p>Applies a partial update — only non-null fields in the command are changed.</p>
 */
public class UpdateUserPreferencesUseCaseImpl implements UpdateUserPreferencesUseCase {

    private final UserRepository userRepository;
    private final UserPreferencesRepository preferencesRepository;

    public UpdateUserPreferencesUseCaseImpl(
            UserRepository userRepository,
            UserPreferencesRepository preferencesRepository) {
        this.userRepository = userRepository;
        this.preferencesRepository = preferencesRepository;
    }

    @Override
    public UserPreferences execute(UpdatePreferencesCommand command) {
        // Verify user exists
        userRepository.findById(command.userId())
                .orElseThrow(() -> new UserNotFoundException(command.userId().toString()));

        UserPreferences current = preferencesRepository.findByUserId(command.userId())
                .orElseGet(() -> UserPreferences.defaultsFor(command.userId()));

        // Apply partial update (null = keep current value)
        UserPreferences updated = new UserPreferences(
                command.userId(),
                command.theme() != null ? command.theme() : current.theme(),
                command.language() != null ? command.language() : current.language(),
                command.defaultMode() != null ? command.defaultMode() : current.defaultMode(),
                command.notificationsEnabled() != null ? command.notificationsEnabled() : current.notificationsEnabled(),
                current.lastCertificationId(),
                current.freeModeQuestionCount(),
                current.freeModeDurationMin()
        );

        return preferencesRepository.save(updated);
    }
}
