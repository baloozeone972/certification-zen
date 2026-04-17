// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/exam/SubmitAnswerUseCaseImpl.java
package com.certifapp.application.usecase.exam;

import com.certifapp.domain.exception.ExamAlreadyCompletedException;
import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.UserAnswer;
import com.certifapp.domain.port.input.exam.SubmitAnswerUseCase;
import com.certifapp.domain.port.output.ExamSessionRepository;
import com.certifapp.domain.port.output.QuestionRepository;
import com.certifapp.domain.port.output.UserAnswerRepository;
import com.certifapp.domain.service.ScoringService;

import java.util.Map;
import java.util.UUID;

/**
 * Implementation of {@link SubmitAnswerUseCase}.
 *
 * <p>Records the user's answer in real time during an exam session,
 * evaluating correctness immediately against the question corpus.</p>
 */
public class SubmitAnswerUseCaseImpl implements SubmitAnswerUseCase {

    private final ExamSessionRepository sessionRepository;
    private final QuestionRepository questionRepository;
    private final UserAnswerRepository answerRepository;
    private final ScoringService scoringService;

    public SubmitAnswerUseCaseImpl(
            ExamSessionRepository sessionRepository,
            QuestionRepository questionRepository,
            UserAnswerRepository answerRepository,
            ScoringService scoringService) {
        this.sessionRepository = sessionRepository;
        this.questionRepository = questionRepository;
        this.answerRepository = answerRepository;
        this.scoringService = scoringService;
    }

    @Override
    public UserAnswer execute(SubmitAnswerCommand command) {
        // Verify session exists and is owned by the user
        ExamSession session = sessionRepository.findById(command.sessionId())
                .orElseThrow(() -> new ExamSessionNotFoundException(command.sessionId()));

        if (!session.userId().equals(command.userId())) {
            throw new ExamSessionNotFoundException(command.sessionId());
        }

        if (session.status().isFinished()) {
            throw new ExamAlreadyCompletedException(command.sessionId());
        }

        // Build and evaluate the answer
        UserAnswer answer = (command.selectedOptionId() == null)
                ? UserAnswer.skipped(command.sessionId(), command.questionId())
                : UserAnswer.answered(command.sessionId(), command.questionId(),
                command.selectedOptionId(), command.responseTimeMs());

        // Evaluate correctness
        Question question = questionRepository.findById(command.questionId()).orElse(null);
        if (question != null) {
            Map<UUID, Question> qMap = Map.of(question.id(), question);
            answer = scoringService.evaluateAnswer(answer, qMap);
        }

        return answerRepository.save(answer);
    }
}
