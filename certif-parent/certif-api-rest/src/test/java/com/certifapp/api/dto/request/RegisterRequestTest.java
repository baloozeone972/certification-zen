```java
package com.certifapp.api.dto.request;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

@ExtendWith(MockitoExtension.class)
public class RegisterRequestTest {

    @InjectMocks
    private RegisterRequest registerRequest;

    @Mock
    private RegisterRequest mockRegisterRequest;

    @BeforeEach
    public void setUp() {
        registerRequest = new RegisterRequest("test@example.com", "password123", "fr", "Europe/Paris");
    }

    @Test
    @DisplayName("Should create a valid RegisterRequest with all parameters")
    public void createValidRegisterRequest_withAllParameters_validObject() {
        Assertions.assertThat(registerRequest).isNotNull();
        Assertions.assertThat(registerRequest.email()).isEqualTo("test@example.com");
        Assertions.assertThat(registerRequest.password()).isEqualTo("password123");
        Assertions.assertThat(registerRequest.locale()).isEqualTo("fr");
        Assertions.assertThat(registerRequest.timezone()).isEqualTo("Europe/Paris");
    }

    @Test
    @DisplayName("Should throw ConstraintViolationException when email is null")
    public void createRegisterRequest_withNullEmail_constraintViolation() {
        Assertions.assertThatThrownBy(() -> new RegisterRequest(null, "password123", "fr", "Europe/Paris"))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @Test
    @DisplayName("Should throw ConstraintViolationException when email is empty")
    public void createRegisterRequest_withEmptyEmail_constraintViolation() {
        Assertions.assertThatThrownBy(() -> new RegisterRequest("", "password123", "fr", "Europe/Paris"))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @Test
    @DisplayName("Should throw ConstraintViolationException when email is not valid")
    public void createRegisterRequest_withInvalidEmail_constraintViolation() {
        Assertions.assertThatThrownBy(() -> new RegisterRequest("invalid-email", "password123", "fr", "Europe/Paris"))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @Test
    @DisplayName("Should throw ConstraintViolationException when password is null")
    public void createRegisterRequest_withNullPassword_constraintViolation() {
        Assertions.assertThatThrownBy(() -> new RegisterRequest("test@example.com", null, "fr", "Europe/Paris"))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @Test
    @DisplayName("Should throw ConstraintViolationException when password is empty")
    public void createRegisterRequest_withEmptyPassword_constraintViolation() {
        Assertions.assertThatThrownBy(() -> new RegisterRequest("test@example.com", "", "fr", "Europe/Paris"))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @Test
    @DisplayName("Should throw ConstraintViolationException when password is shorter than 8 characters")
    public void createRegisterRequest_withShortPassword_constraintViolation() {
        Assertions.assertThatThrownBy(() -> new RegisterRequest("test@example.com", "pwd", "fr", "Europe/Paris"))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @Test
    @DisplayName("Should allow null locale when creating RegisterRequest")
    public void createRegisterRequest_withNullLocale_validObject() {
        registerRequest = new RegisterRequest("test@example.com", "password123", null, "Europe/Paris");
        Assertions.assertThat(registerRequest).isNotNull();
        Assertions.assertThat(registerRequest.locale()).isNull();
    }

    @Test
    @DisplayName("Should allow empty locale when creating RegisterRequest")
    public void createRegisterRequest_withEmptyLocale_validObject() {
        registerRequest = new RegisterRequest("test@example.com", "password123", "", "Europe/Paris");
        Assertions.assertThat(registerRequest).isNotNull();
        Assertions.assertThat(registerRequest.locale()).isEqualTo("");
    }

    @Test
    @DisplayName("Should limit locale length to 10 characters when creating RegisterRequest")
    public void createRegisterRequest_withLocaleLongerThan10_validObject() {
        registerRequest = new RegisterRequest("test@example.com", "password123", "en-US-UK", "Europe/Paris");
        Assertions.assertThat(registerRequest).isNotNull();
        Assertions.assertThat(registerRequest.locale()).isEqualTo("en-US");
    }

    @Test
    @DisplayName("Should allow null timezone when creating RegisterRequest")
    public void createRegisterRequest_withNullTimezone_validObject() {
        registerRequest = new RegisterRequest("test@example.com", "password123", "fr", null);
        Assertions.assertThat(registerRequest).isNotNull();
        Assertions.assertThat(registerRequest.timezone()).isNull();
    }

    @Test
    @DisplayName("Should allow empty timezone when creating RegisterRequest")
    public void createRegisterRequest_withEmptyTimezone_validObject() {
        registerRequest = new RegisterRequest("test@example.com", "password123", "fr", "");
        Assertions.assertThat(registerRequest).isNotNull();
        Assertions.assertThat(registerRequest.timezone()).isEqualTo("");
    }

    @Test
    @DisplayName("Should limit timezone length to 50 characters when creating RegisterRequest")
    public void createRegisterRequest_withTimezoneLongerThan50_validObject() {
        registerRequest = new RegisterRequest("test@example.com", "password123", "fr", "UTC+02:00 Eastern European Time");
        Assertions.assertThat(registerRequest).isNotNull();
        Assertions.assertThat(registerRequest.timezone()).isEqualTo("UTC+02:00 Eastern European Time");
    }
}
```
