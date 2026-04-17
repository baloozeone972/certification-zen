// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/UserRepository.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.user.User;

import java.util.Optional;
import java.util.UUID;

/**
 * Output port: persistence operations for {@link User}.
 */
public interface UserRepository {
    Optional<User> findById(UUID id);

    Optional<User> findByEmail(String email);

    boolean existsByEmail(String email);

    User save(User user);

    void deleteById(UUID id);
}
