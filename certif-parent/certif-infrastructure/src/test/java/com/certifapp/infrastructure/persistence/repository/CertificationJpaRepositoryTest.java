package com.certifapp.infrastructure.persistence.repository;

import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.assertThat;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class CertificationJpaRepositoryTest {

    @Mock
    private CertificationEntity mockCertificationEntity1;
    
    @Mock
    private CertificationEntity mockCertificationEntity2;

    @InjectMocks
    private CertificationJpaRepository underTest;

    @BeforeEach
    public void setUp() {
        when(mockCertificationEntity1.getName()).thenReturn("Cert1");
        when(mockCertificationEntity1.isActive()).thenReturn(true);
        
        when(mockCertificationEntity2.getName()).thenReturn("Cert2");
        when(mockCertificationEntity2.isActive()).thenReturn(false);
    }

    @Test
    @DisplayName("findAllWithThemes_nominalCase_expectedAllCertifications")
    public void findAllWithThemes_nominalCase_expectedAllCertifications() {
        // Arrange
        when(underTest.findAll()).thenReturn(List.of(mockCertificationEntity1, mockCertificationEntity2));

        // Act
        List<CertificationEntity> result = underTest.findAllWithThemes();

        // Assert
        assertThat(result).containsExactlyInAnyOrder(mockCertificationEntity1, mockCertificationEntity2);
    }

    @Test
    @DisplayName("findAllActiveWithThemes_nominalCase_expectedOnlyActiveCertifications")
    public void findAllActiveWithThemes_nominalCase_expectedOnlyActiveCertifications() {
        // Arrange
        when(underTest.findAll()).thenReturn(List.of(mockCertificationEntity1, mockCertificationEntity2));

        // Act
        List<CertificationEntity> result = underTest.findAllActiveWithThemes();

        // Assert
        assertThat(result).containsExactlyInAnyOrder(mockCertificationEntity1);
    }

    @Test
    @DisplayName("findAllActiveWithThemes_noActiveCertifications_expectedEmptyList")
    public void findAllActiveWithThemes_noActiveCertifications_expectedEmptyList() {
        // Arrange
        when(underTest.findAll()).thenReturn(List.of(mockCertificationEntity2));

        // Act
        List<CertificationEntity> result = underTest.findAllActiveWithThemes();

        // Assert
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("findAll_nominalCase_expectedAllEntities")
    public void findAll_nominalCase_expectedAllEntities() {
        // Arrange
        when(underTest.findAll()).thenReturn(List.of(mockCertificationEntity1, mockCertificationEntity2));

        // Act
        List<CertificationEntity> result = underTest.findAll();

        // Assert
        assertThat(result).containsExactlyInAnyOrder(mockCertificationEntity1, mockCertificationEntity2);
    }

    @Test
    @DisplayName("findAll_emptyRepository_expectedEmptyList")
    public void findAll_emptyRepository_expectedEmptyList() {
        // Arrange
        when(underTest.findAll()).thenReturn(List.of());

        // Act
        List<CertificationEntity> result = underTest.findAll();

        // Assert
        assertThat(result).isEmpty();
    }

}
