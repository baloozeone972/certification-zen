package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@ContextConfiguration(initializers = SpringExtension.class)
@Testcontainers
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class UserEntityTest {

    @Container
    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @Autowired
    private UserRepository userRepository;

    @BeforeEach
    public void setUp() {
        OffsetDateTime now = OffsetDateTime.of(2023, 10, 1, 12, 0, 0, 0);
        UserEntity userEntity = new UserEntity();
        userEntity.onCreate();

        userRepository.save(userEntity);
    }

    @AfterEach
    public void tearDown() {
        userRepository.deleteAll();
    }

    @Test
    @DisplayName("UserEntity creation sets createdAt and updatedAt to current time")
    public void create_userEntity_setsCreatedAtAndUpdatedAtToCurrentTime() {
        // Arrange
        OffsetDateTime now = OffsetDateTime.of(2023, 10, 1, 12, 0, 0, 0);
        UserEntity userEntity = new UserEntity();
        userEntity.onCreate();

        // Act
        userEntity.onCreate();

        // Assert
        assertThat(userEntity.getCreatedAt()).isEqualTo(now);
        assertThat(userEntity.getUpdatedAt()).isEqualTo(now);

        // Verify
        var savedUser = userRepository.findById(userEntity.getId()).orElse(null);
        assertThat(savedUser).isNotNull();
        assertThat(savedUser.getCreatedAt()).isEqualTo(now);
        assertThat(savedUser.getUpdatedAt()).isEqualTo(now);
    }

    @Test
    @DisplayName("UserEntity update sets updatedAt to current time")
    public void update_userEntity_setsUpdatedAtToCurrentTime() {
        // Arrange
        OffsetDateTime now = OffsetDateTime.of(2023, 10, 1, 12, 0, 0, 0);
        UserEntity userEntity = new UserEntity();
        userEntity.onCreate();

        // Act
        userEntity.onUpdate();

        // Assert
        assertThat(userEntity.getUpdatedAt()).isEqualTo(now);

        // Verify
        var savedUser = userRepository.findById(userEntity.getId()).orElse(null);
        assertThat(savedUser).isNotNull();
        assertThat(savedUser.getUpdatedAt()).isEqualTo(now);
    }

    @Test
    @DisplayName("UserEntity creation with no createdAt sets it to current time")
    public void create_userEntity_noCreatedAt_setsCreatedAtToCurrentTime() {
        // Arrange
        OffsetDateTime now = OffsetDateTime.of(2023, 10, 1, 12, 0, 0, 0);
        UserEntity userEntity = new UserEntity();
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
        assertThat(userEntity.getCreatedAt()).isEqualTo(now);
        assertThat(userEntity.getUpdatedAt()).isEqualTo(now);

        // Verify
        var savedUser = userRepository.findById(userEntity.getId()).orElse(null);
        assertThat(savedUser).isNotNull();
        assertThat(savedUser.getCreatedAt()).isEqualTo(now);
        assertThat(savedUser.getUpdatedAt()).isEqualTo(now);
    }

    @Test
    @DisplayName("UserEntity update with existing createdAt sets only updatedAt")
    public void update_userEntity_existingCreatedAt_setsOnlyUpdatedAt() {
        // Arrange
        OffsetDateTime now = OffsetDateTime.of(2023, 10, 1, 12, 0, 0, 0);
        UserEntity userEntity = new UserEntity();
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
        assertThat(userEntity.getUpdatedAt()).isEqualTo(now);
        assertThat(userEntity.getCreatedAt()).isNotEqualTo(now);

        // Verify
        var savedUser = userRepository.findById(userEntity.getId()).orElse(null);
        assertThat(savedUser).isNotNull();
        assertThat(savedUser.getUpdatedAt()).isEqualTo(now);
        assertThat(savedUser.getCreatedAt()).isNotEqualTo(now);
    }
}