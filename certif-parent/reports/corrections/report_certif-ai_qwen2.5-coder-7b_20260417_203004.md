# 📋 Rapport certif-ai
**Backend**: lm_studio | **Modèle**: qwen2.5-coder-7b
**Branche**: `develop` | **Dry-run**: NON
**Fichiers**: 14 | **Corrections**: 4 | **Durée**: 299s

### `certif-ai/src/main/java/com/certifapp/ai/service/CertPathAdvisor.java`
```diff
--- a/certif-ai/src/main/java/com/certifapp/ai/service/CertPathAdvisor.java
+++ b/certif-ai/src/main/java/com/certifapp/ai/service/CertPathAdvisor.java
@@ -68,12 +68,11 @@
 

         try {

             String response = lightModel.generate(prompt);

-            String json = response.replaceAll("json\s*|", "").trim();

-            return objectMapper.readValue(json, new TypeReference<>() {

-            });

+            String json = response.replaceAll("json\\s*|", "").trim();

+            return objectMapper.readValue(json, new TypeReference<>() {});

         } catch (Exception e) {

             log.error("Failed to generate cert path: {}", e.getMessage());

             return Map.of("steps", List.of(), "aiRationale", "");

         }

     }

-}

+}
```

### `certif-ai/src/main/java/com/certifapp/ai/service/DiagnosticAnalyzer.java`
```diff
--- a/certif-ai/src/main/java/com/certifapp/ai/service/DiagnosticAnalyzer.java
+++ b/certif-ai/src/main/java/com/certifapp/ai/service/DiagnosticAnalyzer.java
@@ -67,9 +67,8 @@
 

         try {

             String response = lightModel.generate(prompt);

-            String json = response.replaceAll("json\s*|", "").trim();

-            return objectMapper.readValue(json, new TypeReference<>() {

-            });

+            String json = response.replaceAll("json\\s*|", "").trim();

+            return objectMapper.readValue(json, new TypeReference<>() {});

         } catch (Exception e) {

             log.error("Failed to analyze diagnostic: {}", e.getMessage());

             return Map.of(

@@ -78,4 +77,4 @@
             );

         }

     }

-}

+}
```

### `certif-ai/src/main/java/com/certifapp/ai/service/FlashcardGenerator.java`
```diff
--- a/certif-ai/src/main/java/com/certifapp/ai/service/FlashcardGenerator.java
+++ b/certif-ai/src/main/java/com/certifapp/ai/service/FlashcardGenerator.java
@@ -68,7 +68,7 @@
         try {

             String response = lightModel.generate(prompt);

             // Strip potential markdown code fences

-            String json = response.replaceAll("json\s*|", "").trim();

+            String json = response.replaceAll("json\\s*|", "").trim();

             List<Map<String, String>> raw = objectMapper.readValue(

                     json, new TypeReference<>() {

                     });

@@ -89,4 +89,4 @@
             return new ArrayList<>();

         }

     }

-}

+}
```

### `certif-ai/src/main/java/com/certifapp/ai/service/PromptRenderer.java`
```diff
--- a/certif-ai/src/main/java/com/certifapp/ai/service/PromptRenderer.java
+++ b/certif-ai/src/main/java/com/certifapp/ai/service/PromptRenderer.java
@@ -2,6 +2,7 @@
 package com.certifapp.ai.service;

 

 import org.springframework.stereotype.Component;

+import org.springframework.transaction.annotation.Transactional;

 

 import java.io.IOException;

 import java.io.InputStream;

@@ -28,6 +29,7 @@
      * @param variables    key-value pairs to inject into the template

      * @return rendered prompt string

      */

+    @Transactional(readOnly = true)

     public String render(String templateName, Map<String, Object> variables) {

         String template = templateCache.computeIfAbsent(

                 templateName, this::loadTemplate);

@@ -56,4 +58,4 @@
             throw new RuntimeException("Failed to load prompt template: " + path, e);

         }

     }

-}

+}
```
