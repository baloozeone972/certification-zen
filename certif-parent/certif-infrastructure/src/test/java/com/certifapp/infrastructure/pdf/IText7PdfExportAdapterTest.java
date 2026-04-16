```java
package com.certifapp.infrastructure.pdf;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import java.io.ByteArrayOutputStream;
import java.time.LocalDateTime;
import java.util.*;
import com.certifapp.domain.model.question.QuestionOption;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.ThemeStats;
import com.certifapp.domain.port.output.PdfExportPort;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class IText7PdfExportAdapterTest {

    @Mock
    private PdfExportPort pdfExportPort;

    @InjectMocks
    private IText7PdfExportAdapter adapter;

    private ExamSession session;
    private List<ThemeStats> themeStats;
    private List<Question> questions;

    @BeforeEach
    public void setUp() {
        session = new ExamSession(UUID.randomUUID(), "cert123", LocalDateTime.now());
        session.setStartedAt(LocalDateTime.now());
        session.setDurationSeconds(90);
        session.setCorrectCount(5);
        session.setTotalQuestions(10);

        themeStats = Collections.singletonList(new ThemeStats("Maths", 4, 1, 5, 80.0));

        questions = Arrays.asList(
            new Question(UUID.randomUUID(), "What is 2+2?", Optional.of(new QuestionOption(UUID.randomUUID(), "A", "3")), List.of()),
            new Question(UUID.randomUUID(), "What is 3*3?", Optional.of(new QuestionOption(UUID.randomUUID(), "B", "9")), List.of())
        );
    }

    @Test
    @DisplayName("Should generate PDF for nominal case")
    public void exportResults_nominalCase_success() {
        byte[] pdfBytes = adapter.exportResults(session, themeStats, questions);
        assertThat(pdfBytes).isNotEmpty();
    }

    @Test
    @DisplayName("Should handle empty theme stats correctly")
    public void exportResults_emptyThemeStats_success() {
        themeStats.clear();
        byte[] pdfBytes = adapter.exportResults(session, themeStats, questions);
        assertThat(pdfBytes).isNotEmpty();
    }

    @Test
    @DisplayName("Should handle empty questions list correctly")
    public void exportResults_emptyQuestionsList_success() {
        questions.clear();
        byte[] pdfBytes = adapter.exportResults(session, themeStats, questions);
        assertThat(pdfBytes).isNotEmpty();
    }

    @Test
    @DisplayName("Should handle null session correctly")
    public void exportResults_nullSession_exception() {
        assertThrows(RuntimeException.class, () -> adapter.exportResults(null, themeStats, questions));
    }

    @Test
    @DisplayName("Should handle null theme stats list correctly")
    public void exportResults_nullThemeStatsList_success() {
        themeStats = null;
        byte[] pdfBytes = adapter.exportResults(session, themeStats, questions);
        assertThat(pdfBytes).isNotEmpty();
    }

    @Test
    @DisplayName("Should handle null questions list correctly")
    public void exportResults_nullQuestionsList_success() {
        questions = null;
        byte[] pdfBytes = adapter.exportResults(session, themeStats, questions);
        assertThat(pdfBytes).isNotEmpty();
    }
}
```
