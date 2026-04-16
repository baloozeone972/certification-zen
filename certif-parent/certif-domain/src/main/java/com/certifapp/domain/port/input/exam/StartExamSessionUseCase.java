// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/exam/StartExamSessionUseCase.java
package com.certifapp.domain.port.input.exam;

import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.session.ExamSession;
import java.util.List;
import java.util.UUID;

/**
 * Use case: start a new exam session and draw the question set.
 */
public interface StartExamSessionUseCase {

    /**
     * Command record encapsulating all session start parameters.
     *
     * @param userId           user starting the session
     * @param certificationId  target certification
     * @param mode             EXAM | FREE | REVISION
     * @param selectedThemes   theme codes selected by the user (empty = all themes, EXAM only)
     * @param questionCount    number of questions requested (0 = use certification default)
     * @param durationMinutes  custom timer in minutes (0 = unlimited, FREE mode only)
     */
    record StartExamCommand(
            UUID         userId,
            String       certificationId,
            ExamMode     mode,
            List<String> selectedThemes,
            int          questionCount,
            int          durationMinutes
    ) {
        public StartExamCommand {
            if (userId == null) throw new IllegalArgumentException("userId must not be null");
            if (certificationId == null || certificationId.isBlank())
                throw new IllegalArgumentException("certificationId must not be blank");
            if (mode == null) throw new IllegalArgumentException("mode must not be null");
            selectedThemes = selectedThemes == null ? List.of() : List.copyOf(selectedThemes);
        }
    }

    /**
     * Creates and persists the session, returning it with the drawn questions.
     *
     * @param command session configuration
     * @return the created {@link ExamSession} with {@code IN_PROGRESS} status
     * @throws com.certifapp.domain.exception.FreemiumLimitExceededException if FREE limits exceeded
     * @throws com.certifapp.domain.exception.CertificationNotFoundException if cert not found
     */
    ExamSession execute(StartExamCommand command);
}
