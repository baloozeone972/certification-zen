package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class CertificationEntityTest {

    @PersistenceContext
    private EntityManager entityManager;

    @Mock
    private CertificationThemeEntity theme;

    @InjectMocks
    private CertificationEntity certificationEntity;

    @BeforeEach
    public void setUp() {
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
    }

    @Test
    @DisplayName("Nominal case: should set and get all fields correctly")
    public void testSetAndGetFields() {
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
        certificationEntity.setId(null);
        Assertions.assertThat(certificationEntity.getId()).isNull();
    }

    @Test
    @DisplayName("Error case: should not allow setting code to null")
    public void testSetCodeToNull() {
        Assertions.assertThatThrownBy(() -> certificationEntity.setCode(null))
                .isInstanceOf(NullPointerException.class)
                .hasMessage("code");
    }

    @Test
    @DisplayName("Edge case: should set and get themes correctly with empty list")
    public void testSetAndGetThemesWithEmptyList() {
        List<CertificationThemeEntity> themes = new ArrayList<>();
        certificationEntity.setThemes(themes);
        Assertions.assertThat(certificationEntity.getThemes()).isEmpty();
    }

    @Test
    @DisplayName("Nominal case: should invoke onCreate method on persist")
    public void testOnCreate() {
        entityManager.persist(certificationEntity);
        verify(entityManager).persist(any(CertificationEntity.class));
    }
}

