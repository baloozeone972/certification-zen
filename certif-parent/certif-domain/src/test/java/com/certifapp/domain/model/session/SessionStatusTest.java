```java
package com.certifapp.domain.model.session;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class SessionStatusTest {

    @InjectMocks
    private SessionStatus sessionStatus;

    @BeforeEach
    public void setUp() {
        // No-op setup for this test class
    }

    @Test
    @DisplayName("SessionStatus.isFinished should return true for COMPLETED")
    public void isFinished_Completed_ReturnsTrue() {
        assertThat(sessionStatus.COMPLETED.isFinished()).isTrue();
    }

    @Test
    @DisplayName("SessionStatus.isFinished should return true for EXPIRED")
    public void isFinished_Expired_ReturnsTrue() {
        assertThat(sessionStatus.EXPIRED.isFinished()).isTrue();
    }

    @Test
    @DisplayName("SessionStatus.isFinished should return false for IN_PROGRESS")
    public void isFinished_InProgress_ReturnsFalse() {
        assertThat(sessionStatus.IN_PROGRESS.isFinished()).isFalse();
    }

    @Test
    @DisplayName("SessionStatus.isFinished should return false for ABANDONED")
    public void isFinished_Abandoned_ReturnsFalse() {
        assertThat(sessionStatus.ABANDONED.isFinished()).isFalse();
    }
}
```
