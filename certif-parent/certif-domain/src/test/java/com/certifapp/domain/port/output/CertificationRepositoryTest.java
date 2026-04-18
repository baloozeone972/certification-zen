package com.certifapp.domain.port.output;

import com.certifapp.domain.model.certification.Certification;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

public class CertificationRepositoryTest {

    private static final String CERT_ID = "12345";
    private static final Certification SAMPLE_CERTIFICATION = new Certification(CERT_ID, "Java Developer");

    @BeforeEach
    public void setUp() {
        // Set up any common objects or configurations before each test method
    }

    @Test
    @DisplayName("findById_existingId_returnCertification")
    public void findById_existingId_returnCertification() {
        // Arrange
        when(certificationRepository.findById(CERT_ID)).thenReturn(Optional.of(SAMPLE_CERTIFICATION));

        // Act
        Optional<Certification> result = certificationService.findById(CERT_ID);

        // Assert
        assertThat(result).isPresent();
        assertThat(result.get()).isEqualTo(SAMPLE_CERTIFICATION);
        verify(certificationRepository, times(1)).findById(CERT_ID);
    }

    @Test
    @DisplayName("findById_nonExistingId_returnEmptyOptional")
    public void findById_nonExistingId_returnEmptyOptional() {
        // Arrange
        when(certificationRepository.findById(CERT_ID)).thenReturn(Optional.empty());

        // Act
        Optional<Certification> result = certificationService.findById(CERT_ID);

        // Assert
        assertThat(result).isEmpty();
        verify(certificationRepository, times(1)).findById(CERT_ID);
    }

    @Test
    @DisplayName("findAll_activeOnly_true_returnActiveCertifications")
    public void findAll_activeOnly_true_returnActiveCertifications() {
        // Arrange
        List<Certification> sampleCertifications = Collections.singletonList(SAMPLE_CERTIFICATION);

        when(certificationRepository.findAll(true)).thenReturn(sampleCertifications);

        // Act
        List<Certification> result = certificationService.findAll(true);

        // Assert
        assertThat(result).isEqualTo(sampleCertifications);
        verify(certificationRepository, times(1)).findAll(true);
    }

    @Test
    @DisplayName("findAll_activeOnly_false_returnAllCertifications")
    public void findAll_activeOnly_false_returnAllCertifications() {
        // Arrange
        List<Certification> sampleCertifications = Collections.singletonList(SAMPLE_CERTIFICATION);

        when(certificationRepository.findAll(false)).thenReturn(sampleCertifications);

        // Act
        List<Certification> result = certificationService.findAll(false);

        // Assert
        assertThat(result).isEqualTo(sampleCertifications);
        verify(certificationRepository, times(1)).findAll(false);
    }

    @Test
    @DisplayName("save_certification_returnSavedCertification")
    public void save_certification_returnSavedCertification() {
        // Arrange
        when(certificationRepository.save(SAMPLE_CERTIFICATION)).thenReturn(SAMPLE_CERTIFICATION);

        // Act
        Certification result = certificationService.save(SAMPLE_CERTIFICATION);

        // Assert
        assertThat(result).isEqualTo(SAMPLE_CERTIFICATION);
        verify(certificationRepository, times(1)).save(SAMPLE_CERTIFICATION);
    }

    @Test
    @DisplayName("findById_nullId_throwIllegalArgumentException")
    public void findById_nullId_throwIllegalArgumentException() {
        // Arrange
        String nullId = null;

        // Act & Assert
        assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> certificationService.findById(nullId))
                .withMessage("Invalid id: null");

        verify(certificationRepository, never()).findById(anyString());
    }

    @Test
    @DisplayName("save_nullCertification_throwIllegalArgumentException")
    public void save_nullCertification_throwIllegalArgumentException() {
        // Arrange
        Certification nullCertification = null;

        // Act & Assert
        assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> certificationService.save(nullCertification))
                .withMessage("Invalid certification: null");

        verify(certificationRepository, never()).save(any(Certification.class));
    }
}