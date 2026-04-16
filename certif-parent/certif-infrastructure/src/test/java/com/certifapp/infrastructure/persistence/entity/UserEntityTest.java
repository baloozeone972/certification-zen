```java
package com.certifapp.infrastructure.persistence.entity;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.time.OffsetDateTime;
import java.util.UUID;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class UserEntityTest {

    @Mock
    private OffsetDateTime now;

    @InjectMocks
    private UserEntity userEntity;

    @BeforeEach
    public void setUp() {
        when(now.now()).thenReturn(OffsetDateTime.of(2023, 10, 1, 12, 0, 0, 0));
        userEntity = new UserEntity();
    }

    @AfterEach
    public void tearDown() {
        reset(userEntity);
    }

    @Test
    @DisplayName("UserEntity creation sets createdAt and updatedAt to current time")
    public void create_userEntity_setsCreatedAtAndUpdatedAtToCurrentTime() {
        // Act
        userEntity.onCreate();

        // Assert
        assertThat(userEntity.getCreatedAt()).isEqualTo(now.now());
        assertThat(userEntity.getUpdatedAt()).isEqualTo(now.now());

        verify(now, times(2)).now();
    }

    @Test
    @DisplayName("UserEntity update sets updatedAt to current time")
    public void update_userEntity_setsUpdatedAtToCurrentTime() {
        // Arrange
        userEntity.setCreatedAt(OffsetDateTime.of(2023, 9, 1, 12, 0, 0, 0));

        // Act
        userEntity.onUpdate();

        // Assert
        assertThat(userEntity.getUpdatedAt()).isEqualTo(now.now());

        verify(now, times(1)).now();
    }

    @Test
    @DisplayName("UserEntity creation with no createdAt sets it to current time")
    public void create_userEntity_noCreatedAt_setsCreatedAtToCurrentTime() {
        // Arrange
        userEntity.setId(UUID.randomUUID());
        userEntity.setEmail("test@example.com");
        userEntity.setPasswordHash("hashedPassword");
        userEntity.setRole("USER");
        userEntity.setSubscriptionTier("BASIC");
        userEntity.setLocale("en-US");
        userEntity.setTimezone("UTC");

        // Act
        userEntity.onCreate();

        // Assert
        assertThat(userEntity.getCreatedAt()).isEqualTo(now.now());
        assertThat(userEntity.getUpdatedAt()).isEqualTo(now.now());

        verify(now, times(2)).now();
    }

    @Test
    @DisplayName("UserEntity update with existing createdAt sets only updatedAt")
    public void update_userEntity_existingCreatedAt_setsOnlyUpdatedAt() {
        // Arrange
        userEntity.setId(UUID.randomUUID());
        userEntity.setEmail("test@example.com");
        userEntity.setPasswordHash("hashedPassword");
        userEntity.setRole("USER");
        userEntity.setSubscriptionTier("BASIC");
        userEntity.setLocale("en-US");
        userEntity.setTimezone("UTC");
        userEntity.setCreatedAt(OffsetDateTime.of(2023, 9, 1, 12, 0, 0, 0));

        // Act
        userEntity.onUpdate();

        // Assert
        assertThat(userEntity.getUpdatedAt()).isEqualTo(now.now());
        assertThat(userEntity.getCreatedAt()).isNotEqualTo(now.now());

        verify(now, times(1)).now();
    }
}
```
