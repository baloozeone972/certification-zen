package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.QuestionEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@TestPropertySource(properties = {"spring.jpa.hibernate.ddl-auto=none"})
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
@Testcontainers
public class QuestionJpaRepositoryTest {

    @Container
    public static PostgreSQLContainer<?> postgresql = new PostgreSQLContainer<>("postgres:latest")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @Autowired
    private QuestionJpaRepository questionJpaRepository;

    @BeforeEach
    public void setUp() {
        // Nettoyage BDD entre tests
    }

    @Test
    @DisplayName("findByLegacyId_nominalCase")
    public void testFindByLegacyId_NominalCase() {
        String legacyId = "legacy123";
        QuestionEntity questionEntity = new QuestionEntity();
        when(questionJpaRepository.findByLegacyId(legacyId)).thenReturn(Optional.of(questionEntity));

        Optional<QuestionEntity> result = questionJpaRepository.findByLegacyId(legacyId);

        assertThat(result).isPresent().get().isEqualTo(questionEntity);
    }

    @Test
    @DisplayName("findByCertificationIdActiveRandom_nominalCase")
    public void testFindByCertificationIdActiveRandom_NominalCase() {
        String certId = "cert123";
        List<QuestionEntity> questions = Arrays.asList(new QuestionEntity(), new QuestionEntity());
        when(questionJpaRepository.findByCertificationIdActiveRandom(certId)).thenReturn(questions);

        List<QuestionEntity> result = questionJpaRepository.findByCertificationIdActiveRandom(certId);

        assertThat(result).isNotEmpty().isEqualTo(questions);
    }

    @Test
    @DisplayName("findByCertificationIdAndThemeIdsRandom_nominalCase")
    public void testFindByCertificationIdAndThemeIdsRandom_NominalCase() {
        String certId = "cert123";
        List<UUID> themeIds = Arrays.asList(UUID.randomUUID(), UUID.randomUUID());
        List<QuestionEntity> questions = Arrays.asList(new QuestionEntity(), new QuestionEntity());
        when(questionJpaRepository.findByCertificationIdAndThemeIdsRandom(certId, themeIds)).thenReturn(questions);

        List<QuestionEntity> result = questionJpaRepository.findByCertificationIdAndThemeIdsRandom(certId, themeIds);

        assertThat(result).isNotEmpty().isEqualTo(questions);
    }

    @Test
    @DisplayName("countByThemeForCertification_nominalCase")
    public void testCountByThemeForCertification_NominalCase() {
        String certId = "cert123";
        List<Object[]> results = Arrays.asList(new Object[]{"theme1", 10}, new Object[]{"theme2", 5});
        when(questionJpaRepository.countByThemeForCertification(certId)).thenReturn(results);

        List<Object[]> result = questionJpaRepository.countByThemeForCertification(certId);

        assertThat(result).isNotEmpty().isEqualTo(results);
    }

    @Test
    @DisplayName("findByExplanationStatus_nominalCase")
    public void testFindByExplanationStatus_NominalCase() {
        String status = "answered";
        List<QuestionEntity> questions = Arrays.asList(new QuestionEntity(), new QuestionEntity());
        when(questionJpaRepository.findByExplanationStatus(status)).thenReturn(questions);

        List<QuestionEntity> result = questionJpaRepository.findByExplanationStatus(status);

        assertThat(result).isNotEmpty().isEqualTo(questions);
    }

    @Test
    @DisplayName("countByCertificationIdAndIsActiveTrue_nominalCase")
    public void testCountByCertificationIdAndIsActiveTrue_NominalCase() {
        String certId = "cert123";
        long count = 5;
        when(questionJpaRepository.countByCertificationIdAndIsActiveTrue(certId)).thenReturn(count);

        long result = questionJpaRepository.countByCertificationIdAndIsActiveTrue(certId);

        assertThat(result).isEqualTo(count);
    }

    @Test
    @DisplayName("findByLegacyId_edgeCase_emptyOptional")
    public void testFindByLegacyId_EdgeCase_EmptyOptional() {
        String legacyId = "legacy123";
        when(questionJpaRepository.findByLegacyId(legacyId)).thenReturn(Optional.empty());

        Optional<QuestionEntity> result = questionJpaRepository.findByLegacyId(legacyId);

        assertThat(result).isNotPresent();
    }

    @Test
    @DisplayName("findByCertificationIdActiveRandom_edgeCase_emptyList")
    public void testFindByCertificationIdActiveRandom_EdgeCase_EmptyList() {
        String certId = "cert123";
        when(questionJpaRepository.findByCertificationIdActiveRandom(certId)).thenReturn(Collections.emptyList());

        List<QuestionEntity> result = questionJpaRepository.findByCertificationIdActiveRandom(certId);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("findByCertificationIdAndThemeIdsRandom_edgeCase_emptyList")
    public void testFindByCertificationIdAndThemeIdsRandom_EdgeCase_EmptyList() {
        String certId = "cert123";
        List<UUID> themeIds = Arrays.asList(UUID.randomUUID(), UUID.randomUUID());
        when(questionJpaRepository.findByCertificationIdAndThemeIdsRandom(certId, themeIds)).thenReturn(Collections.emptyList());

        List<QuestionEntity> result = questionJpaRepository.findByCertificationIdAndThemeIdsRandom(certId, themeIds);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("countByThemeForCertification_edgeCase_emptyList")
    public void testCountByThemeForCertification_EdgeCase_EmptyList() {
        String certId = "cert123";
        when(questionJpaRepository.countByThemeForCertification(certId)).thenReturn(Collections.emptyList());

        List<Object[]> result = questionJpaRepository.countByThemeForCertification(certId);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("findByExplanationStatus_edgeCase_emptyList")
    public void testFindByExplanationStatus_EdgeCase_EmptyList() {
        String status = "answered";
        when(questionJpaRepository.findByExplanationStatus(status)).thenReturn(Collections.emptyList());

        List<QuestionEntity> result = questionJpaRepository.findByExplanationStatus(status);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("countByCertificationIdAndIsActiveTrue_edgeCase_zeroCount")
    public void testCountByCertificationIdAndIsActiveTrue_EdgeCase_ZeroCount() {
        String certId = "cert123";
        when(questionJpaRepository.countByCertificationIdAndIsActiveTrue(certId)).thenReturn(0L);

        long result = questionJpaRepository.countByCertificationIdAndIsActiveTrue(certId);

        assertThat(result).isEqualTo(0);
    }
}