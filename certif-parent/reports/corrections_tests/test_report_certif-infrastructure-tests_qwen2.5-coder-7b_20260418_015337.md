# 🧪 Rapport de Correction de TESTS
**Backend**: lm_studio | **Modèle**: qwen2.5-coder-7b
**Branche**: `feature/certif-ios` | **Dry-run**: NON
**Fichiers**: 35 | **Corrections**: 32 | **Durée**: 2822s

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/config/FlywayConfigTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/config/FlywayConfigTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/config/FlywayConfigTest.java
@@ -8,10 +8,14 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

 

+import static org.assertj.core.api.Assertions.assertThat;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@ExtendWith({MockitoExtension.class, SpringExtension.class})

+@DataJpaTest

 public class FlywayConfigTest {

 

     @Mock

@@ -51,5 +55,4 @@
         verify(flyway, times(1)).getConfiguration();

         verify(flyway.getConfiguration(), times(1)).getProfile();

     }

-}

-

+}
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/config/JpaConfigTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/config/JpaConfigTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/config/JpaConfigTest.java
@@ -1,54 +1,36 @@
 package com.certifapp.infrastructure.config;

 

-import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.postgresql.PostgreSQLContainer;

+import org.springframework.context.annotation.Import;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

 

 import static org.assertj.core.api.Assertions.assertThat;

-import static org.mockito.Mockito.verifyNoMoreInteractions;

 

-@ExtendWith(MockitoExtension.class)

+@ExtendWith(SpringExtension.class)

+@DataJpaTest

+@Import(JpaConfig.class)

 public class JpaConfigTest {

-

-    @Mock

-    private SomeDependency someDependency;

-

-    @InjectMocks

-    private JpaConfig jpaConfig;

-

-    @BeforeEach

-    public void setUp() {

-        // Initialize mocks if needed

-    }

-

-    @AfterEach

-    public void tearDown() {

-        verifyNoMoreInteractions(someDependency);

-    }

 

     @Test

     @DisplayName("nominal case: should configu
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/pdf/IText7PdfExportAdapterTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/pdf/IText7PdfExportAdapterTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/pdf/IText7PdfExportAdapterTest.java
@@ -11,6 +11,10 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.test.context.SpringBootTest;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.transaction.annotation.Transactional;

 

 import java.time.LocalDateTime;

 import java.util.*;

@@ -18,6 +22,8 @@
 import static org.assertj.core.api.Assertions.assertThat;

 

 @ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@Transactional

 public class IText7PdfExportAdapterTest {

 

     @Mock

@@ -90,5 +96,4 @@
         byte[] pdfBytes = adapter.exportResults(session, themeStats, questions);

         assertThat(pdfBytes).isNotEmpty();

     }

-}

-

+}
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/CertificationRepositoryAdapterTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/CertificationRepositoryAdapterTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/CertificationRepositoryAdapterTest.java
@@ -8,6 +8,14 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.List;

 import java.util.Optional;

@@ -16,8 +24,18 @@
 import static org.mockito.Mockito.verifyNoMoreInteractions;

 import static org.mockito.Mockito.when;

 

-@ExtendWith(MockitoExtension.class)

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@DataJpaTest

+@Testcontainers

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class CertificationRepositoryAdapterTest {

+

+    @Container

+    public static Postgre
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/ExamSessionRepositoryAdapterTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/ExamSessionRepositoryAdapterTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/ExamSessionRepositoryAdapterTest.java
@@ -11,6 +11,14 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.time.LocalDate;

 import java.time.OffsetDateTime;

@@ -24,8 +32,18 @@
 import static org.mockito.ArgumentMatchers.eq;

 import static org.mockito.Mockito.when;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@Testcontainers

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class ExamSessionRepositoryAdapterTest {

+

+    @Container

+    public static PostgreSQLCon
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/FlashcardRepositoryAdapterTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/FlashcardRepositoryAdapterTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/FlashcardRepositoryAdapterTest.java
@@ -10,6 +10,9 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.data.domain.PageRequest;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

 

 import java.time.LocalDate;

 import java.util.Arrays;

@@ -20,7 +23,8 @@
 import static org.mockito.ArgumentMatchers.any;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith(SpringExtension.class)

 public class FlashcardRepositoryAdapterTest {

 

     @Mock

@@ -128,4 +132,4 @@
         entity.setCreatedAt(flashcard.createdAt());

         return entity;

     }

-}

+}
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/QuestionRepositoryAdapterTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/QuestionRepositoryAdapterTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/QuestionRepositoryAdapterTest.java
@@ -14,6 +14,13 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

 

 import java.util.*;

 

@@ -21,8 +28,18 @@
 import static org.mockito.ArgumentMatchers.*;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE)

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class QuestionRepositoryAdapterTest {

+

+    @Container

+    public static PostgreSQLContainer<?> postgresql = new PostgreSQLContainer<>("postgres
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/SM2ScheduleRepositoryAdapterTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/SM2ScheduleRepositoryAdapterTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/SM2ScheduleRepositoryAdapterTest.java
@@ -8,6 +8,14 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.Optional;

 import java.util.UUID;

@@ -15,8 +23,17 @@
 import static org.assertj.core.api.Assertions.assertThat;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@Testcontainers

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

 public class SM2ScheduleRepositoryAdapterTest {

+

+    @Container

+    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")

+            .wit
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserAnswerRepositoryAdapterTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserAnswerRepositoryAdapterTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserAnswerRepositoryAdapterTest.java
@@ -12,6 +12,13 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.springframework.transaction.annotation.Transactional;

 

 import java.util.List;

 import java.util.UUID;

@@ -23,20 +30,26 @@
 import static org.mockito.ArgumentMatchers.eq;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith(SpringExtension.class)

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@Transactional

 public class UserAnswerRepositoryAdapterTest {

+

+    @Autowired

+    private UserAnswerJpaRepository jpaRepository;

+

+    @Mock

+    private ExamSessionMapper mapper;

+

+    @InjectMocks

+    private UserAnswerRepositoryAdapter userAnswerRepositoryAdapte
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserPreferencesRepositoryAdapterTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserPreferencesRepositoryAdapterTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserPreferencesRepositoryAdapterTest.java
@@ -7,6 +7,14 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.Optional;

 import java.util.UUID;

@@ -15,8 +23,18 @@
 import static org.assertj.core.api.Assertions.assertThatThrownBy;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@Testcontainers

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class UserPreferencesRepositoryAdapterTest {

+

+    @Container

+    public stati
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserRepositoryAdapterTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserRepositoryAdapterTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserRepositoryAdapterTest.java
@@ -7,14 +7,32 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.Optional;

+import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@Testcontainers

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

 public class UserRepositoryAdapterTest {

+

+    @Container

+    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")

+            .withDatabaseName("testdb")

+          
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/CertificationEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/CertificationEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/CertificationEntityTest.java
@@ -6,25 +6,31 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

 

-@ExtendWith(MockitoExtension.class)

+import java.util.ArrayList;

+import java.util.List;

+

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@SpringBootTestContextInitializer.class

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class CertificationEntityTest {

 

     @PersistenceContext

     private EntityManager entityManager;

 

-    @Mock

-    private CertificationThemeEntity theme;

-

-    @InjectMocks

-    private 
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/CertificationThemeEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/CertificationThemeEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/CertificationThemeEntityTest.java
@@ -4,27 +4,36 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.MockitoAnnotations;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.TestPropertySource;

+import org.springframework.transaction.annotation.Transactional;

+

+import java.time.OffsetDateTime;

+import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

-import static org.mockito.Mockito.verifyNoMoreInteractions;

+import static org.junit.jupiter.api.Assertions.assertThrows;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@TestPropertySource(locations = "classpath:application-test.properties")

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EAC
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/ExamSessionEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/ExamSessionEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/ExamSessionEntityTest.java
@@ -3,34 +3,33 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

 

 import java.time.OffsetDateTime;

 import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@SpringBootTestContextInitializer.class

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class ExamSessionEntityTest {

-

-    @Mock

-    private UUID id;

-

-    @InjectMocks

-    private ExamSessionEntity examSessionEntity;

 

     @BeforeEach

     public void setUp() {

-        ex
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/FlashcardEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/FlashcardEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/FlashcardEntityTest.java
@@ -3,17 +3,21 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

+

+import java.time.OffsetDateTime;

 

 import static org.assertj.core.api.Assertions.assertThat;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringJUnitConfig.Initializer.class)

+@SpringBootTestContextInitializer

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class FlashcardEntityTest {

-

-    @InjectMocks

-    private FlashcardEntity flashcardEntity;

 

     @BeforeEach

     public void setUp() {

@@ -74,4 +78,4 @@
         flashcardEntity.setAiGenerated(true);

         assertThat(flashcardEntity.isAiGenerated()).i
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/QuestionEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/QuestionEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/QuestionEntityTest.java
@@ -3,36 +3,34 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.TestPropertySource;

 

 import java.time.OffsetDateTime;

 import java.util.List;

 import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

-import static org.mockito.Mockito.when;

-

-@ExtendWith(MockitoExtension.class)

+

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@TestPropertySource(properties = "spring.flyway.enabled=true")

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class QuestionEntityTest {

-

-    @Mock

-    private QuestionOptionEntity option1;

-

-    @InjectMocks

-    private Questi
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/QuestionOptionEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/QuestionOptionEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/QuestionOptionEntityTest.java
@@ -3,31 +3,33 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.MockitoAnnotations;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.transaction.annotation.Transactional;

 

 import static org.assertj.core.api.Assertions.assertThat;

-import static org.mockito.Mockito.when;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@Transactional

 public class QuestionOptionEntityTest {

 

-    @Mock

-    private QuestionEntity question;

-

-    @InjectMocks

-    private QuestionOptionEntity questionOption;

+    @Autowired

+    private QuestionOptionRepository questionOptionRepository;

 

     @BeforeEach

     public void setUp() {

-        MockitoAnnotations.openMocks
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/SM2ScheduleEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/SM2ScheduleEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/SM2ScheduleEntityTest.java
@@ -3,9 +3,15 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.time.LocalDate;

 import java.time.OffsetDateTime;

@@ -13,79 +19,103 @@
 

 import static org.assertj.core.api.Assertions.assertThat;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@Testcontainers

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 p
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/UserAnswerEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/UserAnswerEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/UserAnswerEntityTest.java
@@ -4,114 +4,131 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

 import static org.mockito.Mockito.verifyNoMoreInteractions;

-import static org.mockito.Mockito.when;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@SpringJUnitConfig(classe
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/UserEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/UserEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/UserEntityTest.java
@@ -4,69 +4,98 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.time.OffsetDateTime;

 import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

-import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringExtension.class)

+@Testcontainers

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_M
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/UserPreferencesEntityTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/UserPreferencesEntityTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/entity/UserPreferencesEntityTest.java
@@ -3,150 +3,249 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.MockitoAnnotations;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

+

+import java.time.OffsetDateTime;

+import java.util.UUID;

 

 import static org.assertj.core.api.Assertions.assertThat;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringJUnitConfig.Initializer.class)

+@SpringBootTestContextInitializer

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class UserPreferencesEntityTest {

 

-    @InjectMocks

-    private UserPreferencesEntity userPreferencesEntity;

+    @
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/CertificationMapperTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/CertificationMapperTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/CertificationMapperTest.java
@@ -8,12 +8,32 @@
 import org.mockito.Mock;

 import org.mockito.MockitoAnnotations;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

-import static org.mockito.Mockito.mock;

-import static org.mockito.Mockito.when;

+import java.util.List;

+import java.util.stream.Stream;

 

-@ExtendWith(MockitoExtension.class)

+import static org.assertj.core.api.Assertions.assertThat;

+

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@DataJpaTest

+@Testcontainers

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class CertificationMapperTest {

+

+    @Container

+    public static Postg
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/ExamSessionMapperTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/ExamSessionMapperTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/ExamSessionMapperTest.java
@@ -11,12 +11,32 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

+

+import java.util.List;

 

 import static org.assertj.core.api.Assertions.assertThat;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@Testcontainers

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class ExamSessionMapperTest {

+

+    @Container

+    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")

+            .w
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/QuestionMapperTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/QuestionMapperTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/QuestionMapperTest.java
@@ -11,6 +11,13 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

 

 import java.util.Arrays;

 import java.util.List;

@@ -21,8 +28,18 @@
 import static org.mockito.Mockito.reset;

 import static org.mockito.Mockito.when;

 

-@ExtendWith(MockitoExtension.class)

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE)

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class QuestionMapperTest {

+

+    @Container

+    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")

+
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/UserMapperTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/UserMapperTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/mapper/UserMapperTest.java
@@ -10,6 +10,13 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

 

 import java.util.Arrays;

 import java.util.List;

@@ -18,8 +25,17 @@
 import static org.mockito.Mockito.anyString;

 import static org.mockito.Mockito.when;

 

-@ExtendWith(MockitoExtension.class)

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class UserMapperTest {

+

+    @Container

+    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")

+            .withDatabaseName("testdb")

+            .withUsername("testuser")
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/CertificationJpaRepositoryTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/CertificationJpaRepositoryTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/CertificationJpaRepositoryTest.java
@@ -3,68 +3,71 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.List;

 

 import static org.assertj.core.api.Assertions.assertThat;

-import static org.mockito.Mockito.when;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@SpringJUnitConfig(classes = {CertificationJpaRepositoryTest.
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/ExamSessionJpaRepositoryTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/ExamSessionJpaRepositoryTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/ExamSessionJpaRepositoryTest.java
@@ -25,7 +25,7 @@
 public class ExamSessionJpaRepositoryTest {

 

     @Mock

-    private ExamSessionEntity examSessionEntity;

+    private ExamSessionEntityRepository examSessionEntityRepository;

 

     @InjectMocks

     private ExamSessionJpaRepositoryImpl examSessionJpaRepository;

@@ -133,4 +133,4 @@
         verify(examSessionEntityRepository, never())

                 .findByUserIdWithFilters(any(UUID.class), any(String.class), any(String.class), any(OffsetDateTime.class), any(OffsetDateTime.class), any(Pageable.class));

     }

-}

+}
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/QuestionJpaRepositoryTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/QuestionJpaRepositoryTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/QuestionJpaRepositoryTest.java
@@ -4,29 +4,41 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.MockitoAnnotations;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.TestPropertySource;

+import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.*;

 

 import static org.assertj.core.api.Assertions.assertThat;

 import static org.mockito.Mockito.when;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTes
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/SM2ScheduleJpaRepositoryTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/SM2ScheduleJpaRepositoryTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/SM2ScheduleJpaRepositoryTest.java
@@ -8,6 +8,13 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

 

 import java.util.Optional;

 import java.util.UUID;

@@ -15,8 +22,18 @@
 import static org.assertj.core.api.Assertions.assertThat;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@SpringBootTest

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class SM2ScheduleJpaRepositoryTest {

+

+    @Container

+    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")

+ 
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/UserAnswerJpaRepositoryTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/UserAnswerJpaRepositoryTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/UserAnswerJpaRepositoryTest.java
@@ -4,10 +4,15 @@
 import org.junit.jupiter.api.BeforeEach;

 import org.junit.jupiter.api.DisplayName;

 import org.junit.jupiter.api.Test;

-import org.junit.jupiter.api.extension.ExtendWith;

-import org.mockito.InjectMocks;

-import org.mockito.Mock;

-import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.beans.factory.annotation.Autowired;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.Arrays;

 import java.util.List;

@@ -17,57 +22,62 @@
 import static org.mockito.ArgumentMatchers.any;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@Testcontainers

+@DirtiesContext(clas
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/UserJpaRepositoryTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/UserJpaRepositoryTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/UserJpaRepositoryTest.java
@@ -8,6 +8,14 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.Optional;

 import java.util.UUID;

@@ -15,8 +23,17 @@
 import static org.assertj.core.api.Assertions.assertThat;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@Testcontainers

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

 public class UserJpaRepositoryTest {

+

+    @Container

+    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")

+            .withDatabaseName("testdb")

+ 
```

### `certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/UserPreferencesJpaRepositoryTest.java`
```diff
--- a/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/UserPreferencesJpaRepositoryTest.java
+++ b/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/repository/UserPreferencesJpaRepositoryTest.java
@@ -8,6 +8,14 @@
 import org.mockito.InjectMocks;

 import org.mockito.Mock;

 import org.mockito.junit.jupiter.MockitoExtension;

+import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

+import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;

+import org.springframework.test.annotation.DirtiesContext;

+import org.springframework.test.context.ContextConfiguration;

+import org.springframework.test.context.junit.jupiter.SpringExtension;

+import org.testcontainers.containers.PostgreSQLContainer;

+import org.testcontainers.junit.jupiter.Container;

+import org.testcontainers.junit.jupiter.Testcontainers;

 

 import java.util.Optional;

 import java.util.UUID;

@@ -15,8 +23,18 @@
 import static org.assertj.core.api.Assertions.assertThat;

 import static org.mockito.Mockito.*;

 

-@ExtendWith(MockitoExtension.class)

+@DataJpaTest

+@ExtendWith({SpringExtension.class, MockitoExtension.class})

+@Testcontainers

+@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)

+@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)

 public class UserPreferencesJpaRepositoryTest {

+

+    @Container

+    public static PostgreSQLCo
```
