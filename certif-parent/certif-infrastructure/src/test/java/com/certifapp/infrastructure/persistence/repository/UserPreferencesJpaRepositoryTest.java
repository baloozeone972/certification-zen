package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.UserPreferencesEntity;
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
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserPreferencesJpaRepositoryTest {

    @Mock
    private JpaRepository<UserPreferencesEntity, UUID> jpaRepository;

    @InjectMocks
    private UserPreferencesJpaRepository userPreferencesJpaRepository;

    @BeforeEach
    public void setUp() {
        // Initialize mocks or reset them if necessary
    }

    @DisplayName("should save user preferences")
    @Test
    public void saveUserPreferences_nominalCase_expectedBehavior() {
        // Arrange
        UserPreferencesEntity userPreferences = new UserPreferencesEntity();
        userPreferences.setId(UUID.randomUUID());

        when(jpaRepository.save(userPreferences)).thenReturn(userPreferences);

        // Act
        UserPreferencesEntity result = userPreferencesJpaRepository.save(userPreferences);

        // Assert
        assertThat(result).isNotNull();
        verify(jpaRepository, times(1)).save(userPreferences);
    }

    @DisplayName("should find user preferences by ID")
    @Test
    public void findById_nominalCase_expectedBehavior() {
        // Arrange
        UUID id = UUID.randomUUID();
        UserPreferencesEntity userPreferences = new UserPreferencesEntity();
        userPreferences.setId(id);

        when(jpaRepository.findById(id)).thenReturn(Optional.of(userPreferences));

        // Act
        Optional<UserPreferencesEntity> result = userPreferencesJpaRepository.findById(id);

        // Assert
        assertThat(result).isPresent().get().isEqualTo(userPreferences);
        verify(jpaRepository, times(1)).findById(id);
    }

    @DisplayName("should return empty when finding non-existing user preferences by ID")
    @Test
    public void findById_edgeCase_expectedBehavior() {
        // Arrange
        UUID id = UUID.randomUUID();

        when(jpaRepository.findById(id)).thenReturn(Optional.empty());

        // Act
        Optional<UserPreferencesEntity> result = userPreferencesJpaRepository.findById(id);

        // Assert
        assertThat(result).isNotPresent();
        verify(jpaRepository, times(1)).findById(id);
    }

    @DisplayName("should delete user preferences by ID")
    @Test
    public void deleteById_nominalCase_expectedBehavior() {
        // Arrange
        UUID id = UUID.randomUUID();

        // Act
        userPreferencesJpaRepository.deleteById(id);

        // Assert
        verify(jpaRepository, times(1)).deleteById(id);
    }

    @DisplayName("should delete all user preferences")
    @Test
    public void deleteAll_nominalCase_expectedBehavior() {
        // Arrange

        // Act
        userPreferencesJpaRepository.deleteAll();

        // Assert
        verify(jpaRepository, times(1)).deleteAll();
    }
}
