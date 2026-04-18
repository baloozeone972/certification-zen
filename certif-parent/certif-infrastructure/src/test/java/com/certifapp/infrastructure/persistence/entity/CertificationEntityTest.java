package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;

import java.util.ArrayList;
import java.util.List;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@SpringBootTestContextInitializer.class

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class CertificationEntityTest {

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private CertificationRepository certificationRepository;

    @BeforeEach
    public void setUp() {
        var certificationEntity = new CertificationEntity();
        certificationEntity.setId("123");
        certificationEntity.setCode("C001");
        certificationEntity.setName("Java Cert");
        certificationEntity.setDescription("Java certification exam");
        certificationEntity.setTotalQuestions(50);
        certificationEntity.setExamQuestionCount(40);
        certificationEntity.setExamDurationMin(60);
        certificationEntity.setPassingScore(30);
        certificationEntity.setExamType("Online Exam");
        certificationEntity.setActive(true);

        entityManager.persist(certificationEntity);
    }

    @Test
    @DisplayName("Nominal case: should set and get all fields correctly")
    public void testSetAndGetFields() {
        var certificationEntity = entityManager.find(CertificationEntity.class, "123");
        Assertions.assertThat(certificationEntity.getId()).isEqualTo("123");
        Assertions.assertThat(certificationEntity.getCode()).isEqualTo("C001");
        Assertions.assertThat(certificationEntity.getName()).isEqualTo("Java Cert");
        Assertions.assertThat(certificationEntity.getDescription()).isEqualTo("Java certification exam");
        Assertions.assertThat(certificationEntity.getTotalQuestions()).isEqualTo(50);
        Assertions.assertThat(certificationEntity.getExamQuestionCount()).isEqualTo(40);
        Assertions.assertThat(certificationEntity.getExamDurationMin()).isEqualTo(60);
        Assertions.assertThat(certificationEntity.getPassingScore()).isEqualTo(30);
        Assertions.assertThat(certificationEntity.getExamType()).isEqualTo("Online Exam");
        Assertions.assertThat(certificationEntity.isActive()).isTrue();
    }

    @Test
    @DisplayName("Edge case: should set and get id correctly with null")
    public void testSetAndGetIdWithNull() {
        var certificationEntity = entityManager.find(CertificationEntity.class, "123");
        certificationEntity.setId(null);
        Assertions.assertThat(certificationEntity.getId()).isNull();
    }

    @Test
    @DisplayName("Error case: should not allow setting code to null")
    public void testSetCodeToNull() {
        var certificationEntity = entityManager.find(CertificationEntity.class, "123");
        Assertions.assertThatThrownBy(() -> certificationEntity.setCode(null))
                .isInstanceOf(NullPointerException.class)
                .hasMessage("code");
    }

    @Test
    @DisplayName("Edge case: should set and get themes correctly with empty list")
    public void testSetAndGetThemesWithEmptyList() {
        var certificationEntity = entityManager.find(CertificationEntity.class, "123");
        List<CertificationThemeEntity> themes = new ArrayList<>();
        certificationEntity.setThemes(themes);
        Assertions.assertThat(certificationEntity.getThemes()).isEmpty();
    }

    @Test
    @DisplayName("Nominal case: should invoke onCreate method on persist")
    public void testOnCreate() {
        var certificationEntity = new CertificationEntity();
        certificationEntity.setId("456");
        certificationEntity.setCode("C002");
        certificationEntity.setName("Python Cert");
        certificationEntity.setDescription("Python certification exam");
        certificationEntity.setTotalQuestions(60);
        certificationEntity.setExamQuestionCount(50);
        certificationEntity.setExamDurationMin(75);
        certificationEntity.setPassingScore(35);
        certificationEntity.setExamType("Online Exam");
        certificationEntity.setActive(true);

        entityManager.persist(certificationEntity);
        var savedCertification = entityManager.find(CertificationEntity.class, "456");
        Assertions.assertThat(savedCertification).isNotNull();
    }
}