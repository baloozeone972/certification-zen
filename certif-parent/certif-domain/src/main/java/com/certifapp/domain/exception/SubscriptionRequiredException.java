// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/SubscriptionRequiredException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a PRO-only feature is accessed by a FREE-tier user.
 */
public record SubscriptionRequiredException(String featureName) extends CertifAppException {

    public SubscriptionRequiredException {
        super("Feature \"" + featureName + "\" requires a PRO subscription");
    }
}