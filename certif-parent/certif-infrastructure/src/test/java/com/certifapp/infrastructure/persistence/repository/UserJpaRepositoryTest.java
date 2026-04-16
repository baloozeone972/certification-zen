```java
package com.certifapp.infrastructure.persistence.repository;

import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.*;

import com.certifapp.infrastructure.persistence.entity.UserEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import java.util.Optional;
import java.util.UUID;

@ExtendWith(MockitoExtension.class)
public class UserJpaRepositoryTest {

    @Mock
    private JpaRepository<UserEntity, UUID> jpaRepository;

    @InjectMocks
    private UserJpaRepository userJpaRepository;

    @BeforeEach
    public void setUp() {
        when(jpaRepository.findByEmail(anyString())).thenReturn(Optional.empty());
        when(jpaRepository.existsByEmail(anyString())).thenReturn(false);
    }

    @Test
    @DisplayName("Should find a user by email")
    public void findByEmail_UserExists_ShouldReturnUser() {
        UUID userId = UUID.randomUUID();
        String userEmail = "test@example.com";
        UserEntity user = new UserEntity(userId, userEmail, "password");

        when(jpaRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));

        Optional<UserEntity> result = userJpaRepository.findByEmail(userEmail);

        assertThat(result).isPresent().contains(user);
    }

    @Test
    @DisplayName("Should return empty Optional if no user exists with the given email")
    public void findByEmail_UserDoesNotExist_ShouldReturnEmptyOptional() {
        String nonExistentEmail = "nonexistent@example.com";

        Optional<UserEntity> result = userJpaRepository.findByEmail(nonExistentEmail);

        assertThat(result).isNotPresent();
    }

    @Test
    @DisplayName("Should return true if a user exists with the given email")
    public void existsByEmail_UserExists_ShouldReturnTrue() {
        UUID userId = UUID.randomUUID();
        String userEmail = "test@example.com";
        UserEntity user = new UserEntity(userId, userEmail, "password");

        when(jpaRepository.existsByEmail(userEmail)).thenReturn(true);

        boolean result = userJpaRepository.existsByEmail(userEmail);

        assertThat(result).isTrue();
    }

    @Test
    @DisplayName("Should return false if no user exists with the given email")
    public void existsByEmail_UserDoesNotExist_ShouldReturnFalse() {
        String nonExistentEmail = "nonexistent@example.com";

        boolean result = userJpaRepository.existsByEmail(nonExistentEmail);

        assertThat(result).isFalse();
    }

    @AfterEach
    public void tearDown() {
        verify(jpaRepository, times(1)).findByEmail(anyString());
        verify(jpaRepository, times(1)).existsByEmail(anyString());
    }
}
```
