package com.certifapp.domain.port.output;

import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.ThemeStats;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class PdfExportPortTest {

    @Test
    @DisplayName("Generates PDF for nominal case")
    public void exportResults_nominalCase_success() {
        // Arrange
        ExamSession examSession = new ExamSession();
        List<ThemeStats> themeStatsList = new ArrayList<>();
        List<Question> questionList = new ArrayList<>();

        // Act
        byte[] pdfContent = PdfExportPort.exportResults(examSession, themeStatsList, questionList);

        // Assert
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for empty question list")
    public void exportResults_emptyQuestionList_success() {
        // Arrange
        ExamSession examSession = new ExamSession();
        List<ThemeStats> themeStatsList = new ArrayList<>();
        List<Question> emptyQuestionList = new ArrayList<>();

        // Act
        byte[] pdfContent = PdfExportPort.exportResults(examSession, themeStatsList, emptyQuestionList);

        // Assert
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for null session")
    public void exportResults_nullSession_success() {
        // Arrange
        ExamSession nullSession = null;
        List<ThemeStats> themeStatsList = new ArrayList<>();
        List<Question> questionList = new ArrayList<>();

        // Act
        byte[] pdfContent = PdfExportPort.exportResults(nullSession, themeStatsList, questionList);

        // Assert
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for null theme stats list")
    public void exportResults_nullThemeStatsList_success() {
        // Arrange
        ExamSession examSession = new ExamSession();
        List<ThemeStats> nullThemeStatsList = null;
        List<Question> questionList = new ArrayList<>();

        // Act
        byte[] pdfContent = PdfExportPort.exportResults(examSession, nullThemeStatsList, questionList);

        // Assert
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for null questions list")
    public void exportResults_nullQuestionsList_success() {
        // Arrange
        ExamSession examSession = new ExamSession();
        List<ThemeStats> themeStatsList = new ArrayList<>();
        List<Question> nullQuestionsList = null;

        // Act
        byte[] pdfContent = PdfExportPort.exportResults(examSession, themeStatsList, nullQuestionsList);

        // Assert
        Assertions.assertThat(pdfContent).isNotNull();
    }

    @Test
    @DisplayName("Generates PDF for edge case with single question")
    public void exportResults_singleQuestion_success() {
        // Arrange
        ExamSession examSession = new ExamSession();
        List<ThemeStats> themeStatsList = new ArrayList<>();
        List<Question> singleQuestionList = new ArrayList<>();
        singleQuestionList.add(new Question());

        // Act
        byte[] pdfContent = PdfExportPort.exportResults(examSession, themeStatsList, singleQuestionList);

        // Assert
        Assertions.assertThat(pdfContent).isNotNull();
    }
}