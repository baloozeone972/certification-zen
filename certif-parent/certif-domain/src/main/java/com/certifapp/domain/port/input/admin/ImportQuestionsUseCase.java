// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/admin/ImportQuestionsUseCase.java
package com.certifapp.domain.port.input.admin;

import com.certifapp.domain.model.question.Question;
import java.util.List;
import java.util.UUID;

/**
 * Use case: bulk-import questions from a JSON payload (admin only).
 */
public interface ImportQuestionsUseCase {

    /** Result of a bulk import operation. */
    record ImportResult(int imported, int skipped, List<String> errors) {}

    /**
     * @param certificationId target certification
     * @param questions       questions to import
     * @param adminId         importing admin UUID (for audit trail)
     * @return summary of import outcome
     */
    ImportResult execute(String certificationId, List<Question> questions, UUID adminId);
}
