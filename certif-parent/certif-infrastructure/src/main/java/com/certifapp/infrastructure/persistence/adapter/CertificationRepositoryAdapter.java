// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/adapter/CertificationRepositoryAdapter.java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.port.output.CertificationRepository;
import com.certifapp.infrastructure.persistence.mapper.CertificationMapper;
import com.certifapp.infrastructure.persistence.repository.CertificationJpaRepository;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

/**
 * Adapter implementing {@link CertificationRepository}.
 * Results are cached with Caffeine (TTL 1h) — certifications change rarely.
 */
@Component
public class CertificationRepositoryAdapter implements CertificationRepository {

    private final CertificationJpaRepository jpaRepository;
    private final CertificationMapper mapper;

    public CertificationRepositoryAdapter(
            CertificationJpaRepository jpaRepository, CertificationMapper mapper) {
        this.jpaRepository = jpaRepository;
        this.mapper = mapper;
    }

    @Override
    @Cacheable("certifications")
    public Optional<Certification> findById(String id) {
        return jpaRepository.findById(id).map(mapper::toDomain);
    }

    @Override
    @Cacheable("certificationsList")
    public List<Certification> findAll(boolean activeOnly) {
        var entities = activeOnly
                ? jpaRepository.findAllActiveWithThemes()
                : jpaRepository.findAllWithThemes();
        return mapper.toDomainList(entities);
    }

    @Override
    public Certification save(Certification certification) {
        return mapper.toDomain(jpaRepository.save(mapper.toEntity(certification)));
    }
}
