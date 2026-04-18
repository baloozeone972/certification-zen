package com.certifapp.application.dto.user;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
public class UserDtoTest {

    @InjectMocks
    private UserDto userDto;

    @BeforeEach
    public void setUp() {
        userDto = new UserDto(
                UUID.randomUUID(),
                "user@example.com",
                "USER",
                "FREE",
                "en-US",
                "UTC",
                OffsetDateTime.now()
        );
    }

    @Test
    @DisplayName("Should create a valid UserDto instance")
    public void createUserDto_nominalCase() {
        assertThat(userDto).isNotNull();
        assertThat(userDto.id()).isInstanceOf(UUID.class);
        assertThat(userDto.email()).isEqualTo("user@example.com");
        assertThat(userDto.role()).isEqualTo("USER");
        assertThat(userDto.subscriptionTier()).isEqualTo("FREE");
        assertThat(userDto.locale()).isEqualTo("en-US");
        assertThat(userDto.timezone()).isEqualTo("UTC");
        assertThat(userDto.createdAt()).isInstanceOf(OffsetDateTime.class);
    }

    @Test
    @DisplayName("Should not allow null UUID for id")
    public void createUserDto_nullId_errorCase() {
        assertThrows(NullPointerException.class, () -> new UserDto(
                null,
                "user@example.com",
                "USER",
                "FREE",
                "en-US",
                "UTC",
                OffsetDateTime.now()
        ));
    }

    @Test
    @DisplayName("Should not allow empty email for email")
    public void createUserDto_emptyEmail_errorCase() {
        assertThrows(IllegalArgumentException.class, () -> new UserDto(
                UUID.randomUUID(),
                "",
                "USER",
                "FREE",
                "en-US",
                "UTC",
                OffsetDateTime.now()
        ));
    }

    @Test
    @DisplayName("Should not allow null role for role")
    public void createUserDto_nullRole_errorCase() {
        assertThrows(NullPointerException.class, () -> new UserDto(
                UUID.randomUUID(),
                "user@example.com",
                null,
                "FREE",
                "en-US",
                "UTC",
                OffsetDateTime.now()
        ));
    }

    @Test
    @DisplayName("Should not allow null subscriptionTier for subscriptionTier")
    public void createUserDto_nullSubscriptionTier_errorCase() {
        assertThrows(NullPointerException.class, () -> new UserDto(
                UUID.randomUUID(),
                "user@example.com",
                "USER",
                null,
                "en-US",
                "UTC",
                OffsetDateTime.now()
        ));
    }

    @Test
    @DisplayName("Should not allow null locale for locale")
    public void createUserDto_nullLocale_errorCase() {
        assertThrows(NullPointerException.class, () -> new UserDto(
                UUID.randomUUID(),
                "user@example.com",
                "USER",
                "FREE",
                null,
                "UTC",
                OffsetDateTime.now()
        ));
    }

    @Test
    @DisplayName("Should not allow null timezone for timezone")
    public void createUserDto_nullTimezone_errorCase() {
        assertThrows(NullPointerException.class, () -> new UserDto(
                UUID.randomUUID(),
                "user@example.com",
                "USER",
                "FREE",
                "en-US",
                null,
                OffsetDateTime.now()
        ));
    }

    @Test
    @DisplayName("Should not allow null createdAt for createdAt")
    public void createUserDto_nullCreatedAt_errorCase() {
        assertThrows(NullPointerException.class, () -> new UserDto(
                UUID.randomUUID(),
                "user@example.com",
                "USER",
                "FREE",
                "en-US",
                "UTC",
                null
        ));
    }
}
