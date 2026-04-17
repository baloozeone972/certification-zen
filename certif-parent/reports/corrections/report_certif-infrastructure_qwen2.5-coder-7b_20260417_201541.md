# 📋 Rapport certif-infrastructure
**Backend**: lm_studio | **Modèle**: qwen2.5-coder-7b
**Branche**: `develop` | **Dry-run**: NON
**Fichiers**: 34 | **Corrections**: 2 | **Durée**: 501s

### `certif-infrastructure/src/main/java/com/certifapp/infrastructure/config/FlywayConfig.java`
```diff
--- a/certif-infrastructure/src/main/java/com/certifapp/infrastructure/config/FlywayConfig.java
+++ b/certif-infrastructure/src/main/java/com/certifapp/infrastructure/config/FlywayConfig.java
@@ -23,6 +23,9 @@
     @Bean

     @Profile("test")

     public FlywayMigrationStrategy cleanMigrateStrategy() {

-        return Flyway::migrate;

+        return flyway -> {

+            flyway.clean();

+            flyway.migrate();

+        };

     }

-}

+}
```

### `certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/FlashcardJpaRepository.java`
```diff
--- a/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/FlashcardJpaRepository.java
+++ b/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/repository/FlashcardJpaRepository.java
@@ -34,6 +34,5 @@
     List<FlashcardEntity> findDueByUserAndCertification(

             @Param("userId") UUID userId,

             @Param("certId") String certId,

-            @Param("today") LocalDate today,

-            org.springframework.data.domain.Pageable pageable);

-}

+            @Param("today") LocalDate today);

+}
```
