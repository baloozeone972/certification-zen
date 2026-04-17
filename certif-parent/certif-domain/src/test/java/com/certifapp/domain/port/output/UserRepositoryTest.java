package com.certifapp.domain.port.output;

import com.certifapp.domain.model.user.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

public class UserRepositoryTest {

    @BeforeEach
    public void setUp() {
        // Initialization code, if any
    }

    @AfterEach
    public void tearDown() {
        // No need to reset mocks in this test class
    }

    @Test
    @DisplayName("findById_nominalCase_userFound")
    public void findById_nominalCase_userFound() {
        UUID userId = UUID.randomUUID();
        User user = new User(userId, "test@example.com", "Test User");

        Optional<User> result = userRepository.findById(userId);

        assertThat(result).isPresent().containsSame(user);
    }

    @Test
    @DisplayName("findById_edgeCase_userNotFound")
    public void findById_edgeCase_userNotFound() {
        UUID userId = UUID.randomUUID();

        Optional<User> result = userRepository.findById(userId);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("findByEmail_nominalCase_userFound")
    public void findByEmail_nominalCase_userFound() {
        String email = "test@example.com";
        User user = new User(UUID.randomUUID(), email, "Test User");

        Optional<User> result = userRepository.findByEmail(email);

        assertThat(result).isPresent().containsSame(user);
    }

    @Test
    @DisplayName("findByEmail_edgeCase_userNotFound")
    public void findByEmail_edgeCase_userNotFound() {
        String email = "test@example.com";

        Optional<User> result = userRepository.findByEmail(email);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("existsByEmail_nominalCase_userExists")
    public void existsByEmail_nominalCase_userExists() {
        String email = "test@example.com";

        boolean result = userRepository.existsByEmail(email);

        assertThat(result).isTrue();
    }

    @Test
    @DisplayName("existsByEmail_edgeCase_userDoesNotExist")
    public void existsByEmail_edgeCase_userDoesNotExist() {
        String email = "test@example.com";

        boolean result = userRepository.existsByEmail(email);

        assertThat(result).isFalse();
    }

    @Test
    @DisplayName("save_nominalCase_userSaved")
    public void save_nominalCase_userSaved() {
        User user = new User(UUID.randomUUID(), "test@example.com", "Test User");

        User result = userRepository.save(user);

        assertThat(result).isEqualToComparingFieldByField(user);
    }

    @Test
    @DisplayName("deleteById_nominalCase_userDeleted")
    public void deleteById_nominalCase_userDeleted() {
        UUID userId = UUID.randomUUID();
        userRepository.deleteById(userId);
    }
}