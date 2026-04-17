// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/PdfExportPort.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.ThemeStats;

import java.util.List;

/**
 * Output port for PDF export — implemented by iText7 in certif-infrastructure.
 */
public interface PdfExportPort {
    /**
     * Generates a PDF report for a completed exam session.
     *
     * @param session    the completed session
     * @param themeStats per-theme statistics
     * @param questions  all questions of the session (with correct answers and explanations)
     * @return PDF content as a byte array
     */
    byte[] exportResults(ExamSession session, List<ThemeStats> themeStats, List<Question> questions);
}
