```java
package com.certifapp.domain.exception;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.junit.jupiter.api.extension.ExtendWith;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@ExtendWith(MockitoExtension.class)
public class UserNotFoundExceptionTest {

    @BeforeEach
    public void setUp() {
        // Set up any necessary mocks or initializations here
    }

    @DisplayName("UserNotFoundException should be thrown with identifier")
    @Test
    public void userNotFoundException_throwsExceptionWithIdentifier() {
        String identifier = "user123";

        assertThatThrownBy(() -> new UserNotFoundException(identifier))
            .isInstanceOf(UserNotFoundException.class)
            .hasMessage("User not found: " + identifier);
    }
}
```
