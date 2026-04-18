// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/user/UpdateUserPreferencesUseCaseImplTest.java
package com.certifapp.application.usecase.user;

import com.certifapp.domain.exception.UserNotFoundException;
import com.certifapp.domain.model.user.*;
import com.certifapp.domain.port.input.user.UpdateUserPreferencesUseCase.UpdatePreferencesCommand;
import com.certifapp.domain.port.output.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.*;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("UpdateUserPreferencesUseCaseImpl")
class UpdateUserPreferencesUseCaseImplTest {

    @Mock UserRepository            userRepository;
    @Mock UserPreferencesRepository preferencesRepository;
    @InjectMocks UpdateUserPreferencesUseCaseImpl useCase;

    private static final UUID USER_ID = UUID.randomUUID();

    private User buildUser() {
        return new User(USER_ID, "u@test.com", "$2a$12$h", UserRole.USER,
                SubscriptionTier.FREE, "fr", "Europe/Paris", null, true,
                OffsetDateTime.now(), OffsetDateTime.now());
    }

    private UserPreferences buildPrefs() {
        return UserPreferences.defaultsFor(USER_ID);
    }

    @Test @DisplayName("user not found → UserNotFoundException")
    void userNotFound_throws() {
        when(userRepository.findById(USER_ID)).thenReturn(Optional.empty());
        var cmd = new UpdatePreferencesCommand(USER_ID, "dark", "fr", "EXAM", true, null);
        assertThatThrownBy(() -> useCase.execute(cmd))
            .isInstanceOf(UserNotFoundException.class);
    }

    @Test @DisplayName("valid command — preferences saved and returned")
    void validCommand_preferencesUpdated() {
        when(userRepository.findById(USER_ID)).thenReturn(Optional.of(buildUser()));
        when(preferencesRepository.findByUserId(USER_ID)).thenReturn(Optional.of(buildPrefs()));
        when(preferencesRepository.save(any())).thenAnswer(i -> i.getArgument(0));

        var cmd = new UpdatePreferencesCommand(USER_ID, "dark", null, null, null, null);
        UserPreferences result = useCase.execute(cmd);

        assertThat(result.theme()).isEqualTo("dark");
        verify(preferencesRepository).save(any());
    }

    @Test @DisplayName("null fields in command keep existing values")
    void nullFields_keepExistingValues() {
        UserPreferences existing = buildPrefs();
        when(userRepository.findById(USER_ID)).thenReturn(Optional.of(buildUser()));
        when(preferencesRepository.findByUserId(USER_ID)).thenReturn(Optional.of(existing));
        when(preferencesRepository.save(any())).thenAnswer(i -> i.getArgument(0));

        var cmd = new UpdatePreferencesCommand(USER_ID, null, null, null, null, null);
        UserPreferences result = useCase.execute(cmd);

        assertThat(result.theme()).isEqualTo(existing.theme());
        assertThat(result.language()).isEqualTo(existing.language());
    }
}
