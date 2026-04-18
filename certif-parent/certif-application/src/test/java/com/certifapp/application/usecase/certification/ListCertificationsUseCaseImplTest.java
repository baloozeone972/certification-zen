// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/certification/ListCertificationsUseCaseImplTest.java
package com.certifapp.application.usecase.certification;

import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.port.output.CertificationRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("ListCertificationsUseCaseImpl")
class ListCertificationsUseCaseImplTest {

    @Mock  CertificationRepository certificationRepository;
    @InjectMocks ListCertificationsUseCaseImpl useCase;

    @Test @DisplayName("execute(true) — delegates to repository with activeOnly=true")
    void execute_activeOnly_delegatesToRepository() {
        when(certificationRepository.findAll(true)).thenReturn(List.of());
        List<Certification> result = useCase.execute(true);
        assertThat(result).isEmpty();
        verify(certificationRepository).findAll(true);
    }

    @Test @DisplayName("execute(false) — returns all certifications")
    void execute_allCerts_delegatesToRepository() {
        when(certificationRepository.findAll(false)).thenReturn(List.of());
        useCase.execute(false);
        verify(certificationRepository).findAll(false);
    }
}
