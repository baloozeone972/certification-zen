# 📋 Rapport certif-api-rest
**Backend**: lm_studio | **Modèle**: qwen2.5-coder-7b
**Branche**: `develop` | **Dry-run**: NON
**Fichiers**: 30 | **Corrections**: 1 | **Durée**: 174s

### `certif-api-rest/src/main/java/com/certifapp/api/controller/ExamController.java`
```diff
--- a/certif-api-rest/src/main/java/com/certifapp/api/controller/ExamController.java
+++ b/certif-api-rest/src/main/java/com/certifapp/api/controller/ExamController.java
@@ -144,7 +144,7 @@
         return ResponseEntity.ok()

                 .contentType(MediaType.APPLICATION_PDF)

                 .header(HttpHeaders.CONTENT_DISPOSITION,

-                        "attachment; filename=" certifapp_results_" + id + ".pdf"")

+                        "attachment; filename=certifapp_results_" + id + ".pdf")

                 .body(pdf);

     }

 

@@ -170,4 +170,4 @@
         var filter = new GetSessionHistoryUseCase.HistoryFilter(certificationId, examMode, null, null);

         return ResponseEntity.ok(ApiResponse.ok(historyUseCase.execute(userId, filter, page, size)));

     }

-}

+}
```
