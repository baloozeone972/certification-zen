```java
package com.certifapp.infrastructure.persistence.mapper;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CertificationMapperTest {

    @InjectMocks
    private CertificationMapper certificationMapper;

    @Mock
    private List<CertificationEntity> mockCertificationEntities;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("toDomain should map a single CertificationEntity to a Certification")
    public void testToDomain_singleEntity() {
        CertificationEntity entity = new CertificationEntity();
        entity.setCertificationId(1L);
        entity.setTitle("Java Programming");
        List<CertificationThemeEntity> themeEntities = mock(List.class);

        Certification result = certificationMapper.toDomain(entity);

        assertThat(result.getCertificationId()).isEqualTo(entity.getCertificationId());
        assertThat(result.getTitle()).isEqualTo(entity.getTitle());
    }

    @Test
    @DisplayName("toDomainList should map a list of CertificationEntities to a list of Certifications")
    public void testToDomainList() {
        CertificationEntity entity1 = new CertificationEntity();
        entity1.setCertificationId(1L);
        entity1.setTitle("Java Programming");

        CertificationEntity entity2 = new CertificationEntity();
        entity2.setCertificationId(2L);
        entity2.setTitle("Python Basics");

        when(mockCertificationEntities.stream()).thenReturn(Stream.of(entity1, entity2));

        List<Certification> result = certificationMapper.toDomainList(mockCertificationEntities);

        assertThat(result.size()).isEqualTo(2);
        assertThat(result.get(0).getCertificationId()).isEqualTo(1L);
        assertThat(result.get(1).getCertificationId()).isEqualTo(2L);
    }

    @Test
    @DisplayName("toDomain should map a single CertificationThemeEntity to a CertificationTheme")
    public void testToDomain_singleTheme() {
        CertificationThemeEntity entity = new CertificationThemeEntity();
        entity.setId(1L);
        entity.setTitle("Spring Framework");

        CertificationTheme result = certificationMapper.toDomain(entity);

        assertThat(result.getId()).isEqualTo(entity.getId());
        assertThat(result.getTitle()).isEqualTo(entity.getTitle());
    }

    @Test
    @DisplayName("toEntity should map a single Certification to a CertificationEntity")
    public void testToEntity() {
        Certification domain = new Certification();
        domain.setCertificationId(1L);
        domain.setTitle("Java Programming");

        CertificationEntity result = certificationMapper.toEntity(domain);

        assertThat(result.getCertificationId()).isEqualTo(domain.getCertificationId());
        assertThat(result.getTitle()).isEqualTo(domain.getTitle());
    }
}
```
