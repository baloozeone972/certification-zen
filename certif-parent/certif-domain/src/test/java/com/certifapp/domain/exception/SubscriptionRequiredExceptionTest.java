package com.certifapp.domain.exception;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class SubscriptionRequiredExceptionTest {

    @Test
    @DisplayName("nominal case: should create an instance with the correct message and feature name")
    public void constructor_correctFeatureName_expectedMessageAndFeatureName() {
        SubscriptionRequiredException exception = new SubscriptionRequiredException("Premium Feature");
        assertThat(exception.getMessage()).isEqualTo("Feature \"Premium Feature\" requires a PRO subscription");
        assertThat(exception.getFeatureName()).isEqualTo("Premium Feature");
    }

    @Test
    @DisplayName("edge case: should handle null feature name without throwing exception")
    public void constructor_nullFeatureName_expectedDefaultMessageAndNullFeatureName() {
        SubscriptionRequiredException exception = new SubscriptionRequiredException(null);
        assertThat(exception.getMessage()).isEqualTo("Feature \"null\" requires a PRO subscription");
        assertThat(exception.getFeatureName()).isNull();
    }

}