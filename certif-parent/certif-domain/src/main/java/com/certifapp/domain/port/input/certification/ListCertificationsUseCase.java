// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/certification/ListCertificationsUseCase.java
package com.certifapp.domain.port.input.certification;

import com.certifapp.domain.model.certification.Certification;
import java.util.List;

/**
 * Use case: retrieve all certifications visible in the catalogue.
 */
public interface ListCertificationsUseCase {
    /**
     * Returns all certifications, optionally filtered to active-only.
     *
     * @param activeOnly if {@code true}, only return certifications with {@code is_active = true}
     * @return immutable list of certifications ordered by name
     */
    List<Certification> execute(boolean activeOnly);
}
