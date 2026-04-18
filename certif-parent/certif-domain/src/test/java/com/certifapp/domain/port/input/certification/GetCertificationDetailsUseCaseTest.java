package com.certifapp.domain.port.input.certification;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.model.certification.Certification;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class GetCertificationDetailsUseCaseTest {

    private final GetCertificationDetailsUseCase getCertificationDetailsUseCase = new GetCertificationDetailsUseCase();

    @Test
    @DisplayName("execute_nominal_case_shouldReturnCertification")
    public void execute_nominal_case_shouldReturnCertification() {
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
    public void execute_error_case_certificationNotFound_shouldThrowCertificationNotFoundException() {
        String certificationId = "nonexistent";

        when(certificationRepository.findById(certificationId)).thenReturn(null);

        assertThrows(CertificationNotFoundException.class, () -> {
            getCertificationDetailsUseCase.execute(certificationId);
        });

        verify(certificationRepository, times(1)).findById(certificationId);
    }
}