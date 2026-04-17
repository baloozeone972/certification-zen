package com.certifapp.domain.port.output;

import com.certifapp.domain.model.user.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserRepositoryTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserRepositoryImpl userRepositoryImpl;

    @BeforeEach
    public void setUp() {
        // Initialization code, if any
    }

    @AfterEach
    public void tearDown() {
        reset(userRepository);
    }

    @Test
    @DisplayName("findById_nominalCase_userFound")
    public void findById_nominalCase_userFound() {
        UUID userId = UUID.randomUUID();
        User user = new User(userId, "test@example.com", "Test User");
        when(userRepository.findById(userId)).thenReturn(Optional.of(user));

        Optional<User> result = userRepositoryImpl.findById(userId);

        assertThat(result).isPresent().containsSame(user);
        verify(userRepository, times(1)).findById(userId);
    }

    @Test
    @DisplayName("findById_edgeCase_userNotFound")
    public void findById_edgeCase_userNotFound() {
        UUID userId = UUID.randomUUID();
        when(userRepository.findById(userId)).thenReturn(Optional.empty());

        Optional<User> result = userRepositoryImpl.findById(userId);

        assertThat(result).isEmpty();
        verify(userRepository, times(1)).findById(userId);
    }

    @Test
    @DisplayName("findByEmail_nominalCase_userFound")
    public void findByEmail_nominalCase_userFound() {
        String email = "test@example.com";
        User user = new User(UUID.randomUUID(), email, "Test User");
        when(userRepository.findByEmail(email)).thenReturn(Optional.of(user));

        Optional<User> result = userRepositoryImpl.findByEmail(email);

        assertThat(result).isPresent().containsSame(user);
        verify(userRepository, times(1)).findByEmail(email);
    }

    @Test
    @DisplayName("findByEmail_edgeCase_userNotFound")
    public void findByEmail_edgeCase_userNotFound() {
        String email = "test@example.com";
        when(userRepository.findByEmail(email)).thenReturn(Optional.empty());

        Optional<User> result = userRepositoryImpl.findByEmail(email);

        assertThat(result).isEmpty();
        verify(userRepository, times(1)).findByEmail(email);
    }

    @Test
    @DisplayName("existsByEmail_nominalCase_userExists")
    public void existsByEmail_nominalCase_userExists() {
        String email = "test@example.com";
        when(userRepository.existsByEmail(email)).thenReturn(true);

        boolean result = userRepositoryImpl.existsByEmail(email);

        assertThat(result).isTrue();
        verify(userRepository, times(1)).existsByEmail(email);
    }

    @Test
    @DisplayName("existsByEmail_edgeCase_userDoesNotExist")
    public void existsByEmail_edgeCase_userDoesNotExist() {
        String email = "test@example.com";
        when(userRepository.existsByEmail(email)).thenReturn(false);

        boolean result = userRepositoryImpl.existsByEmail(email);

        assertThat(result).isFalse();
        verify(userRepository, times(1)).existsByEmail(email);
    }

    @Test
    @DisplayName("save_nominalCase_userSaved")
    public void save_nominalCase_userSaved() {
        User user = new User(UUID.randomUUID(), "test@example.com", "Test User");
        when(userRepository.save(any(User.class))).thenReturn(user);

        User result = userRepositoryImpl.save(user);

        assertThat(result).isEqualToComparingFieldByField(user);
        verify(userRepository, times(1)).save(any(User.class));
    }

    @Test
    @DisplayName("deleteById_nominalCase_userDeleted")
    public void deleteById_nominalCase_userDeleted() {
        UUID userId = UUID.randomUUID();
        userRepositoryImpl.deleteById(userId);

        verify(userRepository, times(1)).deleteById(userId);
    }
}

