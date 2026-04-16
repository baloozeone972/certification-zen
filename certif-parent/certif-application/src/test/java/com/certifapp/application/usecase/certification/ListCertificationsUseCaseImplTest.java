```java
package com.certifapp.application.usecase.certification;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

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
public class ListCertificationsUseCaseImplTest {

    @Mock
    private CertificationRepository certificationRepository;

    @InjectMocks
    private ListCertificationsUseCaseImpl listCertificationsUseCase;

    @BeforeEach
    public void setUp() {
        // Additional setup if needed
    }

    @AfterEach
    public void tearDown() {
        // Additional teardown if needed
    }

    @Test
    @DisplayName("should return all active certifications when activeOnly is true")
    public void execute_activeOnly_true_expectedActiveCertifications() {
        // Given
        boolean activeOnly = true;
        List<Certification> expectedCertifications = List.of(new Certification(), new Certification());
        when(certificationRepository.findAll(activeOnly)).thenReturn(expectedCertifications);

        // When
        List<Certification> result = listCertificationsUseCase.execute(activeOnly);

        // Then
        assertThat(result).isEqualTo(expectedCertifications);
        verify(certificationRepository, times(1)).findAll(activeOnly);
    }

    @Test
    @DisplayName("should return all certifications when activeOnly is false")
    public void execute_activeOnly_false_expectedAllCertifications() {
        // Given
        boolean activeOnly = false;
        List<Certification> expectedCertifications = List.of(new Certification(), new Certification());
        when(certificationRepository.findAll(activeOnly)).thenReturn(expectedCertifications);

        // When
        List<Certification> result = listCertificationsUseCase.execute(activeOnly);

        // Then
        assertThat(result).isEqualTo(expectedCertifications);
        verify(certificationRepository, times(1)).findAll(activeOnly);
    }

    @Test
    @DisplayName("should return an empty list when repository returns null")
    public void execute_repositoryReturnsNull_expectedEmptyList() {
        // Given
        boolean activeOnly = true;
        when(certificationRepository.findAll(activeOnly)).thenReturn(null);

        // When
        List<Certification> result = listCertificationsUseCase.execute(activeOnly);

        // Then
        assertThat(result).isEmpty();
        verify(certificationRepository, times(1)).findAll(activeOnly);
    }

    @Test
    @DisplayName("should return an empty list when repository returns an empty list")
    public void execute_repositoryReturnsEmptyList_expectedEmptyList() {
        // Given
        boolean activeOnly = true;
        when(certificationRepository.findAll(activeOnly)).thenReturn(Collections.emptyList());

        // When
        List<Certification> result = listCertificationsUseCase.execute(activeOnly);

        // Then
        assertThat(result).isEmpty();
        verify(certificationRepository, times(1)).findAll(activeOnly);
    }
}
```
