// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/certification/GetCertificationDetailsUseCase.java
package com.certifapp.domain.port.input.certification;

import com.certifapp.domain.model.certification.Certification;

/**
 * Use case: retrieve full details of a single certification including all themes.
 */
public interface GetCertificationDetailsUseCase {
    /**
     * @param certificationId the certification slug (e.g. {@code "ocp21"})
     * @return the matching {@link Certification}
     * @throws com.certifapp.domain.exception.CertificationNotFoundException if not found
     */
    Certification execute(String certificationId);
}
