package com.certifapp.application.usecase.certification;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.port.input.certification.GetCertificationDetailsUseCase;
import com.certifapp.domain.port.output.CertificationRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class GetCertificationDetailsUseCaseImplTest {

    @Mock
    private CertificationRepository certificationRepository;

    @InjectMocks
    private GetCertificationDetailsUseCaseImpl getCertificationDetailsUseCase;

    private Certification certification;

    @BeforeEach
    public void setUp() {
        certification = new Certification("ocp21", "OpenCerts for Java");
    }

    @Test
    @DisplayName("execute_nominal_case_should_return_certification")
    public void execute_nominal_case_should_return_certification() {
        when(certificationRepository.findById(anyString())).thenReturn(java.util.Optional.of(certification));

        Certification result = getCertificationDetailsUseCase.execute("ocp21");

        assertThat(result).isEqualTo(certification);
        verify(certificationRepository, times(1)).findById("ocp21");
    }

    @Test
    @DisplayName("execute_edge_case_empty_certificationId_should_throw_exception")
    public void execute_edge_case_empty_certificationId_should_throw_exception() {
        when(certificationRepository.findById(anyString())).thenReturn(java.util.Optional.empty());

        assertThatThrownBy(() -> getCertificationDetailsUseCase.execute(""))
                .isInstanceOf(CertificationNotFoundException.class)
                .hasMessage("ocp21");
    }

    @Test
    @DisplayName("execute_error_case_null_certificationId_should_throw_exception")
    public void execute_error_case_null_certificationId_should_throw_exception() {
        when(certificationRepository.findById(anyString())).thenReturn(java.util.Optional.empty());

        assertThatThrownBy(() -> getCertificationDetailsUseCase.execute(null))
                .isInstanceOf(CertificationNotFoundException.class)
                .hasMessage("null");
    }
}
