// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/certification/ListCertificationsUseCaseImpl.java
package com.certifapp.application.usecase.certification;

import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.port.input.certification.ListCertificationsUseCase;
import com.certifapp.domain.port.output.CertificationRepository;

import java.util.List;

/**
 * Implementation of {@link ListCertificationsUseCase}.
 *
 * <p>Delegates directly to the {@link CertificationRepository} output port.
 * Results are cached at the infrastructure layer (Caffeine TTL 1h).</p>
 */
public class ListCertificationsUseCaseImpl implements ListCertificationsUseCase {

    private final CertificationRepository certificationRepository;

    public ListCertificationsUseCaseImpl(CertificationRepository certificationRepository) {
        this.certificationRepository = certificationRepository;
    }

    /**
     * {@inheritDoc}
     *
     * @param activeOnly if {@code true}, only active certifications are returned
     * @return immutable list of certifications ordered by name
     */
    @Override
    public List<Certification> execute(boolean activeOnly) {
        return certificationRepository.findAll(activeOnly);
    }
}
