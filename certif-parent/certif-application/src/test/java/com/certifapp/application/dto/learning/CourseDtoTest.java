package com.certifapp.application.dto.learning;

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
public class CourseDtoTest {

    @Mock
    private UUID uuid;

    @InjectMocks
    private CourseDto courseDto;

    @BeforeEach
    public void setUp() {
        when(uuid.toString()).thenReturn("test-uuid");
    }

    @Test
    @DisplayName("should create CourseDto with nominal values")
    public void shouldCreateCourseDtoWithNominalValues() {
        // Arrange
        String certificationId = "cert123";
        String themeCode = "theme456";
        String title = "Java Fundamentals";
        String contentMarkdown = "# Introduction to Java\nBasics of Java.";
        String contentHtml = "<h1>Introduction to Java</h1><p>Basics of Java.</p>";
        String aiStatus = "DRAFT";

        // Act
        CourseDto courseDtoInstance = new CourseDto(uuid, certificationId, themeCode, title, contentMarkdown, contentHtml, aiStatus);

        // Assert
        assertThat(courseDtoInstance.id()).isEqualTo("test-uuid");
        assertThat(courseDtoInstance.certificationId()).isEqualTo(certificationId);
        assertThat(courseDtoInstance.themeCode()).isEqualTo(themeCode);
        assertThat(courseDtoInstance.title()).isEqualTo(title);
        assertThat(courseDtoInstance.contentMarkdown()).isEqualTo(contentMarkdown);
        assertThat(courseDtoInstance.contentHtml()).isEqualTo(contentHtml);
        assertThat(courseDtoInstance.aiStatus()).isEqualTo(aiStatus);
    }

    @Test
    @DisplayName("should handle null values gracefully")
    public void shouldHandleNullValuesGracefully() {
        // Arrange
        String certificationId = "cert123";
        String themeCode = "theme456";
        String title = null;
        String contentMarkdown = null;
        String contentHtml = null;
        String aiStatus = "DRAFT";

        // Act
        CourseDto courseDtoInstance = new CourseDto(uuid, certificationId, themeCode, title, contentMarkdown, contentHtml, aiStatus);

        // Assert
        assertThat(courseDtoInstance.id()).isEqualTo("test-uuid");
        assertThat(courseDtoInstance.certificationId()).isEqualTo(certificationId);
        assertThat(courseDtoInstance.themeCode()).isEqualTo(themeCode);
        assertThat(courseDtoInstance.title()).isNull();
        assertThat(courseDtoInstance.contentMarkdown()).isNull();
        assertThat(courseDtoInstance.contentHtml()).isNull();
        assertThat(courseDtoInstance.aiStatus()).isEqualTo(aiStatus);
    }

    @Test
    @DisplayName("should throw NullPointerException when id is null")
    public void shouldThrowNullPointerExceptionWhenIdIsNull() {
        // Arrange
        String certificationId = "cert123";
        String themeCode = "theme456";
        String title = "Java Fundamentals";
        String contentMarkdown = "# Introduction to Java\nBasics of Java.";
        String contentHtml = "<h1>Introduction to Java</h1><p>Basics of Java.</p>";
        String aiStatus = "DRAFT";

        // Act & Assert
        NullPointerException exception = assertThrows(NullPointerException.class, () -> {
            new CourseDto(null, certificationId, themeCode, title, contentMarkdown, contentHtml, aiStatus);
        });

        assertThat(exception.getMessage()).contains("id");
    }
}
