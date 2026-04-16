```java
package com.certifapp.application.dto.community;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class StudyGroupDtoTest {

    @InjectMocks
    private StudyGroupDto studyGroupDto;

    @BeforeEach
    void setUp() {
        UUID id = UUID.randomUUID();
        String name = "Java Study Group";
        String certificationId = "cert123";
        int memberCount = 5;
        int maxMembers = 10;
        boolean isPublic = true;
        String inviteCode = null;

        studyGroupDto = new StudyGroupDto(id, name, certificationId, memberCount, maxMembers, isPublic, inviteCode);
    }

    @Test
    @DisplayName("Should return group id")
    void getId_groupCreated_returnsGroupId() {
        assertThat(studyGroupDto.id()).isNotNull();
    }

    @Test
    @DisplayName("Should return group name")
    void getName_groupCreated_returnsGroupName() {
        assertThat(studyGroupDto.name()).isEqualTo("Java Study Group");
    }

    @Test
    @DisplayName("Should return certification id")
    void getCertificationId_groupCreated_returnsCertificationId() {
        assertThat(studyGroupDto.certificationId()).isEqualTo("cert123");
    }

    @Test
    @DisplayName("Should return member count")
    void getMemberCount_groupCreated_returnsMemberCount() {
        assertThat(studyGroupDto.memberCount()).isEqualTo(5);
    }

    @Test
    @DisplayName("Should return max members")
    void getMaxMembers_groupCreated_returnsMaxMembers() {
        assertThat(studyGroupDto.maxMembers()).isEqualTo(10);
    }

    @Test
    @DisplayName("Should return public status")
    void getIsPublic_groupCreated_returnsIsPublic() {
        assertThat(studyGroupDto.isPublic()).isTrue();
    }

    @Test
    @DisplayName("Should return invite code for public group")
    void getInviteCode_publicGroup_returnsNull() {
        assertThat(studyGroupDto.inviteCode()).isNull();
    }
}
```
