// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/CertificationRepository.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.certification.Certification;
import java.util.List;
import java.util.Optional;

/** Output port: persistence operations for {@link Certification}. */
public interface CertificationRepository {
    Optional<Certification> findById(String id);
    List<Certification>     findAll(boolean activeOnly);
    Certification           save(Certification certification);
}
