package com.certifapp.application.usecase.exam;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.exception.ExamAlreadyCompletedException;
import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.SessionStatus;
import com.certifapp.domain.model.session.UserAnswer;
import com.certifapp.domain.port.output.CertificationRepository;
import com.certifapp.domain.port.output.ExamSessionRepository;
import com.certifapp.domain.port.output.QuestionRepository;
import com.certifapp.domain.port.output.UserAnswerRepository;
import com.certifapp.domain.service.ScoringService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class SubmitExamUseCaseImplTest {

    @Mock
    private ExamSessionRepository sessionRepository;

    @Mock
    private UserAnswerRepository answerRepository;

    @Mock
    private QuestionRepository questionRepository;

    @Mock
    private CertificationRepository certificationRepository;

    @Mock
    private ScoringService scoringService;

    @InjectMocks
    private SubmitExamUseCaseImpl submitExamUseCase;

    private UUID sessionId;
    private UUID userId;
    private ExamSession session;
    private List<UserAnswer> answers;
    private List<Question> questions;
    private Certification certification;

    @BeforeEach
    public void setUp() {
        sessionId = UUID.randomUUID();
        userId = UUID.randomUUID();

        session = new ExamSession(
                sessionId, userId, UUID.randomUUID(), SessionMode.ONLINE,
                SessionStatus.IN_PROGRESS, OffsetDateTime.now(),
                null, 0, 10, 5, 85.0, true, Collections.emptyList());

        answers = Arrays.asList(
                new UserAnswer(sessionId, UUID.randomUUID(), "answer1"),
                new UserAnswer(sessionId, UUID.randomUUID(), "answer2"));

        questions = Arrays.asList(
                new Question(UUID.randomUUID(), "question1", null, 5),
                new Question(UUID.randomUUID(), "question2", null, 5));

        certification = new Certification(UUID.randomUUID(), 80.0);
    }

    @Test
    @DisplayName("nominal case: exam session completed successfully")
    public void submitExam_success() {
        when(sessionRepository.findById(sessionId))
                .thenReturn(Optional.of(session));
        when(answerRepository.findBySessionId(sessionId))
                .thenReturn(answers);
        when(questionRepository.findById(any(UUID.class)))
                .thenReturn(Optional.ofNullable(questions.get(0)));
        when(certificationRepository.findById(session.certificationId()))
                .thenReturn(Optional.of(certification));
        when(scoringService.score(any(), any(), anyDouble(), anyInt()))
                .thenReturn(new ScoringService.ScoringResult(2, 85.0, true));

        ExamSession completed = submitExamUseCase.execute(sessionId, userId);

        assertThat(completed.status()).isEqualTo(SessionStatus.COMPLETED);
        assertThat(completed.percentage()).isEqualTo(85.0);
        assertThat(completed.passed()).isTrue();
        verify(sessionRepository).save(completed);
    }

    @Test
    @DisplayName("edge case: exam session not found")
    public void submitExam_examSessionNotFound() {
        when(sessionRepository.findById(sessionId))
                .thenReturn(Optional.empty());

        assertThrows(ExamSessionNotFoundException.class, () ->
                submitExamUseCase.execute(sessionId, userId));
    }

    @Test
    @DisplayName("edge case: exam session belongs to another user")
    public void submitExam_examSessionBelongsToAnotherUser() {
        when(sessionRepository.findById(sessionId))
                .thenReturn(Optional.of(new ExamSession(
                        sessionId, UUID.randomUUID(), UUID.randomUUID(),
                        SessionMode.ONLINE, SessionStatus.IN_PROGRESS,
                        OffsetDateTime.now(), null, 0, 10, 5, 85.0, true,
                        Collections.emptyList())));

        assertThrows(ExamSessionNotFoundException.class, () ->
                submitExamUseCase.execute(sessionId, userId));
    }

    @Test
    @DisplayName("edge case: exam session already completed")
    public void submitExam_examSessionAlreadyCompleted() {
        when(sessionRepository.findById(sessionId))
                .thenReturn(Optional.of(new ExamSession(
                        sessionId, userId, UUID.randomUUID(),
                        SessionMode.ONLINE, SessionStatus.COMPLETED,
                        OffsetDateTime.now(), null, 0, 10, 5, 85.0, true,
                        Collections.emptyList())));

        assertThrows(ExamAlreadyCompletedException.class, () ->
                submitExamUseCase.execute(sessionId, userId));
    }

    @Test
    @DisplayName("edge case: certification not found")
    public void submitExam_certificationNotFound() {
        when(sessionRepository.findById(sessionId))
                .thenReturn(Optional.of(session));
        when(certificationRepository.findById(session.certificationId()))
                .thenReturn(Optional.empty());

        assertThrows(CertificationNotFoundException.class, () ->
                submitExamUseCase.execute(sessionId, userId));
    }

    @Test
    @DisplayName("edge case: question not found")
    public void submitExam_questionNotFound() {
        when(sessionRepository.findById(sessionId))
                .thenReturn(Optional.of(session));
        when(answerRepository.findBySessionId(sessionId))
                .thenReturn(answers);
        when(questionRepository.findById(any(UUID.class)))
                .thenReturn(Optional.empty());

        assertThrows(ExamSessionNotFoundException.class, () ->
                submitExamUseCase.execute(sessionId, userId));
    }
}

