// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/config/FlywayConfig.java
package com.certifapp.infrastructure.config;

import org.springframework.boot.autoconfigure.flyway.FlywayMigrationStrategy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

/**
 * Flyway migration strategy configuration.
 *
 * <p>In test profile: uses {@code clean + migrate} to ensure a fresh schema.
 * In prod/local: uses default {@code migrate} only (never drops data).</p>
 */
@Configuration
public class FlywayConfig {

    /**
     * Test strategy: drop and recreate schema before each test run.
     * Only active with the {@code test} Spring profile.
     */
    @Bean
    @Profile("test")
    public FlywayMigrationStrategy cleanMigrateStrategy() {
        return flyway -> {
            flyway.clean();
            flyway.migrate();
        };
    }
}