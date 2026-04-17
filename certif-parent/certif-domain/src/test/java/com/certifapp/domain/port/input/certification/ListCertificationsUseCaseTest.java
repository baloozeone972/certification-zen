package com.certifapp.domain.port.input.certification;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class ListCertificationsUseCaseTest {

    @Test
    @DisplayName("Nominal case: Retrieve all certifications")
    public void execute_allCertificationsRetrieved() {
        // Arrange
        List<Certification> mockCertifications = Collections.singletonList(new Certification());

        // Act
        List<Certification> result = ListCertificationsUseCase.execute(mockCertifications, false);

        // Assert
        assertThat(result).isEqualTo(mockCertifications);
    }

    @Test
    @DisplayName("Nominal case: Retrieve active certifications only")
    public void execute_activeCertificationsRetrieved() {
        // Arrange
        List<Certification> mockCertifications = Collections.singletonList(new Certification());

        // Act
        List<Certification> result = ListCertificationsUseCase.execute(mockCertifications, true);

        // Assert
        assertThat(result).isEqualTo(mockCertifications);
    }

    @Test
    @DisplayName("Edge case: No certifications available")
    public void execute_noCertificationsAvailable() {
        // Arrange
        List<Certification> mockCertifications = Collections.emptyList();

        // Act
        List<Certification> result = ListCertificationsUseCase.execute(mockCertifications, false);

        // Assert
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("Edge case: Repository throws exception")
    public void execute_repositoryThrowsException() {
        // Arrange
        RuntimeException exception = new RuntimeException("Mocked exception");

        // Act and Assert
        assertThatThrownBy(() -> ListCertificationsUseCase.execute(null, false))
                .isInstanceOf(RuntimeException.class)
                .hasMessage("Mocked exception");
    }
}