// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/UserPreferencesRepository.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.user.UserPreferences;
import java.util.Optional;
import java.util.UUID;

/** Output port: persistence of user preferences. */
public interface UserPreferencesRepository {
    Optional<UserPreferences> findByUserId(UUID userId);
    UserPreferences            save(UserPreferences preferences);
}
