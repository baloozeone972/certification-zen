```java
package com.certifapp.infrastructure.config;

import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.springframework.context.annotation.Bean;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class FlywayConfigTest {

    @Mock
    private Flyway flyway;

    @InjectMocks
    private FlywayConfig flywayConfig;

    @BeforeEach
    public void setUp() {
        // Additional setup if needed
    }

    @DisplayName("cleanMigrateStrategy_testProfile_shouldReturnFlywayMigrate")
    @Test
    public void cleanMigrateStrategy_testProfile_shouldReturnFlywayMigrate() {
        when(flyway.getConfiguration()).thenReturn(mock(org.flywaydb.core.api.FlywayConfiguration.class));
        when(flyway.getConfiguration().getProfile()).thenReturn("test");

        FlywayMigrationStrategy strategy = flywayConfig.cleanMigrateStrategy();

        assertThat(strategy).isEqualTo(Flyway::migrate);
        verify(flyway, times(1)).getConfiguration();
        verify(flyway.getConfiguration(), times(1)).getProfile();
    }

    @DisplayName("cleanMigrateStrategy_nonTestProfile_shouldThrowException")
    @Test
    public void cleanMigrateStrategy_nonTestProfile_shouldThrowException() {
        when(flyway.getConfiguration()).thenReturn(mock(org.flywaydb.core.api.FlywayConfiguration.class));
        when(flyway.getConfiguration().getProfile()).thenReturn("prod");

        assertThatThrownBy(() -> flywayConfig.cleanMigrateStrategy())
                .isInstanceOf(AssertionError.class)
                .hasMessageContaining("Expected 'test' profile but got 'prod'");

        verify(flyway, times(1)).getConfiguration();
        verify(flyway.getConfiguration(), times(1)).getProfile();
    }
}
```
