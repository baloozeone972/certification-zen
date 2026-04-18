// certif-application/src/test/java/com/certifapp/application/dto/community/StudyGroupDtoTest.java
package com.certifapp.application.dto.community;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("StudyGroupDtoTest")
class StudyGroupDtoTest {

    private final StudyGroupDto dto = new StudyGroupDto(java.util.UUID.randomUUID(),"Java Learners","ocp21",10,5);

    @Test @DisplayName("name() returns expected")
    void name_expected() { assertThat(dto.name()).isEqualTo("Java Learners"); }
    @Test @DisplayName("memberCount() returns expected")
    void memberCount_expected() { assertThat(dto.memberCount()).isEqualTo(10); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new StudyGroupDto(java.util.UUID.randomUUID(),"Java Learners","ocp21",10,5)); }
}
