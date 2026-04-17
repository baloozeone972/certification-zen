// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/session/ExportSessionPdfUseCaseImpl.java
package com.certifapp.application.usecase.session;

import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.ThemeStats;
import com.certifapp.domain.model.session.UserAnswer;
import com.certifapp.domain.model.user.SubscriptionTier;
import com.certifapp.domain.port.input.session.ExportSessionPdfUseCase;
import com.certifapp.domain.port.output.*;
import com.certifapp.domain.service.FreemiumGuardService;
import com.certifapp.domain.service.ScoringService;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Implementation of {@link ExportSessionPdfUseCase}.
 *
 * <p>PDF export is a PRO-only feature. The actual PDF generation is delegated
 * to the {@code PdfExportPort} implemented by iText7 in certif-infrastructure.</p>
 */
public class ExportSessionPdfUseCaseImpl implements ExportSessionPdfUseCase {

    private final ExamSessionRepository sessionRepository;
    private final QuestionRepository questionRepository;
    private final UserRepository userRepository;
    private final UserAnswerRepository answerRepository;
    private final PdfExportPort pdfExportPort;
    private final FreemiumGuardService freemiumGuardService;
    private final ScoringService scoringService;

    public ExportSessionPdfUseCaseImpl(
            ExamSessionRepository sessionRepository,
            QuestionRepository questionRepository,
            UserRepository userRepository,
            UserAnswerRepository answerRepository,
            PdfExportPort pdfExportPort,
            FreemiumGuardService freemiumGuardService,
            ScoringService scoringService) {
        this.sessionRepository = sessionRepository;
        this.questionRepository = questionRepository;
        this.userRepository = userRepository;
        this.answerRepository = answerRepository;
        this.pdfExportPort = pdfExportPort;
        this.freemiumGuardService = freemiumGuardService;
        this.scoringService = scoringService;
    }

    @Override
    public byte[] execute(UUID sessionId, UUID userId) {
        // PRO check
        SubscriptionTier tier = userRepository.findById(userId)
                .map(u -> u.subscriptionTier())
                .orElse(SubscriptionTier.FREE);
        freemiumGuardService.requireUnlimited(tier, "PDF Export");

        // Load session
        ExamSession session = sessionRepository.findById(sessionId)
                .orElseThrow(() -> new ExamSessionNotFoundException(sessionId));
        if (!session.userId().equals(userId)) {
            throw new ExamSessionNotFoundException(sessionId);
        }

        // Load answers and questions
        List<UserAnswer> answers = answerRepository.findBySessionId(sessionId);
        List<UUID> questionIds = answers.stream().map(UserAnswer::questionId).distinct().toList();
        List<Question> questions = questionIds.stream()
                .map(qid -> questionRepository.findById(qid).orElse(null))
                .filter(Objects::nonNull).toList();

        Map<UUID, Question> questionMap = questions.stream()
                .collect(Collectors.toMap(Question::id, q -> q));

        List<ThemeStats> themeStats = scoringService.calculateThemeStats(answers, questionMap);

        return pdfExportPort.exportResults(session, themeStats, questions);
    }
}
