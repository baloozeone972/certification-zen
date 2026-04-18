package com.certifapp.infrastructure.persistence.mapper;

import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.assertThat;

import java.util.Arrays;
import java.util.List;

import com.certifapp.domain.model.user.*;
import com.certifapp.infrastructure.persistence.entity.UserEntity;
import com.certifapp.infrastructure.persistence.entity.UserPreferencesEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class UserMapperTest {

    @Mock
    private UserRoleService userRoleService;

    @Mock
    private SubscriptionTierService subscriptionTierService;

    @InjectMocks
    private UserMapper userMapper;

    @BeforeEach
    public void setUp() {
        when(userRoleService.valueOf(anyString())).thenAnswer(invocation -> UserRole.valueOf(invocation.getArgument(0).toUpperCase()));
        when(subscriptionTierService.valueOf(anyString())).thenAnswer(invocation -> SubscriptionTier.valueOf(invocation.getArgument(0).toUpperCase()));
    }

    @Test
    @DisplayName("Converts UserEntity to domain model - nominal case")
    public void toDomain_NominalCase() {
        // Arrange
        UserEntity entity = new UserEntity();
        entity.setRole("ADMIN");
        entity.setSubscriptionTier("PREMIUM");

        // Act
        User domain = userMapper.toDomain(entity);

        // Assert
        assertThat(domain).isNotNull();
        assertThat(domain.role()).isEqualTo(UserRole.ADMIN);
        assertThat(domain.subscriptionTier()).isEqualTo(SubscriptionTier.PREMIUM);
    }

    @Test
    @DisplayName("Converts User to entity - nominal case")
    public void toEntity_NominalCase() {
        // Arrange
        User domain = new User();
        domain.setRole(UserRole.ADMIN);
        domain.setSubscriptionTier(SubscriptionTier.PREMIUM);

        // Act
        UserEntity entity = userMapper.toEntity(domain, true);

        // Assert
        assertThat(entity).isNotNull();
        assertThat(entity.getRole()).isEqualTo("ADMIN");
        assertThat(entity.getSubscriptionTier()).isEqualTo("PREMIUM");
    }

    @Test
    @DisplayName("Converts UserPreferencesEntity to domain model - nominal case")
    public void toDomain_Preferences_NominalCase() {
        // Arrange
        UserPreferencesEntity entity = new UserPreferencesEntity();
        entity.setTheme("DARK");
        entity.setDefaultMode("INTERACTIVE");

        // Act
        UserPreferences preferences = userMapper.toDomain(entity);

        // Assert
        assertThat(preferences).isNotNull();
        assertThat(preferences.theme()).isEqualTo(UiTheme.DARK);
        assertThat(preferences.defaultMode()).isEqualTo(ExamMode.INTERACTIVE);
    }

    @Test
    @DisplayName("Converts UserPreferences to entity - nominal case")
    public void toEntity_Preferences_NominalCase() {
        // Arrange
        UserPreferences preferences = new UserPreferences();
        preferences.setTheme(UiTheme.DARK);
        preferences.setDefaultMode(ExamMode.INTERACTIVE);

        // Act
        UserPreferencesEntity entity = userMapper.toEntity(preferences);

        // Assert
        assertThat(entity).isNotNull();
        assertThat(entity.getTheme()).isEqualTo("DARK");
        assertThat(entity.getDefaultMode()).isEqualTo("INTERACTIVE");
    }

    @Test
    @DisplayName("Converts UserEntity to domain model - edge case, role is null")
    public void toDomain_EdgeCase_RoleNull() {
        // Arrange
        UserEntity entity = new UserEntity();
        entity.setRole(null);
        entity.setSubscriptionTier("PREMIUM");

        // Act & Assert
        assertThrows(NullPointerException.class, () -> userMapper.toDomain(entity));
    }

    @Test
    @DisplayName("Converts UserEntity to domain model - edge case, subscriptionTier is null")
    public void toDomain_EdgeCase_SubscriptionTierNull() {
        // Arrange
        UserEntity entity = new UserEntity();
        entity.setRole("ADMIN");
        entity.setSubscriptionTier(null);

        // Act & Assert
        assertThrows(NullPointerException.class, () -> userMapper.toDomain(entity));
    }

    @Test
    @DisplayName("Converts UserPreferencesEntity to domain model - edge case, theme is null")
    public void toDomain_Preferences_EdgeCase_ThemeNull() {
        // Arrange
        UserPreferencesEntity entity = new UserPreferencesEntity();
        entity.setTheme(null);
        entity.setDefaultMode("INTERACTIVE");

        // Act & Assert
        assertThrows(NullPointerException.class, () -> userMapper.toDomain(entity));
    }

    @Test
    @DisplayName("Converts UserPreferencesEntity to domain model - edge case, defaultMode is null")
    public void toDomain_Preferences_EdgeCase_DefaultModeNull() {
        // Arrange
        UserPreferencesEntity entity = new UserPreferencesEntity();
        entity.setTheme("DARK");
        entity.setDefaultMode(null);

        // Act & Assert
        assertThrows(NullPointerException.class, () -> userMapper.toDomain(entity));
    }

    @Test
    @DisplayName("Converts User to entity - error case, role is invalid")
    public void toEntity_ErrorCase_InvalidRole() {
        // Arrange
        User domain = new User();
        domain.setRole(UserRole.valueOf("INVALID"));
        domain.setSubscriptionTier(SubscriptionTier.PREMIUM);

        // Act & Assert
        assertThrows(IllegalArgumentException.class, () -> userMapper.toEntity(domain, true));
    }

    @Test
    @DisplayName("Converts User to entity - error case, subscriptionTier is invalid")
    public void toEntity_ErrorCase_InvalidSubscriptionTier() {
        // Arrange
        User domain = new User();
        domain.setRole(UserRole.ADMIN);
        domain.setSubscriptionTier(SubscriptionTier.valueOf("INVALID"));

        // Act & Assert
        assertThrows(IllegalArgumentException.class, () -> userMapper.toEntity(domain, true));
    }

    @Test
    @DisplayName("Converts UserPreferences to entity - error case, theme is invalid")
    public void toEntity_Preferences_ErrorCase_InvalidTheme() {
        // Arrange
        UserPreferences preferences = new UserPreferences();
        preferences.setTheme(UiTheme.valueOf("INVALID"));
        preferences.setDefaultMode(ExamMode.INTERACTIVE);

        // Act & Assert
        assertThrows(IllegalArgumentException.class, () -> userMapper.toEntity(preferences));
    }

    @Test
    @DisplayName("Converts UserPreferences to entity - error case, defaultMode is invalid")
    public void toEntity_Preferences_ErrorCase_InvalidDefaultMode() {
        // Arrange
        UserPreferences preferences = new UserPreferences();
        preferences.setTheme(UiTheme.DARK);
        preferences.setDefaultMode(ExamMode.valueOf("INVALID"));

        // Act & Assert
        assertThrows(IllegalArgumentException.class, () -> userMapper.toEntity(preferences));
    }

    @Test
    @DisplayName("Converts list of UserEntities to domain models - nominal case")
    public void toDomains_NominalCase() {
        // Arrange
        List<UserEntity> entities = Arrays.asList(
            new UserEntity().setRole("ADMIN").setSubscriptionTier("PREMIUM"),
            new UserEntity().setRole("USER").setSubscriptionTier("BASIC")
        );

        // Act
        List<User> domains = userMapper.toDomains(entities);

        // Assert
        assertThat(domains).hasSize(2);
        assertThat(domains.get(0).role()).isEqualTo(UserRole.ADMIN);
        assertThat(domains.get(0).subscriptionTier()).isEqualTo(SubscriptionTier.PREMIUM);
        assertThat(domains.get(1).role()).isEqualTo(UserRole.USER);
        assertThat(domains.get(1).subscriptionTier()).isEqualTo(SubscriptionTier.BASIC);
    }

    @Test
    @DisplayName("Converts list of UserEntities to domain models - edge case, empty list")
    public void toDomains_EdgeCase_EmptyList() {
        // Arrange
        List<UserEntity> entities = Arrays.asList();

        // Act
        List<User> domains = userMapper.toDomains(entities);

        // Assert
        assertThat(domains).isEmpty();
    }
}
