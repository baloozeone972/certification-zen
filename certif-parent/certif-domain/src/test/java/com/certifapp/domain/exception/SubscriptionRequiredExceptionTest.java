package com.certifapp.domain.exception;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class SubscriptionRequiredExceptionTest {

    @InjectMocks
    private SubscriptionRequiredException exception;

    @Mock
    private CertifAppException mockCertifAppException;

    @BeforeEach
    public void setUp() {
        exception = new SubscriptionRequiredException("Premium Feature");
    }

    @Test
    @DisplayName(" nominal case: should create an instance with the correct message and feature name")
    public void constructor_correctFeatureName_expectedMessageAndFeatureName() {
        assertThat(exception.getMessage()).isEqualTo("Feature \"Premium Feature\" requires a PRO subscription");
        assertThat(exception.getFeatureName()).isEqualTo("Premium Feature");
    }

    @Test
    @DisplayName(" edge case: should handle null feature name without throwing exception")
    public void constructor_nullFeatureName_expectedDefaultMessageAndNullFeatureName() {
        SubscriptionRequiredException exception = new SubscriptionRequiredException(null);
        assertThat(exception.getMessage()).isEqualTo("Feature \"null\" requires a PRO subscription");
        assertThat(exception.getFeatureName()).isNull();
    }

    @Test
    @DisplayName(" error case: should not call any methods on the mocked CertifAppException")
    public void constructor_noMockedCalls() {
        verify(mockCertifAppException, never()).anyMethod();
    }
}
