# 🧪 Rapport de Correction de TESTS
**Backend**: lm_studio | **Modèle**: qwen2.5-coder-7b
**Branche**: `feature/certif-ios` | **Dry-run**: NON
**Fichiers**: 14 | **Corrections**: 4 | **Durée**: 949s

### `certif-ai/src/test/java/com/certifapp/ai/config/EmbeddingConfigTest.java`
```diff
--- a/certif-ai/src/test/java/com/certifapp/ai/config/EmbeddingConfigTest.java
+++ b/certif-ai/src/test/java/com/certifapp/ai/config/EmbeddingConfigTest.java
@@ -8,7 +8,6 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

-import org.springframework.beans.factory.annotation.Value;

 

 import java.time.Duration;

 

@@ -24,35 +23,28 @@
     @InjectMocks

     private EmbeddingConfig embeddingConfig;

 

-    @Value("${certifapp.ai.ollama.base-url:http://localhost:11434}")

-    private String baseUrl;

-

-    @Value("${certifapp.ai.ollama.embedding-model:nomic-embed-text}")

-    private String modelName;

-

     @BeforeEach

     public void setUp() {

-        when(ollamaEmbeddingModelBuilder.baseUrl(baseUrl)).thenReturn(ollamaEmbeddingModelBuilder);

-        when(ollamaEmbeddingModelBuilder.modelName(modelName)).thenReturn(ollamaEmbeddingModelBuilder);

+        when(ollamaEmbeddingModelBuilder.baseUrl(anyString())).thenReturn(ollamaEmbeddingModelBuilder);

+        when(ollamaEmbeddingModelBuilder.modelName(anyString())).thenReturn(ollamaEmbeddingModelBuilder);

         when(ollamaEmbeddingModelBuilder.timeout(Duration.ofSeconds(60))).thenReturn(ollamaEmbeddingModelBuilder);

     }

 

     @Test

     @DisplayName("nominal case: should return OllamaEmbeddingModel for local profile")

     public void ollamaEmbeddingModel_localProfile_returnOllamaEmbeddingModel() {

-        EmbeddingModel result = emb
```

### `certif-ai/src/test/java/com/certifapp/ai/rag/DocumentIngesterTest.java`
```diff
--- a/certif-ai/src/test/java/com/certifapp/ai/rag/DocumentIngesterTest.java
+++ b/certif-ai/src/test/java/com/certifapp/ai/rag/DocumentIngesterTest.java
@@ -54,7 +54,6 @@
         documentIngester.ingestQuestions(questions, certificationId);

 

         verify(vectorStore, never()).store(any(), any());

-        // Assuming a mock for Logger to check logs

     }

 

     @Test

@@ -68,7 +67,6 @@
         documentIngester.ingestQuestions(questions, certificationId);

 

         verify(vectorStore).store(any(), any());

-        // Assuming a mock for Logger to check logs

     }

 

     @Test

@@ -91,7 +89,6 @@
         documentIngester.ingestCourse(course);

 

         verify(vectorStore, never()).store(any(), any());

-        // Assuming a mock for Logger to check logs

     }

 

     @Test

@@ -105,7 +102,5 @@
         documentIngester.ingestCourse(course);

 

         verify(vectorStore, atLeastOnce()).store(any(), any());

-        // Assuming a mock for Logger to check logs

     }

-}

-

+}
```

### `certif-ai/src/test/java/com/certifapp/ai/service/ChatAssistantTest.java`
```diff
--- a/certif-ai/src/test/java/com/certifapp/ai/service/ChatAssistantTest.java
+++ b/certif-ai/src/test/java/com/certifapp/ai/service/ChatAssistantTest.java
@@ -1,4 +1,3 @@
-// certif-parent/certif-ai/src/test/java/com/certifapp/ai/service/ChatAssistantTest.java

 package com.certifapp.ai.service;

 

 import com.certifapp.ai.rag.RetrievalService;

@@ -95,4 +94,4 @@
 

         verify(heavyModel, times(2)).generate(anyString());

     }

-}

+}
```

### `certif-ai/src/test/java/com/certifapp/ai/service/ExplanationEnricherTest.java`
```diff
--- a/certif-ai/src/test/java/com/certifapp/ai/service/ExplanationEnricherTest.java
+++ b/certif-ai/src/test/java/com/certifapp/ai/service/ExplanationEnricherTest.java
@@ -1,4 +1,3 @@
-// certif-parent/certif-ai/src/test/java/com/certifapp/ai/service/ExplanationEnricherTest.java

 package com.certifapp.ai.service;

 

 import com.certifapp.domain.model.question.*;

@@ -15,14 +14,10 @@
 import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

-import static org.assertj.core.api.Assertions.assertThatCode;

 import static org.mockito.ArgumentMatchers.anyString;

 import static org.mockito.Mockito.verify;

 import static org.mockito.Mockito.when;

 

-/**

- * Unit tests for {@link ExplanationEnricher}.

- */

 @ExtendWith(MockitoExtension.class)

 @DisplayName("ExplanationEnricher")

 class ExplanationEnricherTest {

@@ -73,8 +68,6 @@
         verify(lightModel).generate(anyString());

     }

 

-    // ── Helpers ───────────────────────────────────────────────────────────────

-

     @Test

     @DisplayName("Falls back to original explanation on AI error")

     void enrich_onError_shouldFallBackToOriginal() {

@@ -96,4 +89,4 @@
 

         assertThatCode(() -> enricher.enrich(q)).doesNotThrowAnyException();

     }

-}

+}
```
