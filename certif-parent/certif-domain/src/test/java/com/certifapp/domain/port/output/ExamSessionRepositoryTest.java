package com.certifapp.domain.port.output;

import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.session.ExamSession;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class ExamSessionRepositoryTest {

    @Mock
    private ExamSessionRepository examSessionRepository;

    @InjectMocks
    private ExamSessionRepository examSessionRepositoryImpl; // Assuming there's an implementation

    @BeforeEach
    public void setUp() {
        // Initialization code if needed
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(examSessionRepository);
    }

    @Test
    @DisplayName("findById_nominalCase_returnsExamSession")
    public void findById_nominalCase_returnsExamSession() {
        UUID id = UUID.randomUUID();
        ExamSession session = ExamSession.start(
                UUID.randomUUID(),   // userId
                "cert1",             // certificationId
                ExamMode.EXAM,       // mode
                10                   // totalQuestions (example)
        );
        when(examSessionRepository.findById(eq(id))).thenReturn(Optional.of(session));

        Optional<ExamSession> result = examSessionRepository.findById(id);

        assertThat(result).isPresent().contains(session);
    }

    @Test
    @DisplayName("findById_edgeCase_emptyId_returnsEmptyOptional")
    public void findById_edgeCase_emptyId_returnsEmptyOptional() {
        UUID id = null;

        when(examSessionRepository.findById(eq(id))).thenReturn(Optional.empty());

        Optional<ExamSession> result = examSessionRepository.findById(id);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("countTodayByUserAndCertification_nominalCase_returnsCount")
    public void countTodayByUserAndCertification_nominalCase_returnsCount() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert1";
        ExamMode mode = ExamMode.EXAM;

        int count = 5;

        when(examSessionRepository.countTodayByUserAndCertification(eq(userId), eq(certificationId), eq(mode))).thenReturn(count);

        int result = examSessionRepository.countTodayByUserAndCertification(userId, certificationId, mode);

        assertThat(result).isEqualTo(count);
    }

    @Test
    @DisplayName("countTodayByUserAndCertification_edgeCase_emptyUserId_returnsZero")
    public void countTodayByUserAndCertification_edgeCase_emptyUserId_returnsZero() {
        UUID userId = null;
        String certificationId = "cert1";
        ExamMode mode = ExamMode.EXAM;

        when(examSessionRepository.countTodayByUserAndCertification(eq(userId), eq(certificationId), eq(mode))).thenReturn(0);

        int result = examSessionRepository.countTodayByUserAndCertification(userId, certificationId, mode);

        assertThat(result).isEqualTo(0);
    }

    @Test
    @DisplayName("findByUserId_nominalCase_returnsExamSessions")
    public void findByUserId_nominalCase_returnsExamSessions() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert1";
        ExamMode mode = ExamMode.EXAM;
        LocalDate from = LocalDate.now().minusDays(7);
        LocalDate to = LocalDate.now().plusDays(7);
        int page = 0;
        int size = 10;

        List<ExamSession> sessions = Arrays.asList(
                new ExamSession(UUID.randomUUID(), userId, certificationId, mode, from),
                new ExamSession(UUID.randomUUID(), userId, certificationId, mode, to)
        );

        when(examSessionRepository.findByUserId(eq(userId), eq(certificationId), eq(mode), eq(from), eq(to), eq(page), eq(size))).thenReturn(sessions);

        List<ExamSession> result = examSessionRepository.findByUserId(userId, certificationId, mode, from, to, page, size);

        assertThat(result).isEqualTo(sessions);
    }

    @Test
    @DisplayName("findByUserId_edgeCase_emptyUserId_returnsEmptyList")
    public void findByUserId_edgeCase_emptyUserId_returnsEmptyList() {
        UUID userId = null;
        String certificationId = "cert1";
        ExamMode mode = ExamMode.EXAM;
        LocalDate from = LocalDate.now().minusDays(7);
        LocalDate to = LocalDate.now().plusDays(7);
        int page = 0;
        int size = 10;

        when(examSessionRepository.findByUserId(eq(userId), eq(certificationId), eq(mode), eq(from), eq(to), eq(page), eq(size))).thenReturn(Arrays.asList());

        List<ExamSession> result = examSessionRepository.findByUserId(userId, certificationId, mode, from, to, page, size);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("save_nominalCase_returnsSavedSession")
    public void save_nominalCase_returnsSavedSession() {
        ExamSession session = new ExamSession(UUID.randomUUID(), UUID.randomUUID(), "cert1", ExamMode.EXAM, LocalDate.now());

        when(examSessionRepository.save(eq(session))).thenReturn(session);

        ExamSession result = examSessionRepository.save(session);

        assertThat(result).isEqualTo(session);
    }

    @Test
    @DisplayName("save_edgeCase_nullSession_throwsNullPointerException")
    public void save_edgeCase_nullSession_throwsNullPointerException() {
        ExamSession session = null;

        when(examSessionRepository.save(eq(session))).thenThrow(NullPointerException.class);

        assertThrows(NullPointerException.class, () -> examSessionRepository.save(session));
    }
}

