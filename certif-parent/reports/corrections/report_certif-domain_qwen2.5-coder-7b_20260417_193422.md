# 📋 Rapport certif-domain
**Backend**: lm_studio | **Modèle**: qwen2.5-coder-7b
**Branche**: `develop` | **Dry-run**: NON
**Fichiers**: 63 | **Corrections**: 14 | **Durée**: 440s

### `certif-domain/src/main/java/com/certifapp/domain/exception/CertifAppException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/CertifAppException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/CertifAppException.java
@@ -6,7 +6,7 @@
  * All domain exceptions must extend this class to allow unified handling

  * in the API layer via {@code GlobalExceptionHandler}.

  */

-public class CertifAppException extends RuntimeException {

+public record CertifAppException(String message, Throwable cause) {

 

     /** Error code for structured API error responses. */

     private final String errorCode;

@@ -17,10 +17,7 @@
      * @param message error description (exposed in API error response)

      */

     public CertifAppException(String message) {

-        super(message);

-        this.errorCode = this.getClass().getSimpleName()

-                .replace("Exception", "")

-                .toUpperCase();

+        this(message, null);

     }

 

     /**

```

### `certif-domain/src/main/java/com/certifapp/domain/exception/CertificationNotFoundException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/CertificationNotFoundException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/CertificationNotFoundException.java
@@ -4,16 +4,9 @@
 /**

  * Thrown when a certification with the given id does not exist.

  */

-public class CertificationNotFoundException extends CertifAppException {

+public record CertificationNotFoundException(String certificationId) extends CertifAppException {

 

-    private final String certificationId;

-

-    public CertificationNotFoundException(String certificationId) {

+    public CertificationNotFoundException {

         super("Certification not found: " + certificationId);

-        this.certificationId = certificationId;

     }

-

-    public String getCertificationId() {

-        return certificationId;

-    }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/exception/DuplicateEmailException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/DuplicateEmailException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/DuplicateEmailException.java
@@ -4,9 +4,8 @@
 /**

  * Thrown when attempting to register with an email already in use.

  */

-public class DuplicateEmailException extends CertifAppException {

-

-    public DuplicateEmailException(String email) {

+public record DuplicateEmailException(String email) extends CertifAppException {

+    public DuplicateEmailException {

         super("Email already registered: " + email);

     }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/exception/ExamAlreadyCompletedException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/ExamAlreadyCompletedException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/ExamAlreadyCompletedException.java
@@ -4,16 +4,9 @@
 /**

  * Thrown when trying to submit or answer a session that is already completed.

  */

-public class ExamAlreadyCompletedException extends CertifAppException {

+public record ExamAlreadyCompletedException(java.util.UUID sessionId) extends CertifAppException {

 

-    private final java.util.UUID sessionId;

-

-    public ExamAlreadyCompletedException(java.util.UUID sessionId) {

+    public ExamAlreadyCompletedException {

         super("Exam session already completed: " + sessionId);

-        this.sessionId = sessionId;

     }

-

-    public java.util.UUID getSessionId() {

-        return sessionId;

-    }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/exception/ExamSessionNotFoundException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/ExamSessionNotFoundException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/ExamSessionNotFoundException.java
@@ -4,16 +4,9 @@
 /**

  * Thrown when an exam session with the given UUID does not exist.

  */

-public class ExamSessionNotFoundException extends CertifAppException {

+public record ExamSessionNotFoundException(java.util.UUID sessionId) extends CertifAppException {

 

-    private final java.util.UUID sessionId;

-

-    public ExamSessionNotFoundException(java.util.UUID sessionId) {

+    public ExamSessionNotFoundException {

         super("Exam session not found: " + sessionId);

-        this.sessionId = sessionId;

     }

-

-    public java.util.UUID getSessionId() {

-        return sessionId;

-    }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/exception/FreemiumLimitExceededException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/FreemiumLimitExceededException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/FreemiumLimitExceededException.java
@@ -4,11 +4,7 @@
 /**

  * Thrown when a FREE-tier user exceeds their daily exam or question limit.

  */

-public class FreemiumLimitExceededException extends CertifAppException {

-

-    public FreemiumLimitExceededException(String message) {

-        super(message);

-    }

+public record FreemiumLimitExceededException(String message) extends CertifAppException {

 

     public static FreemiumLimitExceededException dailyExams() {

         return new FreemiumLimitExceededException(

@@ -19,4 +15,4 @@
         return new FreemiumLimitExceededException(

                 "FREE tier: maximum 20 questions per session");

     }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/exception/InvalidCredentialsException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/InvalidCredentialsException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/InvalidCredentialsException.java
@@ -4,9 +4,8 @@
 /**

  * Thrown when email/password authentication fails.

  */

-public class InvalidCredentialsException extends CertifAppException {

-

+public record InvalidCredentialsException(String message) extends CertifAppException {

     public InvalidCredentialsException() {

-        super("Invalid email or password");

+        this("Invalid email or password");

     }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/exception/QuestionNotFoundException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/QuestionNotFoundException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/QuestionNotFoundException.java
@@ -4,16 +4,9 @@
 /**

  * Thrown when a question with the given UUID does not exist.

  */

-public class QuestionNotFoundException extends CertifAppException {

+public record QuestionNotFoundException(java.util.UUID questionId) extends CertifAppException {

 

-    private final java.util.UUID questionId;

-

-    public QuestionNotFoundException(java.util.UUID questionId) {

+    public QuestionNotFoundException {

         super("Question not found: " + questionId);

-        this.questionId = questionId;

     }

-

-    public java.util.UUID getQuestionId() {

-        return questionId;

-    }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/exception/StudyGroupFullException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/StudyGroupFullException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/StudyGroupFullException.java
@@ -4,16 +4,9 @@
 /**

  * Thrown when a user tries to join a study group that has reached its member limit.

  */

-public class StudyGroupFullException extends CertifAppException {

+public record StudyGroupFullException(java.util.UUID groupId, int maxMembers) extends CertifAppException {

 

-    private final java.util.UUID groupId;

-

-    public StudyGroupFullException(java.util.UUID groupId, int maxMembers) {

+    public StudyGroupFullException {

         super("Study group " + groupId + " is full (max: " + maxMembers + ")");

-        this.groupId = groupId;

     }

-

-    public java.util.UUID getGroupId() {

-        return groupId;

-    }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/exception/SubscriptionRequiredException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/SubscriptionRequiredException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/SubscriptionRequiredException.java
@@ -4,16 +4,9 @@
 /**

  * Thrown when a PRO-only feature is accessed by a FREE-tier user.

  */

-public class SubscriptionRequiredException extends CertifAppException {

+public record SubscriptionRequiredException(String featureName) extends CertifAppException {

 

-    private final String featureName;

-

-    public SubscriptionRequiredException(String featureName) {

+    public SubscriptionRequiredException {

         super("Feature \"" + featureName + "\" requires a PRO subscription");

-        this.featureName = featureName;

     }

-

-    public String getFeatureName() {

-        return featureName;

-    }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/exception/UserNotFoundException.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/exception/UserNotFoundException.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/exception/UserNotFoundException.java
@@ -4,9 +4,8 @@
 /**

  * Thrown when a user with the given id or email does not exist.

  */

-public class UserNotFoundException extends CertifAppException {

-

-    public UserNotFoundException(String identifier) {

+public record UserNotFoundException(String identifier) extends CertifAppException {

+    public UserNotFoundException {

         super("User not found: " + identifier);

     }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/model/session/ExamMode.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/model/session/ExamMode.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/model/session/ExamMode.java
@@ -55,8 +55,8 @@
      */

     public boolean supportsTimer() {

         return switch (this) {

-            case COMPLETED, EXPIRED -> true;

-            case IN_PROGRESS, ABANDONED -> false;

+            case EXAM, FREE -> true;

+            default -> false;

         };

     }

 

@@ -68,4 +68,4 @@
     public boolean showsImmediateCorrection() {

         return this == REVISION;

     }

-}

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/model/user/UiTheme.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/model/user/UiTheme.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/model/user/UiTheme.java
@@ -6,20 +6,22 @@
  *

  * <p>Maps to the {@code theme VARCHAR(10)} column in {@code user_preferences}.</p>

  */

-public enum UiTheme {

+public record UiTheme(

+    String value

+) {

 

     /**

      * Light background — default for new users.

      */

-    LIGHT,

+    public static final UiTheme LIGHT = new UiTheme("LIGHT");

 

     /**

      * Dark background — reduced eye strain for night study.

      */

-    DARK,

+    public static final UiTheme DARK = new UiTheme("DARK");

 

     /**

      * Follow the operating system / browser preference.

      */

-    SYSTEM

-}

+    public static final UiTheme SYSTEM = new UiTheme("SYSTEM");

+}
```

### `certif-domain/src/main/java/com/certifapp/domain/service/QuestionSelectionService.java`
```diff
--- a/certif-domain/src/main/java/com/certifapp/domain/service/QuestionSelectionService.java
+++ b/certif-domain/src/main/java/com/certifapp/domain/service/QuestionSelectionService.java
@@ -4,6 +4,8 @@
 import com.certifapp.domain.model.question.Question;

 

 import java.util.*;

+import java.util.stream.Collectors;

+import java.util.stream.IntStream;

 

 /**

  * Pure domain service implementing question selection strategies.

@@ -92,4 +94,4 @@
         Collections.shuffle(selected);

         return Collections.unmodifiableList(selected);

     }

-}

+}
```
