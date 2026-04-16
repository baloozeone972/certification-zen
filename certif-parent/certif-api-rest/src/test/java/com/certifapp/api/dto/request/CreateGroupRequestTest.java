```java
package com.certifapp.api.dto.request;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

@ExtendWith(MockitoExtension.class)
public class CreateGroupRequestTest {

    @InjectMocks
    private CreateGroupRequest createGroupRequest;

    @Mock
    private void mockDependencies() {
        // No dependencies to mock for this record class
    }

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @AfterEach
    public void tearDown() {
        // Teardown code if needed
    }

    @Test
    @DisplayName("should create valid CreateGroupRequest with all parameters")
    public void shouldCreateValidCreateGroupRequestWithAllParameters() {
        CreateGroupRequest request = new CreateGroupRequest("Java Certification", "cert123", 50, true);
        Assertions.assertThat(request.name()).isEqualTo("Java Certification");
        Assertions.assertThat(request.certificationId()).isEqualTo("cert123");
        Assertions.assertThat(request.maxMembers()).isEqualTo(50);
        Assertions.assertThat(request.isPublic()).isTrue();
    }

    @Test
    @DisplayName("should not allow empty name")
    public void shouldNotAllowEmptyName() {
        Exception exception = Assertions.catchThrowable(() -> new CreateGroupRequest("", "cert123", 50, true));
        Assertions.assertThat(exception).isInstanceOf(ConstraintViolationException.class);
    }

    @Test
    @DisplayName("should not allow null certificationId")
    public void shouldNotAllowNullCertificationId() {
        Exception exception = Assertions.catchThrowable(() -> new CreateGroupRequest("Java Certification", null, 50, true));
        Assertions.assertThat(exception).isInstanceOf(ConstraintViolationException.class);
    }

    @Test
    @DisplayName("should not allow maxMembers less than 2")
    public void shouldNotAllowMaxMembersLessThan2() {
        Exception exception = Assertions.catchThrowable(() -> new CreateGroupRequest("Java Certification", "cert123", 1, true));
        Assertions.assertThat(exception).isInstanceOf(ConstraintViolationException.class);
    }

    @Test
    @DisplayName("should not allow maxMembers greater than 50")
    public void shouldNotAllowMaxMembersGreaterThan50() {
        Exception exception = Assertions.catchThrowable(() -> new CreateGroupRequest("Java Certification", "cert123", 51, true));
        Assertions.assertThat(exception).isInstanceOf(ConstraintViolationException.class);
    }
}
```
