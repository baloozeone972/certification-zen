package com.certifapp.domain.port.input.certification;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class ListCertificationsUseCaseTest {

    @Mock
    private CertificationRepository certificationRepository;

    @InjectMocks
    private ListCertificationsUseCase listCertificationsUseCase;

    @BeforeEach
    public void setUp() {
        // Setup if needed
    }

    @AfterEach
    public void tearDown() {
        // Cleanup if needed
    }

    @Test
    @DisplayName("Nominal case: Retrieve all certifications")
    public void execute_allCertificationsRetrieved() {
        // Arrange
        List<Certification> mockCertifications = Collections.singletonList(new Certification());
        when(certificationRepository.findAll(anyBoolean())).thenReturn(mockCertifications);

        // Act
        List<Certification> result = listCertificationsUseCase.execute(false);

        // Assert
        assertThat(result).isEqualTo(mockCertifications);
        verify(certificationRepository).findAll(false);
    }

    @Test
    @DisplayName("Nominal case: Retrieve active certifications only")
    public void execute_activeCertificationsRetrieved() {
        // Arrange
        List<Certification> mockCertifications = Collections.singletonList(new Certification());
        when(certificationRepository.findAll(anyBoolean())).thenReturn(mockCertifications);

        // Act
        List<Certification> result = listCertificationsUseCase.execute(true);

        // Assert
        assertThat(result).isEqualTo(mockCertifications);
        verify(certificationRepository).findAll(true);
    }

    @Test
    @DisplayName("Edge case: No certifications available")
    public void execute_noCertificationsAvailable() {
        // Arrange
        when(certificationRepository.findAll(anyBoolean())).thenReturn(Collections.emptyList());

        // Act
        List<Certification> result = listCertificationsUseCase.execute(false);

        // Assert
        assertThat(result).isEmpty();
        verify(certificationRepository).findAll(false);
    }

    @Test
    @DisplayName("Edge case: Repository throws exception")
    public void execute_repositoryThrowsException() {
        // Arrange
        when(certificationRepository.findAll(anyBoolean())).thenThrow(new RuntimeException("Mocked exception"));

        // Act and Assert
        assertThatThrownBy(() -> listCertificationsUseCase.execute(false))
                .isInstanceOf(RuntimeException.class)
                .hasMessage("Mocked exception");
    }
}
