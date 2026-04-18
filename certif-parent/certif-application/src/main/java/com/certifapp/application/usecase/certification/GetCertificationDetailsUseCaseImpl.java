// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/certification/GetCertificationDetailsUseCaseImpl.java
package com.certifapp.application.usecase.certification;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.port.input.certification.GetCertificationDetailsUseCase;
import com.certifapp.domain.port.output.CertificationRepository;

/**
 * Implementation of {@link GetCertificationDetailsUseCase}.
 */
public class GetCertificationDetailsUseCaseImpl implements GetCertificationDetailsUseCase {

    private final CertificationRepository certificationRepository;

    public GetCertificationDetailsUseCaseImpl(CertificationRepository certificationRepository) {
        this.certificationRepository = certificationRepository;
    }

    /**
     * {@inheritDoc}
     *
     * @param certificationId the certification slug (e.g. {@code "ocp21"})
     * @return the matching {@link Certification}
     * @throws CertificationNotFoundException if not found
     */
    @Override
    public Certification execute(String certificationId) {
        return certificationRepository.findById(certificationId)
                .orElseThrow(() -> new CertificationNotFoundException(certificationId));
    }
}
