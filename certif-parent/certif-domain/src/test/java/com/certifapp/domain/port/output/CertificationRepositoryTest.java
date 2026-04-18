package com.certifapp.domain.port.output;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import com.certifapp.domain.model.certification.Certification;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class CertificationRepositoryTest {

    @Mock
    private CertificationRepository certificationRepository;

    @InjectMocks
    private CertificationService certificationService;

    private static final String CERT_ID = "12345";
    private static final Certification SAMPLE_CERTIFICATION = new Certification(CERT_ID, "Java Developer");

    @BeforeEach
    public void setUp() {
        // Set up any common objects or configurations before each test method
    }

    @Test
    @DisplayName("should return optional certification when found by id")
    public void findById_existingId_returnCertification() {
        when(certificationRepository.findById(CERT_ID)).thenReturn(Optional.of(SAMPLE_CERTIFICATION));

        Optional<Certification> result = certificationService.findById(CERT_ID);

        assertThat(result).isPresent();
        assertThat(result.get()).isEqualTo(SAMPLE_CERTIFICATION);
        verify(certificationRepository, times(1)).findById(CERT_ID);
    }

    @Test
    @DisplayName("should return empty optional when certification not found by id")
    public void findById_nonExistingId_returnEmptyOptional() {
        when(certificationRepository.findById(CERT_ID)).thenReturn(Optional.empty());

        Optional<Certification> result = certificationService.findById(CERT_ID);

        assertThat(result).isEmpty();
        verify(certificationRepository, times(1)).findById(CERT_ID);
    }

    @Test
    @DisplayName("should return all active certifications when findAll with true")
    public void findAll_activeOnly_true_returnActiveCertifications() {
        List<Certification> sampleCertifications = Collections.singletonList(SAMPLE_CERTIFICATION);

        when(certificationRepository.findAll(true)).thenReturn(sampleCertifications);

        List<Certification> result = certificationService.findAll(true);

        assertThat(result).isEqualTo(sampleCertifications);
        verify(certificationRepository, times(1)).findAll(true);
    }

    @Test
    @DisplayName("should return all certifications when findAll with false")
    public void findAll_activeOnly_false_returnAllCertifications() {
        List<Certification> sampleCertifications = Collections.singletonList(SAMPLE_CERTIFICATION);

        when(certificationRepository.findAll(false)).thenReturn(sampleCertifications);

        List<Certification> result = certificationService.findAll(false);

        assertThat(result).isEqualTo(sampleCertifications);
        verify(certificationRepository, times(1)).findAll(false);
    }

    @Test
    @DisplayName("should save and return the saved certification")
    public void save_certification_returnSavedCertification() {
        when(certificationRepository.save(SAMPLE_CERTIFICATION)).thenReturn(SAMPLE_CERTIFICATION);

        Certification result = certificationService.save(SAMPLE_CERTIFICATION);

        assertThat(result).isEqualTo(SAMPLE_CERTIFICATION);
        verify(certificationRepository, times(1)).save(SAMPLE_CERTIFICATION);
    }

    @Test
    @DisplayName("should throw IllegalArgumentException when null id provided")
    public void findById_nullId_throwIllegalArgumentException() {
        String nullId = null;

        assertThatExceptionOfType(IllegalArgumentException.class)
            .isThrownBy(() -> certificationService.findById(nullId))
            .withMessage("Invalid id: null");

        verify(certificationRepository, never()).findById(anyString());
    }

    @Test
    @DisplayName("should throw IllegalArgumentException when null certification provided for save")
    public void save_nullCertification_throwIllegalArgumentException() {
        Certification nullCertification = null;

        assertThatExceptionOfType(IllegalArgumentException.class)
            .isThrownBy(() -> certificationService.save(nullCertification))
            .withMessage("Invalid certification: null");

        verify(certificationRepository, never()).save(any(Certification.class));
    }
}
```

Please note that `CertificationService` is assumed to be using the `certificationRepository` for persistence operations. Make sure that it's implemented correctly and included in your test classpath if you are running these tests successfully.
