// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/session/ExportSessionPdfUseCase.java
package com.certifapp.domain.port.input.session;

import java.util.UUID;

/**
 * Use case: export a completed exam session results as a PDF byte array.
 */
public interface ExportSessionPdfUseCase {
    /**
     * @param sessionId session to export
     * @param userId    requesting user (ownership check)
     * @return PDF content as byte array
     * @throws com.certifapp.domain.exception.SubscriptionRequiredException for FREE users
     * @throws com.certifapp.domain.exception.ExamSessionNotFoundException  if not found
     */
    byte[] execute(UUID sessionId, UUID userId);
}
