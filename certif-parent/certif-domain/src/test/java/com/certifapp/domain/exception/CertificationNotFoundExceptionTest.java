package com.certifapp.domain.exception;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CertificationNotFoundExceptionTest {

    @InjectMocks
    private CertificationService certificationService;

    @Mock
    private CertificationRepository certificationRepository;

    @BeforeEach
    public void setUp() {
        // Initialize mocks or set up initial state if needed
    }

    @Test
    @DisplayName("Should throw CertificationNotFoundException when certification is not found")
    public void getCertificationById_certificationNotFound_throwException() {
        String certificationId = "12345";
        when(certificationRepository.findById(certificationId)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> certificationService.getCertificationById(certificationId))
            .isInstanceOf(CertificationNotFoundException.class)
            .hasMessage("Certification not found: " + certificationId);
    }

    @Test
    @DisplayName("Should return the certification when it exists")
    public void getCertificationById_certificationExists_returnCertification() {
        String certificationId = "12345";
        Certification expectedCertification = new Certification(certificationId, "Java Certified", LocalDate.now());
        when(certificationRepository.findById(certificationId)).thenReturn(Optional.of(expectedCertification));

        Certification result = certificationService.getCertificationById(certificationId);

        assertThat(result).isEqualTo(expectedCertification);
    }

    @Test
    @DisplayName("Should handle null input gracefully")
    public void getCertificationById_nullInput_throwIllegalArgumentException() {
        assertThatThrownBy(() -> certificationService.getCertificationById(null))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("Certification ID cannot be null");
    }
}
