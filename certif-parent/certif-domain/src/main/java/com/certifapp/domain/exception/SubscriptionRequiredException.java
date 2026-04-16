// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/SubscriptionRequiredException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a PRO-only feature is accessed by a FREE-tier user.
 */
public class SubscriptionRequiredException extends CertifAppException {

    private final String featureName;
    public SubscriptionRequiredException(String featureName) {
        super("Feature \"" + featureName + "\" requires a PRO subscription");
        this.featureName = featureName;
    }
    public String getFeatureName() { return featureName; }
}
