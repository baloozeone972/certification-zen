// certif-application/src/test/java/com/certifapp/application/dto/payment/ImportResultDtoTest.java
package com.certifapp.application.dto.payment;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("ImportResultDtoTest")
class ImportResultDtoTest {

    private final ImportResultDto dto = new ImportResultDto(100,5,java.util.List.of());

    @Test @DisplayName("importedCount() returns expected")
    void importedCount_expected() { assertThat(dto.importedCount()).isEqualTo(100); }
    @Test @DisplayName("failedCount() returns expected")
    void failedCount_expected() { assertThat(dto.failedCount()).isEqualTo(5); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new ImportResultDto(100,5,java.util.List.of())); }
}
