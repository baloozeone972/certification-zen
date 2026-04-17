package com.certifapp.infrastructure.persistence.repository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@SpringJUnitConfig(classes = {CertificationJpaRepositoryTest.Config.class})
@Testcontainers
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class CertificationJpaRepositoryTest {

    @Container
    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @Autowired
    private CertificationJpaRepository underTest;

    @BeforeEach
    public void setUp() {
        // Arrange
        CertificationEntity cert1 = new CertificationEntity("Cert1", true);
        CertificationEntity cert2 = new CertificationEntity("Cert2", false);

        underTest.save(cert1);
        underTest.save(cert2);
    }

    @Test
    @DisplayName("findAllWithThemes_nominalCase_expectedAllCertifications")
    public void findAllWithThemes_nominalCase_expectedAllCertifications() {
        // Act
        List<CertificationEntity> result = underTest.findAllWithThemes();

        // Assert
        assertThat(result).hasSize(2);
    }

    @Test
    @DisplayName("findAllActiveWithThemes_nominalCase_expectedOnlyActiveCertifications")
    public void findAllActiveWithThemes_nominalCase_expectedOnlyActiveCertifications() {
        // Act
        List<CertificationEntity> result = underTest.findAllActiveWithThemes();

        // Assert
        assertThat(result).hasSize(1);
    }

    @Test
    @DisplayName("findAllActiveWithThemes_noActiveCertifications_expectedEmptyList")
    public void findAllActiveWithThemes_noActiveCertifications_expectedEmptyList() {
        // Arrange
        underTest.deleteAll();

        // Act
        List<CertificationEntity> result = underTest.findAllActiveWithThemes();

        // Assert
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("findAll_nominalCase_expectedAllEntities")
    public void findAll_nominalCase_expectedAllEntities() {
        // Act
        List<CertificationEntity> result = underTest.findAll();

        // Assert
        assertThat(result).hasSize(2);
    }

    @Test
    @DisplayName("findAll_emptyRepository_expectedEmptyList")
    public void findAll_emptyRepository_expectedEmptyList() {
        // Arrange
        underTest.deleteAll();

        // Act
        List<CertificationEntity> result = underTest.findAll();

        // Assert
        assertThat(result).isEmpty();
    }

    static class Config {
        @Bean
        public PostgreSQLContainer<?> postgres() {
            return new PostgreSQLContainer<>("postgres:latest")
                    .withDatabaseName("testdb")
                    .withUsername("testuser")
                    .withPassword("testpass");
        }
    }
}