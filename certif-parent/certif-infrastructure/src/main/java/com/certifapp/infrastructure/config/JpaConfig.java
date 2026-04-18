// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/config/JpaConfig.java
package com.certifapp.infrastructure.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * JPA and transaction management configuration.
 *
 * <p>Explicitly defines the base packages for entity scanning and repositories
 * to avoid classpath scanning ambiguities in the multi-module Maven setup.</p>
 */
@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
        basePackages = "com.certifapp.infrastructure.persistence.repository"
)
public class JpaConfig {
}
