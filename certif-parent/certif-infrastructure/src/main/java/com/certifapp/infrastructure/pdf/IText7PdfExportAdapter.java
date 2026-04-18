// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/pdf/IText7PdfExportAdapter.java
package com.certifapp.infrastructure.pdf;

import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.ThemeStats;
import com.certifapp.domain.port.output.PdfExportPort;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.AreaBreak;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * iText7 implementation of {@link PdfExportPort}.
 *
 * <p>Migrated and enhanced from the original {@code PdfExportService} in CertiPrep Engine.
 * Generates a 3-page PDF: summary, theme breakdown, and full question review.</p>
 */
@Component
public class IText7PdfExportAdapter implements PdfExportPort {

    private static final DateTimeFormatter DATE_FMT =
            DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    private static final DeviceRgb COLOR_GREEN = new DeviceRgb(34, 139, 34);
    private static final DeviceRgb COLOR_RED = new DeviceRgb(220, 20, 60);
    private static final DeviceRgb COLOR_HEADER = new DeviceRgb(52, 73, 94);

    @Override
    public byte[] exportResults(ExamSession session,
                                List<ThemeStats> themeStats,
                                List<Question> questions) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        try (PdfWriter writer = new PdfWriter(baos);
             PdfDocument pdfDoc = new PdfDocument(writer);
             Document document = new Document(pdfDoc, PageSize.A4)) {

            document.setMargins(40, 40, 40, 40);

            // ── Page 1 : Summary ──────────────────────────────────────────
            addTitle(document, "CertifApp — Rapport d'examen");
            addSummarySection(document, session);
            addThemeStatsTable(document, themeStats);

            // ── Page 2 : Wrong questions ──────────────────────────────────
            document.add(new AreaBreak());
            document.add(new Paragraph("Questions à réviser")
                    .setFontSize(14).setBold().setFontColor(COLOR_HEADER));
            document.add(new Paragraph(" "));
            addWrongQuestionsSection(document, session, questions);

        } catch (Exception e) {
            throw new RuntimeException("PDF generation failed: " + e.getMessage(), e);
        }

        return baos.toByteArray();
    }

    // ── Private helpers ────────────────────────────────────────────────────

    private void addTitle(Document doc, String title) {
        doc.add(new Paragraph(title)
                .setFontSize(20).setBold()
                .setTextAlignment(TextAlignment.CENTER)
                .setFontColor(COLOR_HEADER)
                .setMarginBottom(20));
    }

    private void addSummarySection(Document doc, ExamSession session) {
        doc.add(new Paragraph("Certification : " + session.certificationId())
                .setFontSize(12));
        if (session.startedAt() != null) {
            doc.add(new Paragraph("Date : " + session.startedAt().format(DATE_FMT))
                    .setFontSize(12));
        }
        doc.add(new Paragraph("Mode : " + session.mode().name()).setFontSize(12));
        if (session.durationSeconds() != null) {
            doc.add(new Paragraph("Durée : " + formatDuration(session.durationSeconds()))
                    .setFontSize(12));
        }
        doc.add(new Paragraph(" "));

        // Score highlight
        String scoreText = session.correctCount() + " / " + session.totalQuestions()
                + "  (" + String.format("%.1f%%", session.percentage()) + ")";
        doc.add(new Paragraph("Score : " + scoreText).setFontSize(16).setBold());

        String status = session.passed() ? "RÉUSSI ✓" : "ÉCHEC ✗";
        DeviceRgb statusColor = session.passed() ? COLOR_GREEN : COLOR_RED;
        doc.add(new Paragraph("Résultat : " + status)
                .setFontSize(16).setBold().setFontColor(statusColor)
                .setMarginBottom(20));
    }

    private void addThemeStatsTable(Document doc, List<ThemeStats> themeStats) {
        if (themeStats == null || themeStats.isEmpty()) return;

        doc.add(new Paragraph("Détail par thème").setFontSize(14).setBold()
                .setFontColor(COLOR_HEADER).setMarginBottom(8));

        Table table = new Table(UnitValue.createPercentArray(new float[]{40, 15, 15, 15, 15}))
                .useAllAvailableWidth();

        // Header
        for (String header : new String[]{"Thème", "Correct", "Faux", "Ignoré", "%"}) {
            table.addHeaderCell(new Cell().add(new Paragraph(header).setBold())
                    .setBackgroundColor(new DeviceRgb(52, 73, 94))
                    .setFontColor(ColorConstants.WHITE));
        }

        // Rows
        for (ThemeStats ts : themeStats) {
            table.addCell(ts.themeLabel());
            table.addCell(String.valueOf(ts.correct()));
            table.addCell(String.valueOf(ts.wrong()));
            table.addCell(String.valueOf(ts.skipped()));
            DeviceRgb pctColor = ts.percentage() >= 70 ? COLOR_GREEN : COLOR_RED;
            table.addCell(new Cell().add(
                    new Paragraph(String.format("%.0f%%", ts.percentage()))
                            .setFontColor(pctColor)));
        }

        doc.add(table);
    }

    private void addWrongQuestionsSection(Document doc, ExamSession session,
                                          List<Question> questions) {
        Map<UUID, com.certifapp.domain.model.session.UserAnswer> answerMap = new HashMap<>();
        for (var a : session.answers()) answerMap.put(a.questionId(), a);

        int idx = 1;
        for (Question q : questions) {
            var answer = answerMap.get(q.id());
            if (answer == null || answer.isCorrect() || answer.isSkipped()) continue;

            doc.add(new Paragraph(idx + ". " + q.statement())
                    .setBold().setFontSize(11).setMarginTop(12));

            // Correct option
            q.correctOption().ifPresent(opt ->
                    doc.add(new Paragraph("  ✓ Réponse correcte : " + opt.label() + ". " + opt.text())
                            .setFontColor(COLOR_GREEN).setMarginLeft(15)));

            // User's answer
            if (answer.selectedOptionId() != null) {
                q.findOption(answer.selectedOptionId()).ifPresent(opt ->
                        doc.add(new Paragraph("  ✗ Votre réponse : " + opt.label() + ". " + opt.text())
                                .setFontColor(COLOR_RED).setMarginLeft(15)));
            }

            // Explanation
            String explanation = q.bestExplanation();
            if (!explanation.isBlank()) {
                doc.add(new Paragraph("  💡 " + explanation)
                        .setFontSize(10)
                        .setFontColor(ColorConstants.DARK_GRAY)
                        .setMarginLeft(15));
            }
            idx++;
        }

        if (idx == 1) {
            doc.add(new Paragraph("🎉 Aucune erreur — toutes les questions ont été réussies !")
                    .setFontColor(COLOR_GREEN).setBold());
        }
    }

    private String formatDuration(int seconds) {
        long h = seconds / 3600;
        long m = (seconds % 3600) / 60;
        long s = seconds % 60;
        return String.format("%02d:%02d:%02d", h, m, s);
    }
}
