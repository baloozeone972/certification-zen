```java
package com.certifapp.api.dto.response;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

import java.time.OffsetDateTime;
import java.util.List;

@ExtendWith(MockitoExtension.class)
public class ErrorResponseTest {

    @Mock
    private FieldError fieldError;

    @InjectMocks
    private ErrorResponse errorResponse;

    @BeforeEach
    public void setUp() {
        List<FieldError> errors = List.of(fieldError);
        OffsetDateTime timestamp = OffsetDateTime.now();
        errorResponse = new ErrorResponse(400, "Bad Request", errors, timestamp);
    }

    @Test
    @DisplayName("should return correct status when created with of(int, String)")
    public void shouldReturnCorrectStatus_whenCreatedWithOfIntString() {
        ErrorResponse response = ErrorResponse.of(400, "Bad Request");
        Assertions.assertThat(response.status()).isEqualTo(400);
        Assertions.assertThat(response.message()).isEqualTo("Bad Request");
        Assertions.assertThat(response.errors()).isEmpty();
        Assertions.assertThat(response.timestamp()).isNotNull();
    }

    @Test
    @DisplayName("should return correct status when created with of(int, String, List<FieldError>)")
    public void shouldReturnCorrectStatus_whenCreatedWithOfIntStringListFieldError() {
        ErrorResponse response = ErrorResponse.of(400, "Bad Request", List.of(fieldError));
        Assertions.assertThat(response.status()).isEqualTo(400);
        Assertions.assertThat(response.message()).isEqualTo("Bad Request");
        Assertions.assertThat(response.errors()).hasSize(1);
        Assertions.assertThat(response.timestamp()).isNotNull();
    }

    @Test
    @DisplayName("should return correct message when created with of(int, String)")
    public void shouldReturnCorrectMessage_whenCreatedWithOfIntString() {
        ErrorResponse response = ErrorResponse.of(400, "Bad Request");
        Assertions.assertThat(response.message()).isEqualTo("Bad Request");
    }

    @Test
    @DisplayName("should return empty errors list when created with of(int, String)")
    public void shouldReturnEmptyErrorsList_whenCreatedWithOfIntString() {
        ErrorResponse response = ErrorResponse.of(400, "Bad Request");
        Assertions.assertThat(response.errors()).isEmpty();
    }

    @Test
    @DisplayName("should not be null when created")
    public void shouldNotBeNull_whenCreated() {
        ErrorResponse response = new ErrorResponse(200, "OK", List.of(), OffsetDateTime.now());
        Assertions.assertThat(response).isNotNull();
    }

    @Test
    @DisplayName("should return current timestamp when created")
    public void shouldReturnCurrentTimestamp_whenCreated() {
        ErrorResponse response = new ErrorResponse(400, "Bad Request", List.of(fieldError), OffsetDateTime.now());
        Assertions.assertThat(response.timestamp()).isNotNull();
    }
}
```
