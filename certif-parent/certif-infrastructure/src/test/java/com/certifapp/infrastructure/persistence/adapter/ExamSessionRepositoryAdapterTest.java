package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.port.output.ExamSessionRepository;
import com.certifapp.infrastructure.persistence.mapper.ExamSessionMapper;
import com.certifapp.infrastructure.persistence.repository.ExamSessionJpaRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class ExamSessionRepositoryAdapterTest {

    @Mock
    private ExamSessionJpaRepository jpaRepository;

    @Mock
    private ExamSessionMapper mapper;

    @InjectMocks
    private ExamSessionRepositoryAdapter repositoryAdapter;

    private UUID sessionId;
    private ExamSession examSession;
    private String certId;
    private UUID userId;

    @BeforeEach
    void setUp() {
        sessionId = UUID.randomUUID();
        certId = "cert123";
        userId = UUID.randomUUID();
        examSession = new ExamSession(sessionId, userId, certId, ExamMode.PRACTICE, OffsetDateTime.now(), OffsetDateTime.now());
    }

    @Test
    @DisplayName("findById_nominalCase_success")
    void findById_nominalCase_success() {
        when(jpaRepository.findById(eq(sessionId))).thenReturn(Optional.of(mapper.toEntity(examSession)));
        Optional<ExamSession> result = repositoryAdapter.findById(sessionId);
        assertThat(result).isPresent();
        assertThat(result.get()).isEqualTo(examSession);
    }

    @Test
    @DisplayName("findById_edgeCase_noSuchElement_returnEmpty")
    void findById_edgeCase_noSuchElement_returnEmpty() {
        when(jpaRepository.findById(eq(sessionId))).thenReturn(Optional.empty());
        Optional<ExamSession> result = repositoryAdapter.findById(sessionId);
        assertThat(result).isNotPresent();
    }

    @Test
    @DisplayName("countTodayByUserAndCertification_nominalCase_success")
    void countTodayByUserAndCertification_nominalCase_success() {
        OffsetDateTime startOfDay = LocalDate.now().atStartOfDay().atOffset(ZoneOffset.UTC);
        when(jpaRepository.countTodayByUserAndCertification(eq(userId), eq(certId), eq(ExamMode.PRACTICE.name()), eq(startOfDay))).thenReturn(1);
        int count = repositoryAdapter.countTodayByUserAndCertification(userId, certId, ExamMode.PRACTICE);
        assertThat(count).isEqualTo(1);
    }

    @Test
    @DisplayName("countTodayByUserAndCertification_edgeCase_noResults_returnZero")
    void countTodayByUserAndCertification_edgeCase_noResults_returnZero() {
        when(jpaRepository.countTodayByUserAndCertification(eq(userId), eq(certId), eq(ExamMode.PRACTICE.name()), any())).thenReturn(0);
        int count = repositoryAdapter.countTodayByUserAndCertification(userId, certId, ExamMode.PRACTICE);
        assertThat(count).isEqualTo(0);
    }

    @Test
    @DisplayName("findByUserId_nominalCase_success")
    void findByUserId_nominalCase_success() {
        LocalDate from = LocalDate.now();
        LocalDate to = LocalDate.now().plusDays(1);
        OffsetDateTime fromDt = from.atStartOfDay().atOffset(ZoneOffset.UTC);
        OffsetDateTime toDt = to.atTime(LocalTime.MAX).atOffset(ZoneOffset.UTC);
        String modeStr = ExamMode.PRACTICE.name();
        when(jpaRepository.findByUserIdWithFilters(eq(userId), eq(certId), eq(modeStr), eq(fromDt), eq(toDt), any(PageRequest.class)))
                .thenReturn(List.of(mapper.toEntity(examSession)));
        List<ExamSession> result = repositoryAdapter.findByUserId(userId, certId, ExamMode.PRACTICE, from, to, 0, 10);
        assertThat(result).isNotEmpty();
        assertThat(result.get(0)).isEqualTo(examSession);
    }

    @Test
    @DisplayName("findByUserId_edgeCase_noResults_returnEmptyList")
    void findByUserId_edgeCase_noResults_returnEmptyList() {
        LocalDate from = LocalDate.now();
        LocalDate to = LocalDate.now().plusDays(1);
        when(jpaRepository.findByUserIdWithFilters(eq(userId), eq(certId), any(), any(), any(), any(PageRequest.class))).thenReturn(List.of());
        List<ExamSession> result = repositoryAdapter.findByUserId(userId, certId, ExamMode.PRACTICE, from, to, 0, 10);
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("save_nominalCase_success")
    void save_nominalCase_success() {
        when(mapper.toEntity(eq(examSession))).thenReturn(new com.certifapp.infrastructure.persistence.entity.ExamSession());
        when(jpaRepository.save(any(com.certifapp.infrastructure.persistence.entity.ExamSession.class))).thenReturn(new com.certifapp.infrastructure.persistence.entity.ExamSession());
        when(mapper.toDomain(any(com.certifapp.infrastructure.persistence.entity.ExamSession.class))).thenReturn(examSession);
        ExamSession result = repositoryAdapter.save(examSession);
        assertThat(result).isEqualTo(examSession);
    }

    @Test
    @DisplayName("save_edgeCase_exception_throwsException")
    void save_edgeCase_exception_throwsException() {
        when(mapper.toEntity(eq(examSession))).thenReturn(new com.certifapp.infrastructure.persistence.entity.ExamSession());
        when(jpaRepository.save(any(com.certifapp.infrastructure.persistence.entity.ExamSession.class))).thenThrow(new RuntimeException("Error saving exam session"));
        assertThatThrownBy(() -> repositoryAdapter.save(examSession)).isInstanceOf(RuntimeException.class);
    }
}
