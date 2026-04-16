package com.certifapp.domain.port.output;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.ThemeStats;
import com.certifapp.domain.model.question.Question;

import java.util.ArrayList;
import java.util.List;

@ExtendWith(MockitoExtension.class)
public class PdfExportPortTest {

    @Mock
    private ExamSession examSession;

    @Mock
    private List<ThemeStats> themeStatsList;

    @Mock
    private List<Question> questionList;

    @InjectMocks
    private PdfExportPort pdfExportPort;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @AfterEach
    public void tearDown() {
        // Teardown code if needed
    }

    @Test
    @DisplayName("Generates PDF for nominal case")
    public void exportResults_nominalCase_success() {
        byte[] pdfContent = pdfExportPort.exportResults(examSession, themeStatsList, questionList);
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for empty question list")
    public void exportResults_emptyQuestionList_success() {
        List<Question> emptyQuestionList = new ArrayList<>();
        byte[] pdfContent = pdfExportPort.exportResults(examSession, themeStatsList, emptyQuestionList);
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for null session")
    public void exportResults_nullSession_success() {
        ExamSession nullSession = null;
        byte[] pdfContent = pdfExportPort.exportResults(nullSession, themeStatsList, questionList);
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for null theme stats list")
    public void exportResults_nullThemeStatsList_success() {
        List<ThemeStats> nullThemeStatsList = null;
        byte[] pdfContent = pdfExportPort.exportResults(examSession, nullThemeStatsList, questionList);
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for null questions list")
    public void exportResults_nullQuestionsList_success() {
        List<Question> nullQuestionsList = null;
        byte[] pdfContent = pdfExportPort.exportResults(examSession, themeStatsList, nullQuestionsList);
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for edge case with single question")
    public void exportResults_singleQuestion_success() {
        List<Question> singleQuestionList = new ArrayList<>();
        singleQuestionList.add(new Question());
        byte[] pdfContent = pdfExportPort.exportResults(examSession, themeStatsList, singleQuestionList);
        Assertions.assertThat(pdfContent).isNotNull();
    }
}
```
