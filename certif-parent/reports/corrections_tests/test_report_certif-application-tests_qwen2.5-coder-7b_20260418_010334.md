# 🧪 Rapport de Correction de TESTS
**Backend**: lm_studio | **Modèle**: qwen2.5-coder-7b
**Branche**: `feature/certif-ios` | **Dry-run**: NON
**Fichiers**: 44 | **Corrections**: 28 | **Durée**: 2204s

### `certif-application/src/test/java/com/certifapp/application/dto/certification/CertificationSummaryDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/certification/CertificationSummaryDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/certification/CertificationSummaryDtoTest.java
@@ -3,16 +3,24 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.mockito.InjectMocks;

+import org.mockito.Mock;

+import org.mockito.MockitoAnnotations;

 

 import static org.assertj.core.api.Assertions.assertThat;

 

-@ExtendWith(MockitoExtension.class)

+@DisplayName("CertificationSummaryDto Tests")

 public class CertificationSummaryDtoTest {

+

+    @Mock

+    private CertificationService certificationService;

+

+    @InjectMocks

+    private CertificationSummaryDto certificationSummaryDto;

 

     @BeforeEach

     public void setUp() {

-        // Setup code if needed

+        MockitoAnnotations.openMocks(this);

     }

 

     @DisplayName("Create a valid CertificationSummaryDto with nominal case")

@@ -26,15 +34,15 @@
         int examDurationMin = 90;

         String examType = "MCQ";

 

-        CertificationSummaryDto certificationSummaryDto = new CertificationSummaryDto(id, code, name, totalQuestions, passingScore, examDurationMin, examType);

+        CertificationSummaryDto dto = new CertificationSummaryDto(id, code, name, totalQuestions, passingScore, examDurationMin, examType);


```

### `certif-application/src/test/java/com/certifapp/application/dto/coaching/DiagnosticResultDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/coaching/DiagnosticResultDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/coaching/DiagnosticResultDtoTest.java
@@ -4,12 +4,20 @@
 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

 import org.junit.jupiter.api.extension.ExtendWith;

+import org.mockito.InjectMocks;

+import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

 

 import static org.assertj.core.api.Assertions.assertThat;

 

 @ExtendWith(MockitoExtension.class)

 public class DiagnosticResultDtoTest {

+

+    @Mock

+    private SomeService someService; // Mock any dependencies if needed

+

+    @InjectMocks

+    private DiagnosticResultDto diagnosticResultDto;

 

     @BeforeEach

     public void setUp() {

@@ -23,11 +31,11 @@
         Map<String, Double> skillMap = Map.of("skill1", 0.9);

         List<RecommendedCertificationDto> recommendedCertifications = List.of(new RecommendedCertificationDto("cert1", "Rationale1", 1));

 

-        DiagnosticResultDto diagnosticResultDto = new DiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

+        DiagnosticResultDto result = diagnosticResultDto.createDiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

 

-        assertThat(diagnosticResultDto.scoreByDomain()).isEqualTo(Map.of("domain1", 85));

-        assertThat(diagnosticResultDto.skillMap()).isEqualTo(Map.of("s
```

### `certif-application/src/test/java/com/certifapp/application/dto/coaching/JobMarketDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/coaching/JobMarketDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/coaching/JobMarketDtoTest.java
@@ -4,10 +4,8 @@
 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

 import org.mockito.InjectMocks;

-import org.mockito.junit.jupiter.MockitoExtension;

 

 import static org.assertj.core.api.Assertions.assertThat;

-import static org.mockito.Mockito.verifyNoInteractions;

 

 @ExtendWith(MockitoExtension.class)

 public class JobMarketDtoTest {

@@ -82,5 +80,4 @@
     public void noInteractionsWithMocks() {

         verifyNoInteractions(jobMarketDto);

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/coaching/WeeklyCoachReportDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/coaching/WeeklyCoachReportDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/coaching/WeeklyCoachReportDtoTest.java
@@ -5,6 +5,7 @@
 import org.junit.jupiter.api.Test;

 import org.junit.jupiter.api.extension.ExtendWith;

 import org.mockito.InjectMocks;

+import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

 

 import java.time.LocalDate;

@@ -13,12 +14,16 @@
 import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

+import static org.mockito.Mockito.lenient;

 

 @ExtendWith(MockitoExtension.class)

 public class WeeklyCoachReportDtoTest {

 

     @InjectMocks

     private WeeklyCoachReportDto weeklyCoachReportDto;

+

+    @Mock

+    private WeeklyCoachService weeklyCoachService;

 

     @BeforeEach

     public void setUp() {

@@ -34,19 +39,24 @@
     @Test

     @DisplayName("Should return correct report ID")

     public void getReportId_stateUnderTest_expectedBehavior() {

-        assertThat(weeklyCoachReportDto.reportId()).isEqualTo(UUID.randomUUID());

+        UUID expectedReportId = UUID.randomUUID();

+        lenient().when(weeklyCoachService.getReportId()).thenReturn(expectedReportId);

+        assertThat(weeklyCoachReportDto.reportId()).isEqualTo(expectedReportId);

     }

 

     @Test

     @DisplayName("Should return correct user ID")

     public void getUserId_stateUnderTest_expectedBehavior() {

```

### `certif-application/src/test/java/com/certifapp/application/dto/community/LeaderboardEntryDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/community/LeaderboardEntryDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/community/LeaderboardEntryDtoTest.java
@@ -6,6 +6,7 @@
 import org.mockito.MockitoAnnotations;

 

 import static org.assertj.core.api.Assertions.assertThat;

+import static org.junit.jupiter.api.Assertions.assertThrows;

 

 @ExtendWith(MockitoExtension.class)

 public class LeaderboardEntryDtoTest {

@@ -118,5 +119,4 @@
 

         assertThat(exception.getMessage()).isEqualTo("userId must not be null");

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/community/WeeklyChallengeDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/community/WeeklyChallengeDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/community/WeeklyChallengeDtoTest.java
@@ -35,49 +35,48 @@
     @Test

     @DisplayName("Should return the correct challenge ID")

     public void getId_challengeExists_expectedId() {

-        assertThat(weeklyChallengeDto.id()).isEqualTo(weeklyChallengeDto.getId());

+        assertThat(weeklyChallengeDto.getId()).isEqualTo(weeklyChallengeDto.id());

     }

 

     @Test

     @DisplayName("Should return the correct challenge title")

     public void getTitle_challengeExists_expectedTitle() {

-        assertThat(weeklyChallengeDto.title()).isEqualTo(weeklyChallengeDto.getTitle());

+        assertThat(weeklyChallengeDto.getTitle()).isEqualTo(weeklyChallengeDto.title());

     }

 

     @Test

     @DisplayName("Should return the correct certification ID")

     public void getCertificationId_challengeExists_expectedCertificationId() {

-        assertThat(weeklyChallengeDto.certificationId()).isEqualTo(weeklyChallengeDto.getCertificationId());

+        assertThat(weeklyChallengeDto.getCertificationId()).isEqualTo(weeklyChallengeDto.certificationId());

     }

 

     @Test

     @DisplayName("Should return the correct theme code")

     public void getThemeCode_challengeExists_expectedThemeCode() {

-        assertThat(weeklyChallengeDto.themeCode()).isEqualTo(weeklyChallengeDto.getThemeCode())
```

### `certif-application/src/test/java/com/certifapp/application/dto/exam/ExamResultDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/exam/ExamResultDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/exam/ExamResultDtoTest.java
@@ -13,6 +13,7 @@
 import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

+import static org.assertj.core.api.Assertions.assertThatThrownBy;

 

 @ExtendWith(MockitoExtension.class)

 public class ExamResultDtoTest {

@@ -207,5 +208,4 @@
 

         assertThatThrownBy(() -> invalidExamResultDto.endedAt()).isInstanceOf(NullPointerException.class);

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/exam/QuestionDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/exam/QuestionDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/exam/QuestionDtoTest.java
@@ -11,6 +11,7 @@
 import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

+import static org.mockito.Mockito.*;

 

 @ExtendWith(MockitoExtension.class)

 public class QuestionDtoTest {

@@ -125,5 +126,4 @@
         assertThatThrownBy(() -> new QuestionDto(id, statement, options, themeCode, difficulty))

                 .isInstanceOf(NullPointerException.class);

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/exam/QuestionResultDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/exam/QuestionResultDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/exam/QuestionResultDtoTest.java
@@ -5,6 +5,8 @@
 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

 import org.junit.jupiter.api.extension.ExtendWith;

+import org.mockito.InjectMocks;

+import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

 

 @ExtendWith(MockitoExtension.class)

@@ -120,5 +122,4 @@
             );

         }).isInstanceOf(IllegalArgumentException.class).hasMessage("Invalid option ID: " + correctOptionId);

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/exam/UserAnswerDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/exam/UserAnswerDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/exam/UserAnswerDtoTest.java
@@ -31,9 +31,18 @@
     @Test

     @DisplayName("Should create UserAnswerDto with selected option")

     public void testCreateUserAnswerDtoWithSelectedOption() {

-        userAnswerDto = new UserAnswerDto(mockQuestionId, mockSelectedOptionId, true, false);

-        assertThat(userAnswerDto.questionId()).isEqualTo(mockQuestionId);

-        assertThat(userAnswerDto.selectedOptionId()).isEqualTo(mockSelectedOptionId);

+        // Arrange

+        UUID questionId = mockQuestionId;

+        UUID selectedOptionId = mockSelectedOptionId;

+        boolean isCorrect = true;

+        boolean isSkipped = false;

+

+        // Act

+        userAnswerDto = new UserAnswerDto(questionId, selectedOptionId, isCorrect, isSkipped);

+

+        // Assert

+        assertThat(userAnswerDto.questionId()).isEqualTo(questionId);

+        assertThat(userAnswerDto.selectedOptionId()).isEqualTo(selectedOptionId);

         assertThat(userAnswerDto.isCorrect()).isTrue();

         assertThat(userAnswerDto.isSkipped()).isFalse();

     }

@@ -41,8 +50,17 @@
     @Test

     @DisplayName("Should create UserAnswerDto with no selected option")

     public void testCreateUserAnswerDtoWithNoSelectedOption() {

-        userAnswerDto = new UserAnswerDto(mockQuestionId, null, false, true);

-        asser
```

### `certif-application/src/test/java/com/certifapp/application/dto/interview/InterviewSessionDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/interview/InterviewSessionDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/interview/InterviewSessionDtoTest.java
@@ -9,6 +9,7 @@
 import org.mockito.junit.jupiter.MockitoExtension;

 

 import static org.assertj.core.api.Assertions.assertThat;

+import static org.mockito.Mockito.*;

 

 @ExtendWith(MockitoExtension.class)

 public class InterviewSessionDtoTest {

@@ -22,11 +23,6 @@
     @BeforeEach

     public void setUp() {

         // Setup any necessary mocks or initializations here

-    }

-

-    @AfterEach

-    public void tearDown() {

-        // Cleanup any resources if needed

     }

 

     @Test

@@ -108,5 +104,4 @@
 

         assertThat(sessionDto.toString()).isNotNull();

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/learning/AdaptivePlanDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/learning/AdaptivePlanDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/learning/AdaptivePlanDtoTest.java
@@ -10,8 +10,10 @@
 import java.time.LocalDate;

 import java.util.Collections;

 import java.util.List;

+import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

+import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

 

 @ExtendWith(MockitoExtension.class)

 public class AdaptivePlanDtoTest {

@@ -142,5 +144,4 @@
                 ))

                 .withMessage("predictedScore must be between 0 and 100");

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/learning/CourseSummaryDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/learning/CourseSummaryDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/learning/CourseSummaryDtoTest.java
@@ -31,7 +31,16 @@
     @Test

     @DisplayName("Should create a valid CourseSummaryDto with all parameters")

     public void shouldCreateValidCourseSummaryDto() {

+        // Arrange

+        UUID id = UUID.randomUUID();

+        String themeCode = "THEME123";

+        String title = "Course Title";

+        String aiStatus = "ACTIVE";

+

+        // Act

         CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, title, aiStatus);

+

+        // Assert

         assertThat(dto.id()).isEqualTo(id);

         assertThat(dto.themeCode()).isEqualTo(themeCode);

         assertThat(dto.title()).isEqualTo(title);

@@ -41,29 +50,64 @@
     @Test

     @DisplayName("Should handle null id")

     public void shouldHandleNullId() {

-        CourseSummaryDto dto = new CourseSummaryDto(null, themeCode, title, aiStatus);

+        // Arrange

+        UUID id = null;

+        String themeCode = "THEME123";

+        String title = "Course Title";

+        String aiStatus = "ACTIVE";

+

+        // Act

+        CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, title, aiStatus);

+

+        // Assert

         assertThat(dto.id()).isNull();

     }

 

     @Test

     @DisplayName("Should handle empty themeCode")

     public void shouldHandleEmptyThe
```

### `certif-application/src/test/java/com/certifapp/application/dto/learning/SM2ProgressDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/learning/SM2ProgressDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/learning/SM2ProgressDtoTest.java
@@ -7,6 +7,7 @@
 import org.mockito.MockitoAnnotations;

 

 import static org.assertj.core.api.Assertions.assertThat;

+import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

 

 public class SM2ProgressDtoTest {

 

@@ -87,4 +88,4 @@
         assertThatExceptionOfType(IllegalArgumentException.class)

                 .isThrownBy(() -> new SM2ProgressDto(flashcardId, nextReviewDate, intervalDays, easeFactor, repetitions));

     }

-}

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/payment/ImportResultDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/payment/ImportResultDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/payment/ImportResultDtoTest.java
@@ -3,13 +3,10 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

 import org.mockito.InjectMocks;

-import org.mockito.junit.jupiter.MockitoExtension;

 

 import static org.assertj.core.api.Assertions.assertThat;

 

-@ExtendWith(MockitoExtension.class)

 public class ImportResultDtoTest {

 

     @InjectMocks

@@ -65,5 +62,4 @@
         assertThat(importResultDto.errors().get(0)).isEqualTo("Error1");

         assertThat(importResultDto.errors().get(1)).isEqualTo("Error2");

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/session/UserProgressDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/session/UserProgressDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/session/UserProgressDtoTest.java
@@ -8,7 +8,11 @@
 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

 

+import java.util.Map;

+import java.util.UUID;

+

 import static org.assertj.core.api.Assertions.assertThat;

+import static org.junit.jupiter.api.Assertions.assertThrows;

 

 @ExtendWith(MockitoExtension.class)

 public class UserProgressDtoTest {

@@ -108,5 +112,4 @@
         assertThat(exception.getMessage()).isEqualTo("progressByTheme is marked non-null but is null");

     }

 

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/user/TokenPairDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/user/TokenPairDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/user/TokenPairDtoTest.java
@@ -3,16 +3,25 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.mockito.InjectMocks;

+import org.mockito.Mock;

+import org.mockito.MockitoAnnotations;

 

 import static org.assertj.core.api.Assertions.assertThat;

+import static org.junit.jupiter.api.Assertions.assertThrows;

+import static org.mockito.Mockito.verifyNoInteractions;

 

-@ExtendWith(MockitoExtension.class)

 public class TokenPairDtoTest {

+

+    @Mock

+    private TokenService mockTokenService;

+

+    @InjectMocks

+    private TokenPairDto tokenPairDto;

 

     @BeforeEach

     public void setUp() {

-        // No setup required for this test case as no mocks or dependencies are used

+        MockitoAnnotations.openMocks(this);

     }

 

     @DisplayName("Test nominal case of TokenPairDto creation")

@@ -71,5 +80,4 @@
         // No mocks to interact with in this test case

         verifyNoInteractions(mockTokenService);

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/dto/user/UserPreferencesDtoTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/dto/user/UserPreferencesDtoTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/dto/user/UserPreferencesDtoTest.java
@@ -4,7 +4,6 @@
 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

 import org.mockito.InjectMocks;

-import org.mockito.junit.jupiter.MockitoExtension;

 

 import static org.assertj.core.api.Assertions.assertThat;

 

@@ -68,5 +67,4 @@
     public void getFreeModeDurationMin_stateUnderTest_expectedBehavior() {

         assertThat(userPreferencesDto.freeModeDurationMin()).isEqualTo(60);

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/usecase/certification/GetCertificationDetailsUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/certification/GetCertificationDetailsUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/certification/GetCertificationDetailsUseCaseImplTest.java
@@ -34,10 +34,13 @@
     @Test

     @DisplayName("execute_nominal_case_should_return_certification")

     public void execute_nominal_case_should_return_certification() {

+        // Arrange

         when(certificationRepository.findById(anyString())).thenReturn(java.util.Optional.of(certification));

 

+        // Act

         Certification result = getCertificationDetailsUseCase.execute("ocp21");

 

+        // Assert

         assertThat(result).isEqualTo(certification);

         verify(certificationRepository, times(1)).findById("ocp21");

     }

@@ -45,8 +48,10 @@
     @Test

     @DisplayName("execute_edge_case_empty_certificationId_should_throw_exception")

     public void execute_edge_case_empty_certificationId_should_throw_exception() {

+        // Arrange

         when(certificationRepository.findById(anyString())).thenReturn(java.util.Optional.empty());

 

+        // Act & Assert

         assertThatThrownBy(() -> getCertificationDetailsUseCase.execute(""))

                 .isInstanceOf(CertificationNotFoundException.class)

                 .hasMessage("ocp21");

@@ -55,11 +60,12 @@
     @Test

     @DisplayName("execute_error_case_null_certificationId_should_throw_exception")

     public v
```

### `certif-application/src/test/java/com/certifapp/application/usecase/certification/ListCertificationsUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/certification/ListCertificationsUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/certification/ListCertificationsUseCaseImplTest.java
@@ -26,11 +26,6 @@
     @BeforeEach

     public void setUp() {

         // Additional setup if needed

-    }

-

-    @AfterEach

-    public void tearDown() {

-        // Additional teardown if needed

     }

 

     @Test

@@ -94,5 +89,4 @@
         assertThat(result).isEmpty();

         verify(certificationRepository, times(1)).findAll(activeOnly);

     }

-}

-

+}
```

### `certif-application/src/test/java/com/certifapp/application/usecase/exam/GetExamResultsUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/exam/GetExamResultsUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/exam/GetExamResultsUseCaseImplTest.java
@@ -38,10 +38,13 @@
     @Test

     @DisplayName("execute_nominal_case")

     public void execute_nominal_case() {

+        // Arrange

         when(sessionRepository.findById(eq(sessionId))).thenReturn(Optional.of(examSession));

 

+        // Act

         ExamSession result = getExamResultsUseCase.execute(sessionId, userId);

 

+        // Assert

         assertThat(result).isEqualTo(examSession);

         verify(sessionRepository, times(1)).findById(eq(sessionId));

     }

@@ -49,8 +52,10 @@
     @Test

     @DisplayName("execute_edge_case_no_session")

     public void execute_edge_case_no_session() {

+        // Arrange

         when(sessionRepository.findById(eq(sessionId))).thenReturn(Optional.empty());

 

+        // Act & Assert

         ExamSessionNotFoundException exception = assertThrows(ExamSessionNotFoundException.class,

                 () -> getExamResultsUseCase.execute(sessionId, userId));

 

@@ -61,13 +66,14 @@
     @Test

     @DisplayName("execute_error_case_user_id_mismatch")

     public void execute_error_case_user_id_mismatch() {

+        // Arrange

         when(sessionRepository.findById(eq(sessionId))).thenReturn(Optional.of(examSession));

 

+        // Act & Assert

         ExamSessionNotFoundException ex
```

### `certif-application/src/test/java/com/certifapp/application/usecase/exam/StartExamSessionUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/exam/StartExamSessionUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/exam/StartExamSessionUseCaseImplTest.java
@@ -1,4 +1,3 @@
-// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/exam/StartExamSessionUseCaseImplTest.java

 package com.certifapp.application.usecase.exam;

 

 import com.certifapp.domain.exception.CertificationNotFoundException;

@@ -188,4 +187,4 @@
         assertThatThrownBy(() -> useCase.execute(cmd))

                 .isInstanceOf(CertificationNotFoundException.class);

     }

-}

+}
```

### `certif-application/src/test/java/com/certifapp/application/usecase/exam/SubmitExamUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/exam/SubmitExamUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/exam/SubmitExamUseCaseImplTest.java
@@ -25,6 +25,7 @@
 import java.util.Arrays;

 import java.util.Collections;

 import java.util.List;

+import java.util.Optional;

 import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

@@ -82,8 +83,9 @@
     }

 

     @Test

-    @DisplayName("nominal case: exam session completed successfully")

+    @DisplayName("submitExam_success")

     public void submitExam_success() {

+        // Arrange

         when(sessionRepository.findById(sessionId))

                 .thenReturn(Optional.of(session));

         when(answerRepository.findBySessionId(sessionId))

@@ -95,8 +97,10 @@
         when(scoringService.score(any(), any(), anyDouble(), anyInt()))

                 .thenReturn(new ScoringService.ScoringResult(2, 85.0, true));

 

+        // Act

         ExamSession completed = submitExamUseCase.execute(sessionId, userId);

 

+        // Assert

         assertThat(completed.status()).isEqualTo(SessionStatus.COMPLETED);

         assertThat(completed.percentage()).isEqualTo(85.0);

         assertThat(completed.passed()).isTrue();

@@ -104,18 +108,21 @@
     }

 

     @Test

-    @DisplayName("edge case: exam session not found")

+    @DisplayName("submitExam_examSessionNotFound")

     public void submitExam_examSessionN
```

### `certif-application/src/test/java/com/certifapp/application/usecase/learning/GetFlashcardsUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/learning/GetFlashcardsUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/learning/GetFlashcardsUseCaseImplTest.java
@@ -52,12 +52,15 @@
     @Test

     @DisplayName("should return flashcards when user has PRO tier")

     public void execute_PRO_user_success() {

+        // Arrange

         when(userRepository.findById(userId)).thenReturn(Optional.of(mockUser(SubscriptionTier.PRO)));

         List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard());

         when(flashcardRepository.findDueByUserAndCertification(any(), any(), anyInt())).thenReturn(expectedFlashcards);

 

+        // Act

         List<Flashcard> result = getFlashcardsUseCase.execute(userId, certificationId, limit);

 

+        // Assert

         assertThat(result).isEqualTo(expectedFlashcards);

         verify(userRepository).findById(userId);

         verify(freemiumGuardService).requireUnlimited(SubscriptionTier.PRO, "Flashcards & Spaced Repetition");

@@ -67,8 +70,10 @@
     @Test

     @DisplayName("should throw SubscriptionRequiredException when user has FREE tier")

     public void execute_FREE_user_failure() {

+        // Arrange

         when(userRepository.findById(userId)).thenReturn(Optional.of(mockUser(SubscriptionTier.FREE)));

 

+        // Act & Assert

         assertThatThrownBy(() -> getFlashcardsUseCase.execute(userId, certificationId, limit))

       
```

### `certif-application/src/test/java/com/certifapp/application/usecase/learning/ReviewFlashcardUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/learning/ReviewFlashcardUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/learning/ReviewFlashcardUseCaseImplTest.java
@@ -1,4 +1,3 @@
-// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/learning/ReviewFlashcardUseCaseImplTest.java

 package com.certifapp.application.usecase.learning;

 

 import com.certifapp.domain.model.learning.SM2Schedule;

@@ -22,9 +21,6 @@
 import static org.mockito.Mockito.verify;

 import static org.mockito.Mockito.when;

 

-/**

- * Unit tests for {@link ReviewFlashcardUseCaseImpl}.

- */

 @ExtendWith(MockitoExtension.class)

 @DisplayName("ReviewFlashcardUseCaseImpl")

 class ReviewFlashcardUseCaseImplTest {

@@ -34,6 +30,8 @@
     @Mock

     private SM2ScheduleRepository sm2Repository;

     private SM2AlgorithmService sm2Service;

+    @Mock

+    private ReviewFlashcardUseCase.OutputPort outputPort;

     private ReviewFlashcardUseCaseImpl useCase;

 

     @BeforeEach

@@ -86,4 +84,4 @@
                 .isInstanceOf(IllegalArgumentException.class)

                 .hasMessageContaining("SM-2 rating must be 0-5");

     }

-}

+}
```

### `certif-application/src/test/java/com/certifapp/application/usecase/user/AuthenticateUserUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/user/AuthenticateUserUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/user/AuthenticateUserUseCaseImplTest.java
@@ -1,4 +1,3 @@
-// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/user/AuthenticateUserUseCaseImplTest.java

 package com.certifapp.application.usecase.user;

 

 import com.certifapp.domain.exception.InvalidCredentialsException;

@@ -10,6 +9,7 @@
 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

 import org.junit.jupiter.api.extension.ExtendWith;

+import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

 

@@ -21,15 +21,14 @@
 import static org.assertj.core.api.Assertions.assertThatThrownBy;

 import static org.mockito.Mockito.when;

 

-/**

- * Unit tests for {@link AuthenticateUserUseCaseImpl}.

- */

 @ExtendWith(MockitoExtension.class)

 @DisplayName("AuthenticateUserUseCaseImpl")

 class AuthenticateUserUseCaseImplTest {

 

     @Mock

     private UserRepository userRepository;

+

+    @InjectMocks

     private AuthenticateUserUseCaseImpl useCase;

 

     @BeforeEach

@@ -42,24 +41,29 @@
     @Test

     @DisplayName("Valid credentials — returns authenticated user")

     void validCredentials_shouldReturnUser() {

+        // Arrange

         User user = new User(UUID.randomUUID(), "user@example.com", "hashed_Passwo
```

### `certif-application/src/test/java/com/certifapp/application/usecase/user/RegisterUserUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/user/RegisterUserUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/user/RegisterUserUseCaseImplTest.java
@@ -1,4 +1,3 @@
-// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/user/RegisterUserUseCaseImplTest.java

 package com.certifapp.application.usecase.user;

 

 import com.certifapp.domain.exception.DuplicateEmailException;

@@ -25,9 +24,6 @@
 import static org.mockito.Mockito.verify;

 import static org.mockito.Mockito.when;

 

-/**

- * Unit tests for {@link RegisterUserUseCaseImpl}.

- */

 @ExtendWith(MockitoExtension.class)

 @DisplayName("RegisterUserUseCaseImpl")

 class RegisterUserUseCaseImplTest {

@@ -113,4 +109,4 @@
                 .isInstanceOf(IllegalArgumentException.class)

                 .hasMessageContaining("at least 8 characters");

     }

-}

+}
```

### `certif-application/src/test/java/com/certifapp/application/usecase/user/UpdateUserPreferencesUseCaseImplTest.java`
```diff
--- a/certif-application/src/test/java/com/certifapp/application/usecase/user/UpdateUserPreferencesUseCaseImplTest.java
+++ b/certif-application/src/test/java/com/certifapp/application/usecase/user/UpdateUserPreferencesUseCaseImplTest.java
@@ -14,7 +14,10 @@
 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

 

+import static org.assertj.core.api.Assertions.assertThat;

+import static org.assertj.core.api.Assertions.assertThatThrownBy;

 import static org.mockito.Mockito.any;

+import static org.mockito.Mockito.lenient;

 import static org.mockito.Mockito.when;

 

 @ExtendWith(MockitoExtension.class)

@@ -85,5 +88,4 @@
                 .isInstanceOf(UserNotFoundException.class)

                 .hasMessage(userId.toString());

     }

-}

-

+}
```
