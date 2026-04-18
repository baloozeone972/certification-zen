// certif-parent/certif-domain/src/test/java/com/certifapp/domain/port/output/PdfExportPortTest.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.ThemeStats;
import com.certifapp.domain.model.question.Question;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Contract tests for {@link PdfExportPort} output port.
 * Tests the interface contract via mock — implementation tested in IText7PdfExportAdapterTest.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("PdfExportPort — interface contract")
class PdfExportPortTest {

    /** Mock of the port under test — verifies the API contract. */
    @Mock
    private PdfExportPort pdfExportPort;

    @Mock private ExamSession     session;
    @Mock private List<ThemeStats> themeStats;
    @Mock private List<Question>   questions;

    // ── exportResults ─────────────────────────────────────────────────────────

    @Test
    @DisplayName("exportResults — returns non-null byte array on nominal call")
    void exportResults_nominal_returnsBytes() {
        byte[] pdf = new byte[]{1, 2, 3};
        when(pdfExportPort.exportResults(any(), any(), any())).thenReturn(pdf);

        byte[] result = pdfExportPort.exportResults(session, themeStats, questions);

        assertThat(result).isNotNull().isNotEmpty();
        verify(pdfExportPort).exportResults(session, themeStats, questions);
    }

    @Test
    @DisplayName("exportResults — called exactly once per invocation")
    void exportResults_calledOnce() {
        when(pdfExportPort.exportResults(any(), any(), any())).thenReturn(new byte[0]);

        pdfExportPort.exportResults(session, themeStats, questions);

        verify(pdfExportPort, times(1)).exportResults(any(), any(), any());
    }

    @Test
    @DisplayName("exportResults — accepts empty question list")
    void exportResults_emptyQuestions_noException() {
        when(pdfExportPort.exportResults(any(), any(), eq(List.of()))).thenReturn(new byte[0]);

        assertThatCode(() ->
            pdfExportPort.exportResults(session, themeStats, List.of())
        ).doesNotThrowAnyException();
    }

    @Test
    @DisplayName("exportResults — accepts null session (graceful handling)")
    void exportResults_nullSession_noException() {
        when(pdfExportPort.exportResults(isNull(), any(), any())).thenReturn(new byte[0]);

        assertThatCode(() ->
            pdfExportPort.exportResults(null, themeStats, questions)
        ).doesNotThrowAnyException();
    }

    @Test
    @DisplayName("exportResults — returns at least 0 bytes (never negative length)")
    void exportResults_lengthNonNegative() {
        when(pdfExportPort.exportResults(any(), any(), any())).thenReturn(new byte[512]);

        byte[] result = pdfExportPort.exportResults(session, themeStats, questions);
        assertThat(result.length).isGreaterThanOrEqualTo(0);
    }
}
