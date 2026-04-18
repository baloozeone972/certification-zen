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

@ExtendWith(MockitoExtension.class)
public class ApiResponseTest {

    @InjectMocks
    private ApiResponse apiResponse;

    @BeforeEach
    public void setUp() {
        // Initialization code if needed
    }

    @Test
    @DisplayName("should create ApiResponse with OK message")
    public void ok_successMessage() {
        Object data = new Object();
        ApiResponse<Object> response = ApiResponse.ok(data);
        Assertions.assertThat(response.data()).isEqualTo(data);
        Assertions.assertThat(response.message()).isEqualTo("OK");
        Assertions.assertThat(response.timestamp()).isNotNull();
    }

    @Test
    @DisplayName("should create ApiResponse with Created message")
    public void created_createdMessage() {
        Object data = new Object();
        ApiResponse<Object> response = ApiResponse.created(data);
        Assertions.assertThat(response.data()).isEqualTo(data);
        Assertions.assertThat(response.message()).isEqualTo("Created");
        Assertions.assertThat(response.timestamp()).isNotNull();
    }

    @Test
    @DisplayName("should not allow null data in OK method")
    public void ok_nullData() {
        Assertions.assertThatThrownBy(() -> ApiResponse.ok(null))
                .isInstanceOf(NullPointerException.class);
    }

    @Test
    @DisplayName("should not allow null data in Created method")
    public void created_nullData() {
        Assertions.assertThatThrownBy(() -> ApiResponse.created(null))
                .isInstanceOf(NullPointerException.class);
    }
}
