// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/exam/SubmitExamUseCaseImpl.java
package com.certifapp.application.usecase.exam;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.exception.ExamAlreadyCompletedException;
import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.SessionStatus;
import com.certifapp.domain.model.session.UserAnswer;
import com.certifapp.domain.port.input.exam.SubmitExamUseCase;
import com.certifapp.domain.port.output.CertificationRepository;
import com.certifapp.domain.port.output.ExamSessionRepository;
import com.certifapp.domain.port.output.QuestionRepository;
import com.certifapp.domain.port.output.UserAnswerRepository;
import com.certifapp.domain.service.ScoringService;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Implementation of {@link SubmitExamUseCase}.
 *
 * <p>Canonical scoring:
 * {@code percentage = correctCount * 100.0 / totalQuestions}
 * {@code passed = percentage >= certification.passingScore()}</p>
 */
public class SubmitExamUseCaseImpl implements SubmitExamUseCase {

    private final ExamSessionRepository sessionRepository;
    private final UserAnswerRepository answerRepository;
    private final QuestionRepository questionRepository;
    private final CertificationRepository certificationRepository;
    private final ScoringService scoringService;

    public SubmitExamUseCaseImpl(
            ExamSessionRepository sessionRepository,
            UserAnswerRepository answerRepository,
            QuestionRepository questionRepository,
            CertificationRepository certificationRepository,
            ScoringService scoringService) {
        this.sessionRepository = sessionRepository;
        this.answerRepository = answerRepository;
        this.questionRepository = questionRepository;
        this.certificationRepository = certificationRepository;
        this.scoringService = scoringService;
    }

    @Override
    public ExamSession execute(UUID sessionId, UUID userId) {
        ExamSession session = sessionRepository.findById(sessionId)
                .orElseThrow(() -> new ExamSessionNotFoundException(sessionId));

        if (!session.userId().equals(userId)) {
            throw new ExamSessionNotFoundException(sessionId);
        }
        if (session.status().isFinished()) {
            throw new ExamAlreadyCompletedException(sessionId);
        }

        // Load all answers for this session
        List<UserAnswer> answers = answerRepository.findBySessionId(sessionId);

        // Load all questions for scoring
        List<UUID> questionIds = answers.stream()
                .map(UserAnswer::questionId).distinct().toList();
        List<Question> questions = questionIds.stream()
                .map(qid -> questionRepository.findById(qid).orElse(null))
                .filter(q -> q != null)
                .toList();
        Map<UUID, Question> questionMap = questions.stream()
                .collect(Collectors.toMap(Question::id, q -> q));

        // Load certification for passing threshold
        Certification cert = certificationRepository.findById(session.certificationId())
                .orElseThrow(() -> new CertificationNotFoundException(session.certificationId()));

        // Calculate scores
        ScoringService.ScoringResult result = scoringService.score(
                answers, questions, cert.passingScore(), session.totalQuestions());

        // Compute actual elapsed time
        OffsetDateTime endedAt = OffsetDateTime.now();
        int durationSeconds = (int) java.time.Duration.between(session.startedAt(), endedAt)
                .getSeconds();

        // Build updated session with final scores
        ExamSession completed = new ExamSession(
                session.id(), session.userId(), session.certificationId(),
                session.mode(), SessionStatus.COMPLETED,
                session.startedAt(), endedAt, durationSeconds,
                session.totalQuestions(), result.correctCount(),
                result.percentage(), result.passed(), answers);

        return sessionRepository.save(completed);
    }
}
