package com.certifapp.infrastructure.persistence.adapter;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;

@ExtendWith({SpringExtension.class, MockitoExtension.class})
@DataJpaTest
@Testcontainers
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class CertificationRepositoryAdapterTest {

    @Container
    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @Mock
    private CertificationJpaRepository jpaRepository;

    @Mock
    private CertificationMapper mapper;

    @InjectMocks
    private CertificationRepositoryAdapter adapter;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(jpaRepository, mapper);
    }

    @Test
    @DisplayName("findById_nominalCase_success")
    public void findById_nominalCase_success() {
        String id = "123";
        CertificationEntity entity = new CertificationEntity();
        Certification certification = new Certification();

        when(jpaRepository.findById(id)).thenReturn(Optional.of(entity));
        when(mapper.toDomain(entity)).thenReturn(certification);

        Optional<Certification> result = adapter.findById(id);

        assertThat(result).isPresent().isEqualTo(certification);
    }

    @Test
    @DisplayName("findById_edgeCase_notFound")
    public void findById_edgeCase_notFound() {
        String id = "123";

        when(jpaRepository.findById(id)).thenReturn(Optional.empty());

        Optional<Certification> result = adapter.findById(id);

        assertThat(result).isNotPresent();
    }

    @Test
    @DisplayName("findAll_activeOnly_true_success")
    public void findAll_activeOnly_true_success() {
        boolean activeOnly = true;
        List<CertificationEntity> entities = List.of(new CertificationEntity());
        List<Certification> certifications = List.of(new Certification());

        when(jpaRepository.findAllActiveWithThemes()).thenReturn(entities);
        when(mapper.toDomainList(entities)).thenReturn(certifications);

        List<Certification> result = adapter.findAll(activeOnly);

        assertThat(result).isEqualTo(certifications);
    }

    @Test
    @DisplayName("findAll_activeOnly_false_success")
    public void findAll_activeOnly_false_success() {
        boolean activeOnly = false;
        List<CertificationEntity> entities = List.of(new CertificationEntity());
        List<Certification> certifications = List.of(new Certification());

        when(jpaRepository.findAllWithThemes()).thenReturn(entities);
        when(mapper.toDomainList(entities)).thenReturn(certifications);

        List<Certification> result = adapter.findAll(activeOnly);

        assertThat(result).isEqualTo(certifications);
    }

    @Test
    @DisplayName("save_nominalCase_success")
    public void save_nominalCase_success() {
        Certification certification = new Certification();
        CertificationEntity entity = new CertificationEntity();

        when(mapper.toEntity(certification)).thenReturn(entity);
        when(jpaRepository.save(entity)).thenReturn(entity);
        when(mapper.toDomain(entity)).thenReturn(certification);

        Certification savedCertification = adapter.save(certification);

        assertThat(savedCertification).isEqualTo(certification);
    }
}