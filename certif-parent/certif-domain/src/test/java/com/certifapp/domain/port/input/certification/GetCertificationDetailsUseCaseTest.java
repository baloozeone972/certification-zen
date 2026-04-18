package com.certifapp.domain.port.input.certification;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.model.certification.Certification;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class GetCertificationDetailsUseCaseTest {

    @Mock
    private CertificationRepository certificationRepository;

    @Mock
    private GetCertificationDetailsUseCase getCertificationDetailsUseCase;

    @BeforeEach
    public void setUp() {
        // Set up any necessary initializations before each test
    }

    @AfterEach
    public void tearDown() {
        // Clean up any resources or reset mocks after each test
    }

    @Test
    @DisplayName("execute_nominal_case_shouldReturnCertification")
    public void execute_nominal_case_shouldReturnCertification() throws CertificationNotFoundException {
        String certificationId = "ocp21";
        Certification expectedCertification = new Certification(certificationId, "OpenCerts", null);

        when(certificationRepository.findById(certificationId)).thenReturn(expectedCertification);

        Certification result = getCertificationDetailsUseCase.execute(certificationId);

        assertThat(result).isEqualTo(expectedCertification);
        verify(certificationRepository, times(1)).findById(certificationId);
    }

    @Test
    @DisplayName("execute_edge_case_emptyCertificationId_shouldThrowIllegalArgumentException")
    public void execute_edge_case_emptyCertificationId_shouldThrowIllegalArgumentException() {
        String certificationId = "";

        assertThrows(IllegalArgumentException.class, () -> {
            getCertificationDetailsUseCase.execute(certificationId);
        });
    }

    @Test
    @DisplayName("execute_error_case_certificationNotFound_shouldThrowCertificationNotFoundException")
    public void execute_error_case_certificationNotFound_shouldThrowCertificationNotFoundException() throws CertificationNotFoundException {
        String certificationId = "nonexistent";

        when(certificationRepository.findById(certificationId)).thenReturn(null);

        assertThrows(CertificationNotFoundException.class, () -> {
            getCertificationDetailsUseCase.execute(certificationId);
        });

        verify(certificationRepository, times(1)).findById(certificationId);
    }
}
