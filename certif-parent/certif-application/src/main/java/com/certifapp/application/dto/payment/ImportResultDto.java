// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/payment/ImportResultDto.java
package com.certifapp.application.dto.payment;

import java.util.List;

/**
 * Result of a bulk question import operation.
 *
 * @param imported number of questions successfully imported
 * @param skipped  number of questions skipped (duplicates by legacyId)
 * @param errors   list of error messages for invalid questions
 */
public record ImportResultDto(int imported, int skipped, List<String> errors) {
}
