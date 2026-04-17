package com.certifapp.domain.model.learning;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class CourseTest {

    @Mock
    private UUID mockUUID;

    @InjectMocks
    private Course course;

    @BeforeEach
    public void setUp() {
        when(mockUUID.toString()).thenReturn("mock-uuid");
        OffsetDateTime fixedNow = OffsetDateTime.of(2023, 10, 1, 12, 0, 0, 0, ZoneOffset.UTC);

        course = new Course(
                mockUUID,
                "certification-id",
                UUID.randomUUID(),
                "title",
                "# content markdown",
                "<p>content html</p>",
                "DRAFT",
                1,
                fixedNow,   // createdAt
                fixedNow    // updatedAt
        );
    }

    @Test
    @DisplayName("isPublished_PUBLISHED_returnTrue")
    public void isPublished_PUBLISHED_returnTrue() {
        course = new Course(
                mockUUID,
                "certification-id",
                UUID.randomUUID(),
                "title",
                "# content markdown",
                "<p>content html</p>",
                "PUBLISHED",
                1,
                OffsetDateTime.now(),
                OffsetDateTime.now()
        );
        assertThat(course.isPublished()).isTrue();
    }

    @Test
    @DisplayName("isPublished_DRAFT_returnFalse")
    public void isPublished_DRAFT_returnFalse() {
        assertThat(course.isPublished()).isFalse();
    }

    @Test
    @DisplayName("constructor_validInputs_success")
    public void constructor_validInputs_success() {
        assertThat(course).isNotNull();
    }

    @Test
    @DisplayName("constructor_nullCertificationId_throwsIllegalArgumentException")
    public void constructor_nullCertificationId_throwsIllegalArgumentException() {
        assertThatThrownBy(() -> new Course(
                mockUUID,
                null,
                UUID.randomUUID(),
                "title",
                "# content markdown",
                "<p>content html</p>",
                "DRAFT",
                1,
                OffsetDateTime.now(),
                OffsetDateTime.now()
        )).isInstanceOf(IllegalArgumentException.class)
                .hasMessage("certificationId must not be blank");
    }

    @Test
    @DisplayName("constructor_blankCertificationId_throwsIllegalArgumentException")
    public void constructor_blankCertificationId_throwsIllegalArgumentException() {
        assertThatThrownBy(() -> new Course(
                mockUUID,
                "   ",
                UUID.randomUUID(),
                "title",
                "# content markdown",
                "<p>content html</p>",
                "DRAFT",
                1,
                OffsetDateTime.now(),
                OffsetDateTime.now()
        )).isInstanceOf(IllegalArgumentException.class)
                .hasMessage("certificationId must not be blank");
    }

    @Test
    @DisplayName("constructor_nullThemeId_throwsIllegalArgumentException")
    public void constructor_nullThemeId_throwsIllegalArgumentException() {
        assertThatThrownBy(() -> new Course(
                mockUUID,
                "certification-id",
                null,
                "title",
                "# content markdown",
                "<p>content html</p>",
                "DRAFT",
                1,
                OffsetDateTime.now(),
                OffsetDateTime.now()
        )).isInstanceOf(IllegalArgumentException.class)
                .hasMessage("themeId must not be null");
    }

    @Test
    @DisplayName("constructor_negativeVersion_throwsIllegalArgumentException")
    public void constructor_negativeVersion_throwsIllegalArgumentException() {
        assertThatThrownBy(() -> new Course(
                mockUUID,
                "certification-id",
                UUID.randomUUID(),
                "title",
                "# content markdown",
                "<p>content html</p>",
                "DRAFT",
                -1,
                OffsetDateTime.now(),
                OffsetDateTime.now()
        )).isInstanceOf(IllegalArgumentException.class)
                .hasMessage("version must not be less than 1");
    }

    @Test
    @DisplayName("constructor_zeroVersion_success")
    public void constructor_zeroVersion_success() {
        Course course = new Course(
                mockUUID,
                "certification-id",
                UUID.randomUUID(),
                "title",
                "# content markdown",
                "<p>content html</p>",
                "DRAFT",
                0,
                OffsetDateTime.now(),
                OffsetDateTime.now()
        );
        assertThat(course.version()).isEqualTo(1);
    }
}

