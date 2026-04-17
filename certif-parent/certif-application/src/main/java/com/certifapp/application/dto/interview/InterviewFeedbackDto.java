// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/interview/InterviewFeedbackDto.java
package com.certifapp.application.dto.interview;

/**
 * AI feedback on one interview answer.
 *
 * @param questionText the interview question that was asked
 * @param userAnswer   the user's submitted answer
 * @param aiFeedback   AI-generated detailed feedback
 * @param score        quality score 0-10
 * @param domain       technical domain of the question
 */
public record InterviewFeedbackDto(
        String questionText,
        String userAnswer,
        String aiFeedback,
        int score,
        String domain
) {
}
