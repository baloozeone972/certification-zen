package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.certification.CertificationTheme;
import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.question.QuestionFilter;
import com.certifapp.domain.port.output.CertificationRepository;
import com.certifapp.infrastructure.persistence.entity.QuestionEntity;
import com.certifapp.infrastructure.persistence.mapper.QuestionMapper;
import com.certifapp.infrastructure.persistence.repository.QuestionJpaRepository;
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

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@DataJpaTest
@ExtendWith({SpringExtension.class, MockitoExtension.class})
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE)
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class QuestionRepositoryAdapterTest {

    @Container
    public static PostgreSQLContainer<?> postgresql = new PostgreSQLContainer<>("postgres:latest")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @Mock
    private QuestionJpaRepository jpaRepository;

    @Mock
    private CertificationRepository certificationRepository;

    @InjectMocks
    private QuestionRepositoryAdapter questionRepositoryAdapter;

    @Mock
    private QuestionMapper mapper;

    @BeforeEach
    public void setUp() {
        when(mapper.toDomain(any(QuestionEntity.class))).thenReturn(new Question());
        when(mapper.toEntity(any(Question.class))).thenReturn(new QuestionEntity());
    }

    @Test
    @DisplayName("findById_nominalCase")
    public void findById_nominalCase() {
        UUID id = UUID.randomUUID();
        when(jpaRepository.findById(id)).thenReturn(Optional.of(new QuestionEntity()));

        Optional<Question> result = questionRepositoryAdapter.findById(id);

        assertThat(result).isPresent();
        verify(jpaRepository).findById(id);
    }

    @Test
    @DisplayName("findByLegacyId_nominalCase")
    public void findByLegacyId_nominalCase() {
        String legacyId = "legacy123";
        when(jpaRepository.findByLegacyId(legacyId)).thenReturn(Optional.of(new QuestionEntity()));

        Optional<Question> result = questionRepositoryAdapter.findByLegacyId(legacyId);

        assertThat(result).isPresent();
        verify(jpaRepository).findByLegacyId(legacyId);
    }

    @Test
    @DisplayName("findByFilter_noThemes")
    public void findByFilter_noThemes() {
        String certificationId = "cert123";
        int limit = 5;
        QuestionFilter filter = new QuestionFilter(certificationId, Collections.emptyList(), limit);

        when(jpaRepository.findByCertificationIdActiveRandom(certificationId)).thenReturn(Arrays.asList(new QuestionEntity()));

        List<Question> result = questionRepositoryAdapter.findByFilter(filter);

        assertThat(result).hasSize(limit);
        verify(jpaRepository).findByCertificationIdActiveRandom(certificationId);
    }

    @Test
    @DisplayName("findByFilter_withThemes")
    public void findByFilter_withThemes() {
        String certificationId = "cert123";
        List<String> themeCodes = Arrays.asList("themeA", "themeB");
        int limit = 5;
        QuestionFilter filter = new QuestionFilter(certificationId, themeCodes, limit);

        List<UUID> themeIds = Arrays.asList(UUID.randomUUID(), UUID.randomUUID());
        when(certificationRepository.findById(certificationId)).thenReturn(Optional.of(new CertificationTheme()));
        when(jpaRepository.findByCertificationIdAndThemeIdsRandom(eq(certificationId), anyList())).thenReturn(Arrays.asList(new QuestionEntity()));

        List<Question> result = questionRepositoryAdapter.findByFilter(filter);

        assertThat(result).hasSize(limit);
        verify(jpaRepository).findByCertificationIdAndThemeIdsRandom(certificationId, themeIds);
    }

    @Test
    @DisplayName("countByTheme_nominalCase")
    public void countByTheme_nominalCase() {
        String certificationId = "cert123";
        when(jpaRepository.countByThemeForCertification(certificationId)).thenReturn(Arrays.asList(new Object[]{UUID.randomUUID(), 5L}));

        Map<String, Integer> result = questionRepositoryAdapter.countByTheme(certificationId);

        assertThat(result).hasSize(1);
        verify(jpaRepository).countByThemeForCertification(certificationId);
    }

    @Test
    @DisplayName("save_nominalCase")
    public void save_nominalCase() {
        Question question = new Question();
        when(mapper.toEntity(question)).thenReturn(new QuestionEntity());

        Question savedQuestion = questionRepositoryAdapter.save(question);

        assertThat(savedQuestion).isNotNull();
        verify(jpaRepository).save(any(QuestionEntity.class));
    }

    @Test
    @DisplayName("saveAll_nominalCase")
    public void saveAll_nominalCase() {
        List<Question> questions = Arrays.asList(new Question(), new Question());
        when(mapper.toEntity(question)).thenReturn(new QuestionEntity());

        List<Question> savedQuestions = questionRepositoryAdapter.saveAll(questions);

        assertThat(savedQuestions).hasSize(2);
        verify(jpaRepository, times(2)).save(any(QuestionEntity.class));
    }

    @Test
    @DisplayName("resolveThemeIds_nominalCase")
    public void resolveThemeIds_nominalCase() {
        String certificationId = "cert123";
        List<String> themeCodes = Arrays.asList("themeA", "themeB");
        when(certificationRepository.findById(certificationId)).thenReturn(Optional.of(new CertificationTheme()));

        List<UUID> result = questionRepositoryAdapter.resolveThemeIds(certificationId, themeCodes);

        assertThat(result).hasSize(2);
    }

}