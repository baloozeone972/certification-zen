# 📋 Rapport certif-application
**Backend**: lm_studio | **Modèle**: qwen2.5-coder-7b
**Branche**: `develop` | **Dry-run**: NON
**Fichiers**: 44 | **Corrections**: 1 | **Durée**: 214s

### `certif-application/src/main/java/com/certifapp/application/usecase/exam/GetExamResultsUseCaseImpl.java`
```diff
--- a/certif-application/src/main/java/com/certifapp/application/usecase/exam/GetExamResultsUseCaseImpl.java
+++ b/certif-application/src/main/java/com/certifapp/application/usecase/exam/GetExamResultsUseCaseImpl.java
@@ -21,11 +21,8 @@
 

     @Override

     public ExamSession execute(UUID sessionId, UUID userId) {

-        ExamSession session = sessionRepository.findById(sessionId)

+        return sessionRepository.findById(sessionId)

+                .filter(session -> session.userId().equals(userId))

                 .orElseThrow(() -> new ExamSessionNotFoundException(sessionId));

-        if (!session.userId().equals(userId)) {

-            throw new ExamSessionNotFoundException(sessionId);

-        }

-        return session;

     }

-}

+}
```
