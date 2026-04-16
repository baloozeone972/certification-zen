# PHASE 1 — Rapport d'analyse exhaustif du code source JavaFX
## CertiPrep Engine → CertifApp (certification-zen)

> **Date d'analyse :** 2025  
> **Analysé par :** Architecte logiciel senior IA  
> **Repo source :** CertiPrepEngine  
> **Repo cible :** certification-zen  

---

## 1. INVENTAIRE DES CLASSES

### 1.1 Couche UI — Contrôleurs JavaFX (package `com.certiprep.ui`)

| Classe | Chemin complet | Responsabilité | Couche | Dépendances projet | Décision | Justification |
|---|---|---|---|---|---|---|
| `CertiPrepApp` | `src/main/java/com/certiprep/CertiPrepApp.java` | Point d'entrée JavaFX, initialisation de tous les services, chargement de la scène principale | UI / Config | `ThemeManager`, `I18nService`, `DatabaseService`, `QuestionLoader`, `MainController` | **RÉÉCRIRE** | Remplacé par `@SpringBootApplication` + `CertifAppApplication.java` |
| `MainController` | `src/main/java/com/certiprep/ui/MainController.java` | Écran principal : liste des certifications, navigation vers les 3 modes | UI | `Certification`, `DatabaseService`, `I18nService`, `QuestionLoader`, `ThemeManager` | **RÉÉCRIRE** | Remplacé par le composant Angular `HomeComponent` |
| `ExamController` | `src/main/java/com/certiprep/ui/ExamController.java` | Mode Examen : timer `javafx.animation.Timeline`, navigation questions, soumission, pause | UI | `Certification`, `ExamSession`, `Question`, `UserAnswer`, `DatabaseService`, `I18nService`, `QuestionLoader`, `ScoringService`, `ThemeManager` | **RÉÉCRIRE** | Remplacé par `ExamComponent` Angular + use case `ConductExamUseCase` |
| `FreeModeController` | `src/main/java/com/certiprep/ui/FreeModeController.java` | Configuration du mode libre : sélection thèmes, slider questions, durée optionnelle ; répartition proportionnelle des questions par thème | UI | `Certification`, `Question`, `DatabaseService`, `I18nService`, `QuestionLoader`, `ThemeManager` | **RÉÉCRIRE** | Remplacé par `FreeModeComponent` Angular + use case `CreateFreeModeExamUseCase` |
| `RevisionController` | `src/main/java/com/certiprep/ui/RevisionController.java` | Mode Révision : sélection thème/nombre, affichage question par question avec correction immédiate, navigation aléatoire | UI | `Certification`, `Question`, `DatabaseService`, `I18nService`, `QuestionLoader`, `ThemeManager` | **RÉÉCRIRE** | Remplacé par `RevisionComponent` Angular |
| `ResultsController` | `src/main/java/com/certiprep/ui/ResultsController.java` | Affichage des résultats post-examen : score, graphique par thème, export PDF, révision des erreurs. Contient la classe interne `ThemeStats` | UI | `ExamSession`, `Question`, `ScoringService`, `PdfExportService`, `DatabaseService`, `I18nService`, `ThemeManager` | **RÉÉCRIRE** | Remplacé par `ResultsComponent` Angular ; `ThemeStats` migre en Record domain |
| `HistoryController` | `src/main/java/com/certiprep/ui/HistoryController.java` | Historique des sessions avec filtres certification/mode, suppression, export CSV | UI | `ExamSession`, `DatabaseService`, `I18nService`, `QuestionLoader`, `ThemeManager` | **RÉÉCRIRE** | Remplacé par `HistoryComponent` Angular + use case `GetSessionHistoryUseCase` |
| `SessionDetailController` | `src/main/java/com/certiprep/ui/SessionDetailController.java` | Détail d'une session archivée : navigation question par question, réponse utilisateur vs correcte, explication | UI | `ExamSession`, `Question`, `UserAnswer`, `I18nService`, `ThemeManager` | **RÉÉCRIRE** | Remplacé par `SessionDetailComponent` Angular |
| `SettingsController` | `src/main/java/com/certiprep/ui/SettingsController.java` | Paramètres : thème, langue, export/import/reset données | UI | `DatabaseService`, `I18nService`, `PreferencesService`, `QuestionLoader`, `ThemeManager` | **RÉÉCRIRE** | Remplacé par `SettingsComponent` Angular + API `PATCH /users/me/preferences` |
| `ImportQuestionsController` | `src/main/java/com/certiprep/ui/ImportQuestionsController.java` | Import de questions supplémentaires depuis un fichier JSON externe | UI | `Question`, `QuestionLoader` | **RÉÉCRIRE** | Remplacé par endpoint admin `POST /admin/questions/import` |

### 1.2 Couche Domain — Modèles métier (package `com.certiprep.core.model`)

| Classe | Chemin complet | Responsabilité | Couche | Dépendances projet | Décision | Justification |
|---|---|---|---|---|---|---|
| `Question` | `src/main/java/com/certiprep/core/model/Question.java` | Entité question : id, thème, label thème, difficulté, énoncé, options[], index réponse correcte, explication | Domain | Aucune | **MIGRER-DOMAIN** | Pure POJO sans dépendance framework → Record Java 21 dans `certif-domain` |
| `Certification` | `src/main/java/com/certiprep/core/model/Certification.java` | Entité certification : id, nom, description, totalQuestions, durée, examQuestionCount, passingScore, thèmes[] ; contient la classe interne `ThemeInfo` | Domain | Aucune | **MIGRER-DOMAIN** | Pure POJO → Record Java 21 avec `ThemeInfo` en record imbriqué |
| `ExamSession` | `src/main/java/com/certiprep/core/model/ExamSession.java` | Entité session : sessionId (UUID), certificationId, startTime, endTime, durationMinutes (config max), totalQuestions, score, passed, mode, userAnswers[] ; `getPercentage()` et `getDurationSeconds()` calculés | Domain | `UserAnswer`, `ExamMode` (enum interne) | **MIGRER-DOMAIN** | Logique métier pure → Record Java 21 avec méthodes calculées conservées |
| `UserAnswer` | `src/main/java/com/certiprep/core/model/UserAnswer.java` | Réponse utilisateur : questionId, selectedAnswer (int, -1 si non répondue), isCorrect, responseTimeMs, theme | Domain | Aucune | **MIGRER-DOMAIN** | Pure POJO → Record Java 21 dans `certif-domain` |
| `ThemeStats` *(classe interne dans ResultsController)* | `src/main/java/com/certiprep/ui/ResultsController.java` | Statistiques par thème : correct, wrong, skipped, total, percentage | Domain | Aucune | **MIGRER-DOMAIN** | Logique métier pure extraite en Record séparé `ThemeStats.java` |

### 1.3 Couche Service — Logique métier et infrastructure (package `com.certiprep.core.service`)

| Classe | Chemin complet | Responsabilité | Couche | Dépendances projet | Décision | Justification |
|---|---|---|---|---|---|---|
| `QuestionLoader` | `src/main/java/com/certiprep/core/service/QuestionLoader.java` | Singleton : chargement dynamique JSON, scan des certifications, randomisation, filtrage par thème, répartition proportionnelle | Service / Data | `Question`, `Certification` | **MIGRER-INFRA** | Logique de sélection → use case `certif-application` ; chargement JSON → seed Flyway dans `certif-infrastructure` |
| `DatabaseService` | `src/main/java/com/certiprep/core/service/DatabaseService.java` | Singleton SQLite : création tables, CRUD `exam_sessions` + `user_answers` | Data | `ExamSession`, `UserAnswer` | **RÉÉCRIRE** | Remplacé par repositories JPA Spring Data + Flyway dans `certif-infrastructure` |
| `ScoringService` | `src/main/java/com/certiprep/core/service/ScoringService.java` | Singleton : calcul score, percentage, passed, stats par thème, analyse par difficulté, extraction questions erronées/ignorées | Service | `ExamSession`, `Question`, `UserAnswer`, `ThemeStats`, `QuestionLoader` | **MIGRER-DOMAIN** | Algorithme pur sans dépendance framework → `ScoringService.java` dans `certif-domain` |
| `PdfExportService` | `src/main/java/com/certiprep/core/service/PdfExportService.java` | Singleton iText7 : export PDF résultats (résumé + détail thèmes + toutes réponses) | Service | `ExamSession`, `Question`, `UserAnswer`, `ThemeStats` | **MIGRER-INFRA** | iText7 conservé dans `certif-infrastructure` ; interface port dans `certif-application` |
| `I18nService` | `src/main/java/com/certiprep/core/service/I18nService.java` | Singleton : `ResourceBundle` FR/EN, chargement par `Locale` | Service | Aucune | **RÉÉCRIRE** | Remplacé par `Spring MessageSource` (backend) + Angular i18n (frontend) |
| `PreferencesService` | `src/main/java/com/certiprep/core/service/PreferencesService.java` | Singleton : persistence des préférences utilisateur via `java.util.prefs.Preferences` (OS registry/fichier) ; thème, langue, dernière certification, config mode libre, taille fenêtre | Service | `ThemeManager`, `I18nService` | **RÉÉCRIRE** | Remplacé par table `user_preferences` PostgreSQL + endpoint `PATCH /users/me/preferences` |

### 1.4 Couche Util (package `com.certiprep.core.utils`)

| Classe | Chemin complet | Responsabilité | Couche | Dépendances projet | Décision | Justification |
|---|---|---|---|---|---|---|
| `ThemeManager` | `src/main/java/com/certiprep/core/utils/ThemeManager.java` | Gestion CSS JavaFX : basculement thème clair/sombre via `scene.getStylesheets()` | Util | Aucune | **SUPPRIMER** | Fonctionnalité portée par CSS variables Angular/Tailwind + préférence stockée |
| `LoggerUtil` | `src/main/java/com/certiprep/core/utils/LoggerUtil.java` | Factory `java.util.logging.Logger` | Util | Aucune | **SUPPRIMER** | Remplacé par SLF4J + Logback dans Spring Boot |
| `LogUtils` | `src/main/java/com/certiprep/core/utils/LogUtils.java` | Initialisation répertoire de logs, nettoyage des anciens logs | Util | Aucune | **SUPPRIMER** | Spring Boot gère les logs via Logback |

---

## 2. MODÈLE DE DONNÉES COMPLET

### 2.1 Schéma SQLite actuel (DDL extrait de `DatabaseService.createTables()`)

```sql
-- Table des sessions d'examen
CREATE TABLE IF NOT EXISTS exam_sessions (
    session_id       TEXT PRIMARY KEY,        -- UUID en format String (UUID.randomUUID().toString())
    certification_id TEXT NOT NULL,           -- ID textuel de la certification (ex: "java21", "aws_ccp")
    start_time       TEXT NOT NULL,           -- LocalDateTime sérialisé en String ISO-8601
    end_time         TEXT,                    -- NULL si session non terminée ou abandonnée
    duration_minutes INTEGER,                 -- Durée MAX de l'examen (config), PAS la durée réelle
    total_questions  INTEGER,                 -- Nombre de questions dans l'examen
    score            INTEGER,                 -- Nombre de réponses correctes
    passed           INTEGER,                 -- Booléen stocké comme 0/1
    mode             TEXT,                    -- Enum: "EXAM", "FREE", "REVISION"
    percentage       REAL                     -- Dénormalisé : score*100.0/total_questions
);

-- Table des réponses utilisateur
CREATE TABLE IF NOT EXISTS user_answers (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,  -- Clé technique
    session_id       TEXT NOT NULL,                      -- FK → exam_sessions.session_id
    question_id      TEXT NOT NULL,                      -- ID textuel de la question (ex: "JAVA-001")
    selected_answer  INTEGER,                            -- Index de l'option choisie (0-based), -1 si non répondue
    is_correct       INTEGER,                            -- Booléen 0/1
    response_time_ms INTEGER,                            -- Temps de réponse en millisecondes
    theme            TEXT,                               -- Nom du thème dénormalisé depuis la question
    FOREIGN KEY (session_id) REFERENCES exam_sessions(session_id)
);

-- Index de performance
CREATE INDEX IF NOT EXISTS idx_session_id ON user_answers(session_id);
```

**Anomalies SQLite identifiées :**
- `duration_minutes` stocke la durée **MAX de l'examen** (config), pas la durée réelle passée → confusion avec le champ calculé `getDurationSeconds()` dans `ExamSession`
- Dans `ExamController.createSession()` : `session.setDurationMinutes((int)(timeSpent / 60))` → **écrase** la valeur de config par le temps réel. Incohérence à corriger dans le modèle PostgreSQL.
- Pas de colonne `duration_seconds` pour la durée réelle → calculé à la volée depuis `startTime`/`endTime` via `getDurationSeconds()`

### 2.2 Structure complète d'une Question (format JSON)

#### Champs identifiés

| Champ | Type JSON | Obligatoire | Description |
|---|---|---|---|
| `id` | `String` | ✅ | Identifiant unique — format `{PREFIX}-{NNN}` ex: `JAVA-001`, `AWS-CCP-001`, `SB3-DATA-042` |
| `theme` | `String` | ✅ | Nom du thème principal (ex: `"Lambda, Streams et API fonctionnelle"`) |
| `theme_label` | `String` | ✅ | Sous-thème précis (ex: `"Stream terminal operations"`) |
| `difficulty` | `String` | ✅ | `"easy"` \| `"medium"` \| `"hard"` |
| `question` | `String` | ✅ | Énoncé de la question |
| `options` | `String[]` | ✅ | Tableau de 4 options de réponse (texte) |
| `correct` | `int` | ✅ | **Index 0-based** de la réponse correcte dans `options[]` |
| `explanation` | `String` | ✅ (majorité) | Explication de la réponse correcte |
| `explication` | `String` | ⚠️ variante | **Incohérence** : champ `explication` (sans `a`) dans certifications AWS_CCP, AWS_DEV, Terraform → doit être normalisé en `explanation` |

#### Exemple concret — question `java21` (format canonique)

```json
{
  "id": "JAVA-LAMBDA-001",
  "theme": "Lambda, Streams et API fonctionnelle",
  "theme_label": "Stream terminal operations",
  "difficulty": "medium",
  "question": "Quelle méthode de Stream permet de collecter les éléments dans une List ?",
  "options": [
    "collect(Collectors.toList())",
    "toList()",
    "asList()",
    "A et B"
  ],
  "correct": 3,
  "explanation": "Depuis Java 16, Stream.toList() est disponible. collect(Collectors.toList()) fonctionne depuis Java 8."
}
```

#### Exemple concret — question AWS (format avec anomalie `explication`)

```json
{
  "id": "AWS-CCP-065",
  "theme": "Core Services",
  "theme_label": "Lambda",
  "difficulty": "easy",
  "question": "Qu'est-ce qu'AWS Lambda ?",
  "options": [
    "Fonction serverless",
    "Service de calcul",
    "Base de données",
    "Stockage"
  ],
  "correct": 0,
  "explication": "Lambda exécute du code sans provisionner de serveurs."
}
```

**Remarque :** Le type de question est exclusivement **QCM à choix unique** (`correct` = 1 seul index entier). Il n'existe pas dans le code source de QCM à choix multiples (tableau d'indices). La réponse "A et B" ou "Toutes ces réponses" est modélisée comme une **option texte normale** avec un index unique. Ce point est critique pour la migration : la table `question_options` avec `is_correct BOOLEAN` permettra de supporter les vrais QCM multiples à l'avenir.

### 2.3 Structure d'une Certification (format `config.json`)

#### Champs identifiés

| Champ | Type JSON | Obligatoire | Description |
|---|---|---|---|
| `id` | `String` | ✅ | Identifiant interne (ex: `"java21"`, `"aws_ccp"`) |
| `name` | `String` | ✅ | Nom complet avec code officiel (ex: `"Java 21 Developer Certification (1Z0-830)"`) |
| `version` | `String` | ✅ | Version du fichier config (toujours `"1.0"`) |
| `description` | `String` | ✅ | Description longue |
| `totalQuestions` | `int` | ✅ | Nombre total de questions dans le corpus |
| `examDurationMinutes` | `int` | ✅ | Durée de l'examen officiel en minutes |
| `examQuestionCount` | `int` | ✅ | Nombre de questions tirées pour un examen |
| `passingScore` | `int` | ✅ | Seuil de passage en pourcentage (ex: `68`) |
| `themes` | `ThemeInfo[]` | ✅ | Liste des thèmes avec pondération |
| `themes[].name` | `String` | ✅ | Nom du thème |
| `themes[].count` | `int` | ✅ | Nombre de questions dans ce thème |
| `examType` | `String` | ⚠️ optionnel | `"practical"` pour CKA, CKAD, CKS — absent pour les certifications QCM |

#### Exemple concret — `java21/config.json`

```json
{
  "id": "java21",
  "name": "Java 21 Developer Certification (1Z0-830)",
  "version": "1.0",
  "description": "Préparation complète à la certification Oracle Java 21 Developer.",
  "totalQuestions": 500,
  "examDurationMinutes": 180,
  "examQuestionCount": 80,
  "passingScore": 68,
  "themes": [
    { "name": "Fondamentaux du Langage", "count": 50 },
    { "name": "Lambda, Streams et API fonctionnelle", "count": 60 }
  ]
}
```

### 2.4 ERD PostgreSQL cible — Scripts DDL complets

```sql
-- ============================================================
-- EXTENSION : UUID natif PostgreSQL
-- ============================================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- TABLE : users
-- ============================================================
CREATE TABLE users (
    id                  UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    email               VARCHAR(255) NOT NULL UNIQUE,
    password_hash       VARCHAR(255) NOT NULL,           -- BCrypt force 12
    role                VARCHAR(20)  NOT NULL DEFAULT 'USER'
                            CHECK (role IN ('USER', 'ADMIN', 'PARTNER')),
    subscription_tier   VARCHAR(20)  NOT NULL DEFAULT 'FREE'
                            CHECK (subscription_tier IN ('FREE', 'PRO', 'PACK')),
    locale              VARCHAR(10)  NOT NULL DEFAULT 'fr',
    timezone            VARCHAR(50)  NOT NULL DEFAULT 'Europe/Paris',
    stripe_customer_id  VARCHAR(100),
    is_active           BOOLEAN     NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN users.id                 IS 'UUID primary key generated by PostgreSQL';
COMMENT ON COLUMN users.email              IS 'Unique user email — used as login identifier';
COMMENT ON COLUMN users.password_hash      IS 'BCrypt hash, force 12 minimum — NEVER store plaintext';
COMMENT ON COLUMN users.role               IS 'USER=standard, ADMIN=back-office, PARTNER=API access';
COMMENT ON COLUMN users.subscription_tier  IS 'FREE=freemium limits, PRO=unlimited, PACK=single cert';
COMMENT ON COLUMN users.locale             IS 'BCP-47 language tag: fr, en, ar, etc.';
COMMENT ON COLUMN users.timezone           IS 'IANA timezone for local display of dates';
COMMENT ON COLUMN users.stripe_customer_id IS 'Stripe Customer ID — nullable for FREE users';

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_subscription ON users(subscription_tier);

-- ============================================================
-- TABLE : user_preferences
-- ============================================================
CREATE TABLE user_preferences (
    user_id                  UUID        PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    theme                    VARCHAR(10)  NOT NULL DEFAULT 'light'
                                 CHECK (theme IN ('light', 'dark', 'system')),
    language                 VARCHAR(10)  NOT NULL DEFAULT 'fr',
    default_mode             VARCHAR(20)  NOT NULL DEFAULT 'EXAM'
                                 CHECK (default_mode IN ('EXAM', 'FREE', 'REVISION')),
    notifications_enabled    BOOLEAN     NOT NULL DEFAULT TRUE,
    last_certification_id    VARCHAR(50),
    free_mode_question_count SMALLINT    NOT NULL DEFAULT 30,
    free_mode_duration_min   SMALLINT    NOT NULL DEFAULT 60,
    updated_at               TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN user_preferences.user_id                  IS 'FK → users.id, 1-to-1 relationship';
COMMENT ON COLUMN user_preferences.theme                    IS 'UI theme: light, dark, or follow system';
COMMENT ON COLUMN user_preferences.last_certification_id    IS 'Last selected certification ID for quick resume';
COMMENT ON COLUMN user_preferences.free_mode_question_count IS 'Default question count for free mode (migrated from PreferencesService)';

-- ============================================================
-- TABLE : certifications
-- ============================================================
CREATE TABLE certifications (
    id                   VARCHAR(50)   PRIMARY KEY,          -- Slug interne: "java21", "aws_ccp"
    code                 VARCHAR(30)   NOT NULL UNIQUE,       -- Code officiel: "1Z0-830", "CLF-C02"
    name                 VARCHAR(200)  NOT NULL,
    description          TEXT,
    total_questions      INT           NOT NULL DEFAULT 0,
    exam_question_count  INT           NOT NULL,
    exam_duration_min    INT           NOT NULL,
    passing_score        SMALLINT      NOT NULL
                             CHECK (passing_score BETWEEN 1 AND 100),
    exam_type            VARCHAR(20)   NOT NULL DEFAULT 'MCQ'
                             CHECK (exam_type IN ('MCQ', 'PRACTICAL', 'MIXED')),
    is_active            BOOLEAN       NOT NULL DEFAULT TRUE,
    created_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN certifications.id                  IS 'Internal slug used in JSON files and URLs: java21, aws_ccp';
COMMENT ON COLUMN certifications.code                IS 'Official exam code: 1Z0-830, CLF-C02, SAA-C03';
COMMENT ON COLUMN certifications.exam_question_count IS 'Number of questions drawn per exam session';
COMMENT ON COLUMN certifications.exam_duration_min   IS 'Official exam duration in minutes';
COMMENT ON COLUMN certifications.passing_score       IS 'Minimum percentage to pass (e.g., 68 for OCP)';
COMMENT ON COLUMN certifications.exam_type           IS 'MCQ=multiple choice, PRACTICAL=hands-on lab (CKA/CKAD), MIXED';

CREATE INDEX idx_certifications_active ON certifications(is_active);

-- ============================================================
-- TABLE : certification_themes
-- ============================================================
CREATE TABLE certification_themes (
    id               UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    certification_id VARCHAR(50)  NOT NULL REFERENCES certifications(id) ON DELETE CASCADE,
    code             VARCHAR(100) NOT NULL,   -- Slug normalisé du thème
    label            VARCHAR(200) NOT NULL,   -- Nom affiché (ex: "Lambda, Streams et API fonctionnelle")
    question_count   INT          NOT NULL DEFAULT 0,
    weight_percent   NUMERIC(5,2),            -- Pondération officielle si connue
    display_order    SMALLINT     NOT NULL DEFAULT 0,
    created_at       TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN certification_themes.code          IS 'URL-safe slug derived from label for API filtering';
COMMENT ON COLUMN certification_themes.label         IS 'Display name from config.json themes[].name';
COMMENT ON COLUMN certification_themes.question_count IS 'Count from config.json themes[].count';
COMMENT ON COLUMN certification_themes.weight_percent IS 'Official weighting percent — NULL if not published by vendor';

CREATE INDEX idx_themes_certification ON certification_themes(certification_id);
CREATE INDEX idx_themes_code ON certification_themes(certification_id, code);

-- ============================================================
-- TABLE : questions
-- ============================================================
CREATE TABLE questions (
    id                    UUID          PRIMARY KEY DEFAULT uuid_generate_v4(),
    legacy_id             VARCHAR(50)   UNIQUE,        -- ID original du JSON: "JAVA-001", "AWS-CCP-065"
    certification_id      VARCHAR(50)   NOT NULL REFERENCES certifications(id),
    theme_id              UUID          NOT NULL REFERENCES certification_themes(id),
    statement             TEXT          NOT NULL,       -- Énoncé de la question
    difficulty            VARCHAR(10)   NOT NULL DEFAULT 'medium'
                              CHECK (difficulty IN ('easy', 'medium', 'hard')),
    question_type         VARCHAR(20)   NOT NULL DEFAULT 'SINGLE_CHOICE'
                              CHECK (question_type IN ('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TRUE_FALSE')),
    -- Champs d'enrichissement IA (Phase Enrichissement)
    explanation_original  TEXT,                        -- Texte original importé depuis JavaFX
    explanation_enriched  TEXT,                        -- Version enrichie par IA ou manuellement
    explanation_status    VARCHAR(20)   NOT NULL DEFAULT 'ORIGINAL'
                              CHECK (explanation_status IN ('ORIGINAL', 'AI_DRAFT', 'HUMAN_VALIDATED')),
    explanation_version   SMALLINT      NOT NULL DEFAULT 1,
    official_doc_url      VARCHAR(500),                -- Lien documentation officielle
    code_example          TEXT,                        -- Bloc de code illustratif (optionnel)
    ai_confidence_score   NUMERIC(3,2)
                              CHECK (ai_confidence_score IS NULL OR
                                     ai_confidence_score BETWEEN 0.0 AND 1.0),
    last_reviewed_by      UUID          REFERENCES users(id),
    last_reviewed_at      TIMESTAMPTZ,
    is_active             BOOLEAN       NOT NULL DEFAULT TRUE,
    created_at            TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN questions.legacy_id            IS 'Original JSON ID preserved for traceability during migration';
COMMENT ON COLUMN questions.statement            IS 'Question text — may contain code blocks in Markdown';
COMMENT ON COLUMN questions.question_type        IS 'SINGLE_CHOICE=one correct answer, MULTIPLE_CHOICE=several correct';
COMMENT ON COLUMN questions.explanation_original IS 'Explanation imported from JavaFX corpus — immutable reference';
COMMENT ON COLUMN questions.explanation_enriched IS 'AI-generated or manually enriched explanation';
COMMENT ON COLUMN questions.explanation_status   IS 'ORIGINAL=not reviewed, AI_DRAFT=generated, HUMAN_VALIDATED=approved';
COMMENT ON COLUMN questions.ai_confidence_score  IS 'AI certainty score 0.0-1.0 to guide human review';
COMMENT ON COLUMN questions.official_doc_url     IS 'Link to official vendor documentation (Oracle, AWS, CNCF...)';

CREATE INDEX idx_questions_certification ON questions(certification_id);
CREATE INDEX idx_questions_theme ON questions(theme_id);
CREATE INDEX idx_questions_difficulty ON questions(difficulty);
CREATE INDEX idx_questions_status ON questions(explanation_status);
CREATE INDEX idx_questions_active ON questions(is_active);
CREATE INDEX idx_questions_legacy ON questions(legacy_id);

-- ============================================================
-- TABLE : question_options
-- ============================================================
CREATE TABLE question_options (
    id            UUID       PRIMARY KEY DEFAULT uuid_generate_v4(),
    question_id   UUID       NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    label         CHAR(1)    NOT NULL CHECK (label IN ('A','B','C','D','E')),
    text          TEXT       NOT NULL,
    is_correct    BOOLEAN    NOT NULL DEFAULT FALSE,
    display_order SMALLINT   NOT NULL DEFAULT 0
);

COMMENT ON COLUMN question_options.label         IS 'Display letter A/B/C/D/E';
COMMENT ON COLUMN question_options.is_correct    IS 'TRUE for correct answer(s) — multiple TRUE allowed for MULTIPLE_CHOICE';
COMMENT ON COLUMN question_options.display_order IS 'Original order from JSON options[] array (0-based → converted to A/B/C/D)';

CREATE INDEX idx_options_question ON question_options(question_id);
CREATE INDEX idx_options_correct ON question_options(question_id, is_correct);

-- ============================================================
-- TABLE : exam_sessions
-- ============================================================
CREATE TABLE exam_sessions (
    id               UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id          UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    certification_id VARCHAR(50)  NOT NULL REFERENCES certifications(id),
    mode             VARCHAR(20)  NOT NULL
                         CHECK (mode IN ('EXAM', 'FREE', 'REVISION')),
    started_at       TIMESTAMPTZ NOT NULL,
    ended_at         TIMESTAMPTZ,                        -- NULL si abandon ou en cours
    duration_seconds INT,                               -- Durée RÉELLE passée (ended_at - started_at)
    total_questions  SMALLINT    NOT NULL,
    correct_count    SMALLINT    NOT NULL DEFAULT 0,
    percentage       NUMERIC(5,2) NOT NULL DEFAULT 0.0
                         CHECK (percentage >= 0.0 AND percentage <= 100.0),
    passed           BOOLEAN     NOT NULL DEFAULT FALSE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN exam_sessions.duration_seconds IS 'Actual time spent = ended_at - started_at in seconds (NOT exam max duration)';
COMMENT ON COLUMN exam_sessions.correct_count    IS 'Number of correct answers — denormalized for query performance';
COMMENT ON COLUMN exam_sessions.percentage       IS 'correct_count*100/total_questions — denormalized with CHECK constraint';
COMMENT ON COLUMN exam_sessions.passed           IS 'TRUE if percentage >= certifications.passing_score';

CREATE INDEX idx_sessions_user ON exam_sessions(user_id);
CREATE INDEX idx_sessions_certification ON exam_sessions(certification_id);
CREATE INDEX idx_sessions_user_cert ON exam_sessions(user_id, certification_id);
CREATE INDEX idx_sessions_started ON exam_sessions(started_at DESC);
CREATE INDEX idx_sessions_mode ON exam_sessions(mode);

-- ============================================================
-- TABLE : user_answers
-- ============================================================
CREATE TABLE user_answers (
    id              UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id      UUID        NOT NULL REFERENCES exam_sessions(id) ON DELETE CASCADE,
    question_id     UUID        NOT NULL REFERENCES questions(id),
    selected_option UUID        REFERENCES question_options(id),  -- NULL si non répondue
    is_correct      BOOLEAN     NOT NULL DEFAULT FALSE,
    is_skipped      BOOLEAN     NOT NULL DEFAULT FALSE,           -- TRUE si selected_option IS NULL
    response_time_ms INT,                                         -- Durée de réponse en ms
    answered_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN user_answers.selected_option  IS 'NULL means question was skipped (replaces selected_answer = -1)';
COMMENT ON COLUMN user_answers.is_skipped       IS 'Explicit flag for skipped questions, more readable than NULL check';
COMMENT ON COLUMN user_answers.response_time_ms IS 'Time from question display to answer selection in milliseconds';

CREATE INDEX idx_answers_session ON user_answers(session_id);
CREATE INDEX idx_answers_question ON user_answers(question_id);
CREATE INDEX idx_answers_session_question ON user_answers(session_id, question_id);
```

---

## 3. CATALOGUE CERTIFICATIONS DÉTAILLÉ

### 3.1 Certifications disponibles dans le corpus

| ID interne | Nom complet | Code officiel | Total questions | Durée (min) | Score passage (%) | Nb thèmes |
|---|---|---|---|---|---|---|
| `java21` | Java 21 Developer Certification | 1Z0-830 | 500 | 180 | 68 | 10 |
| `ocp21` | Oracle Certified Professional Java SE 21 | 1Z0-830 | 500 | 180 | 68 | 9 |
| `ocp17` | Oracle Certified Professional Java SE 17 | 1Z0-829 | 450 | 180 | 68 | 8 |
| `springboot3` | Spring Boot 3 Professional | N/A (VMware) | 300 | 90 | 70 | 6 |
| `spring6` | Spring Professional 6 | N/A (VMware) | 350 | 120 | 70 | 6 |
| `docker` | Docker Certified Associate (DCA) | DCA | 350 | 90 | 75 | 6 |
| `cka` | Certified Kubernetes Administrator | CKA | 300 | 120 | 66 | 7 |
| `ckad` | Certified Kubernetes Application Developer | CKAD | 250 | 120 | 66 | 5 |
| `cks` | Certified Kubernetes Security Specialist | CKS | 200 | 120 | 67 | 6 |
| `aws_ccp` | AWS Cloud Practitioner | CLF-C02 | ~300 | 90 | 70 | ~5 |
| `aws_saa` | AWS Solutions Architect Associate | SAA-C03 | 500 | 130 | 72 | 8 |
| `aws_dev` | AWS Developer Associate | DVA-C02 | 400 | 130 | 70 | 6 |
| `android` | Android Kotlin/Compose Developer | N/A | ~300 | N/A | N/A | ~5 |
| `terraform` | HashiCorp Terraform Associate | 003 | 300 | 60 | 70 | 6 |
| `gcp_dl` | Google Cloud Digital Leader | N/A | 250 | 90 | 70 | 4 |

**Total corpus :** ~4 850 questions sur 15 certifications confirmées.

### 3.2 Détail des thèmes par certification

**`java21` — Java 21 Developer (1Z0-830) — 500 questions, 80 questions examen**

| Thème | Questions |
|---|---|
| Fondamentaux du Langage | 50 |
| Types de données et Wrappers | 50 |
| POO - Classes, Héritage, Polymorphisme | 60 |
| Collections et Génériques | 60 |
| Exceptions et Gestion d'erreurs | 50 |
| Flux I/O et NIO | 40 |
| Multithreading et Concurrence | 50 |
| Lambda, Streams et API fonctionnelle | 60 |
| Modules JPMS | 30 |
| Nouveautés Java 17-21 | 50 |

**`ocp21` — OCP Java SE 21 (1Z0-830) — 500 questions, 80 questions examen**

| Thème | Questions |
|---|---|
| Virtual Threads | 60 |
| Pattern Matching avancé | 70 |
| Records et Sealed Classes | 60 |
| Foreign Function & Memory API | 50 |
| Vector API | 50 |
| Structured Concurrency | 60 |
| Scoped Values | 50 |
| Sequenced Collections | 50 |
| String Templates | 50 |

**`aws_saa` — AWS Solutions Architect Associate (SAA-C03) — 500 questions, 65 examen**

| Thème | Questions |
|---|---|
| Compute (EC2, Lambda, ECS) | 80 |
| Storage (S3, EBS, EFS) | 70 |
| Database (RDS, DynamoDB) | 60 |
| Networking (VPC, Route53) | 80 |
| Security & IAM | 70 |
| High Availability & Scalability | 60 |
| Monitoring & Logging | 40 |
| Pricing & Support | 40 |

*(Autres certifications disponibles dans les fichiers `config.json` respectifs)*

---

## 4. LOGIQUE MÉTIER CRITIQUE

### 4.1 Algorithme de sélection des questions (`QuestionLoader`)

#### Chargement initial

1. `scanAvailableCertifications()` — scan du répertoire `/certifications/` à l'initialisation du Singleton
2. Pour chaque certification trouvée : chargement `config.json` → objet `Certification`
3. Scan dynamique du dossier `/certifications/{certId}/questions/*.json` → liste `List<Question>`
4. Mise en cache en mémoire : `Map<String, List<Question>> certificationQuestions`

#### Mode Examen (`getRandomQuestions`)

```java
// Algorithme exact extrait de QuestionLoader.getRandomQuestions()
List<Question> shuffled = new ArrayList<>(allQuestions);
Collections.shuffle(shuffled);           // java.util.Collections.shuffle() — seed aléatoire système
List<Question> selected = shuffled.subList(0, count);
```

**⚠️ Pas de pondération par thème en mode Examen** — tirage global sans contrainte de répartition. Les pondérations `config.json` sont indicatives du corpus, pas appliquées au tirage.

#### Mode Libre (`getRandomQuestionsByThemes`)

Répartition **proportionnelle** basée sur la disponibilité réelle par thème :

```
count_thème = round(disponible_thème / total_disponible * nb_questions_demandées)
```

Avec distribution du reste entier sur les thèmes triés par ordre d'itération.

#### Mode Révision

Simple `Collections.shuffle()` sur les questions du thème sélectionné (ou tous les thèmes).

#### Gestion des doublons

**Aucune gestion des doublons entre sessions** — un même tirage aléatoire peut répéter des questions d'une session à l'autre. À implémenter dans la phase de migration via l'algorithme de répétition espacée (SM-2).

### 4.2 Formule de scoring (`ScoringService`)

#### Calcul principal

```
percentage = (correctCount * 100.0) / totalQuestions

passed = (percentage >= certification.passingScore)
```

**Points critiques :**

- `correctCount` : comparaison `answer.getSelectedAnswer() == question.getCorrect()` → comparaison d'**index entiers**
- Questions non répondues (`selectedAnswer == -1`) : **comptées comme incorrectes** (ni pénalité additionnelle, ni exclusion du calcul)
- **Pas de QCM à choix multiples** dans le code actuel — toujours une seule réponse correcte
- **Pas de pénalité** pour mauvaise réponse (scoring positif uniquement)
- `session.setScore(correctCount)` stocke le nombre brut de bonnes réponses

#### Score par thème (`calculateThemeStats`)

```
thème_percentage = (correct / total) * 100
```

Avec catégorisation : `correct`, `wrong` (répondu mais faux), `skipped` (`selectedAnswer == -1`).

#### Calcul `PASSED` dans `ExamController.createSession()` — anomalie détectée

```java
// ExamController.java — ligne divergente vs ScoringService
session.setPassed(correctCount >= certification.getPassingQuestionsCount());
```

```java
// Certification.java
public int getPassingQuestionsCount() {
    return (int) Math.ceil(examQuestionCount * passingScore / 100.0);
}
```

**Incohérence :** `ExamController` utilise `getPassingQuestionsCount()` (seuil en nombre de questions, avec `Math.ceil`), tandis que `ScoringService` utilise `percentage >= passingScore` (seuil en pourcentage). Les deux formules peuvent diverger d'1 question sur les bords. **La formule `ScoringService` est la référence à conserver.**

#### Analyse par difficulté (`getDifficultyAnalysis`)

```
difficulty_percentage = (correct_for_difficulty / total_for_difficulty) * 100
```

Questions non répondues exclues du calcul de difficulté.

### 4.3 Gestion du timer (`ExamController`)

#### Mécanisme

- **`javafx.animation.Timeline`** avec `KeyFrame(Duration.seconds(1), ...)` — tick toutes les secondes
- `remainingSeconds` décompté depuis `totalSeconds = certification.getExamDurationMinutes() * 60L`
- Affichage HH:MM:SS avec changement de couleur rouge à < 5 minutes (300 secondes)

#### Comportement à expiration

```java
if (remainingSeconds <= 0) {
    timer.stop();
    submitExam();   // Soumission AUTOMATIQUE sans confirmation utilisateur
}
```

**Soumission automatique** à expiration, sans dialogue de confirmation (contrairement à la soumission manuelle qui affiche un dialog si des questions non répondues).

#### Pause

- `isPaused` booléen protège le décrément dans le `KeyFrame`
- **Pause possible** via le bouton `pauseBtn` — comportement à **interdire en mode Examen officiel** dans la migration

#### Persistance durée réelle

```java
// ExamController.createSession()
long timeSpent = totalSeconds - remainingSeconds;    // Temps consommé
session.setDurationMinutes((int)(timeSpent / 60));   // Stocké en minutes
session.setEndTime(LocalDateTime.now());             // Pour getDurationSeconds()
```

**Dans la migration PostgreSQL** : stocker `duration_seconds` = `totalSeconds - remainingSeconds` directement pour éviter la perte de précision de la division par 60.

#### Mode sans timer (Mode Libre, durée illimitée)

```java
if (durationMinutes == 0) {
    totalSeconds = 0;
    remainingSeconds = 0;
    timerLabel.setText("Illimité");
    // startTimer() n'est PAS appelé
}
```

### 4.4 Modes d'examen

| Critère | EXAM | FREE | REVISION |
|---|---|---|---|
| Sélection questions | `getRandomQuestions(certId, examQuestionCount)` | `getRandomQuestionsByThemes(certId, themeCounts)` | `getRandomQuestions` ou `getQuestionsByTheme` |
| Thèmes configurables | ❌ tous thèmes | ✅ sélection par checkboxes | ✅ ComboBox thème unique ou tous |
| Nombre questions | Fixé par `examQuestionCount` | Slider 1→`totalQuestions` | Slider configurable |
| Timer | Obligatoire (`examDurationMinutes`) | Optionnel (0 = illimité) | ❌ pas de timer |
| Correction immédiate | ❌ après soumission | ❌ après soumission | ✅ bouton "Voir la réponse" |
| Navigation questions | ✅ prev/next + palette | ✅ prev/next + palette | ✅ prev/next + bouton aléatoire |
| Marquage révision | ✅ bouton "Marquer" | ✅ bouton "Marquer" | N/A |
| Sauvegarde session | ✅ `databaseService.saveSession()` | ✅ `databaseService.saveSession()` | ✅ `databaseService.saveSession()` |
| Mode `ExamSession.ExamMode` | `EXAM` | `FREE` | `REVISION` |
| Pause timer | ✅ bouton pause | ✅ si timer activé | N/A |

---

## 5. FORMAT D'IMPORT/EXPORT DES QUESTIONS

### 5.1 Format d'import (détecté dans `ImportQuestionsController`)

**Format :** JSON Array, identique au format interne des fichiers de questions

```json
[
  {
    "id": "CUSTOM-001",
    "theme": "Nom du thème",
    "theme_label": "Sous-thème précis",
    "difficulty": "easy|medium|hard",
    "question": "Énoncé de la question",
    "options": ["Option A", "Option B", "Option C", "Option D"],
    "correct": 0,
    "explanation": "Explication de la réponse correcte"
  }
]
```

### 5.2 Processus d'import

1. Sélection fichier via `FileChooser` (filtre `.json`)
2. Désérialisation `ObjectMapper.readValue(file, List<Question>.class)`
3. Aperçu dans `TextArea` avant validation
4. Fusion dans un fichier JSON cible existant (liste déroulante `targetFileCombo`)
5. Réécriture du fichier JSON avec `ObjectMapper.writeValue()`
6. Rechargement via `questionLoader.reloadCertification(certId)`

**Validations appliquées à l'import :**
- Désérialisation Jackson (format JSON valide)
- Aucune validation métier explicite (id unique non vérifié, difficulty non validée)

### 5.3 Export de données (`SettingsController`)

L'export de données exporte la **base SQLite** (`data/certiprep.db`) en copie binaire — **pas les questions JSON**. Les questions restent dans les fichiers resources.

### 5.4 Export historique CSV (`HistoryController`)

```
sessionId, certificationId, date, mode, score, total, percentage, passed, duration
```

Format CSV via `PrintWriter`, séparateur virgule.

### 5.5 Compatibilité migration

Pour maintenir la compatibilité à l'import dans `CertifApp` :
- Conserver le format JSON array avec les mêmes noms de champs
- Normaliser `explication` → `explanation` dans le JSON importé
- Endpoint `POST /admin/questions/import` doit accepter ce format exact

---

## 6. DETTE TECHNIQUE ET DÉCISIONS DE MIGRATION

### 6.1 Code JavaFX pur — à réécrire intégralement

| Élément JavaFX | Remplacement dans la stack cible |
|---|---|
| `javafx.animation.Timeline` (timer) | `rxjs/timer` côté Angular + WebSocket pour synchronisation serveur |
| `FXMLLoader` + fichiers `.fxml` | Composants Angular 18 standalone |
| `javafx.scene.control.*` (TableView, ListView, RadioButton, Slider, Spinner, ComboBox) | Composants Angular Material ou primitives HTML |
| `javafx.stage.Stage` / `Scene` | Routing Angular |
| `ToggleGroup` (sélection exclusive) | `FormControl` Angular avec validation |
| `javafx.stage.FileChooser` | Input `type="file"` HTML + `File API` browser |
| `FlowPane` (palette questions) | CSS Grid/Flexbox Angular |
| `Platform.runLater()` | `zone.run()` Angular ou `ChangeDetectorRef.detectChanges()` |
| `javafx.scene.image.Image` | `<img>` HTML avec assets servis par Spring Boot |
| `Hyperlink` JavaFX | `<a>` HTML |

### 6.2 Logique métier pure — migration vers `certif-domain`

| Code source | Migration | Transformation minimale |
|---|---|---|
| `Question.java` | → `record Question(...)` Java 21 | Supprimer getters/setters → Record, conserver `getCorrectAnswer()` |
| `Certification.java` + `ThemeInfo` | → `record Certification(...)` + `record ThemeInfo(...)` | Conserver `getPassingQuestionsCount()` |
| `ExamSession.java` + `ExamMode` | → `record ExamSession(...)` avec enum | Conserver `getPercentage()`, `getDurationSeconds()`, `getCorrectCount()` |
| `UserAnswer.java` | → `record UserAnswer(...)` | Remplacer `selectedAnswer=-1` par `Optional<UUID>` |
| `ScoringService.java` (logique pure) | → `ScoringService.java` dans `certif-domain` | Supprimer pattern Singleton → injection Spring dans `certif-application` |
| `ThemeStats` (classe interne) | → `record ThemeStats(...)` dans `certif-domain` | Extraire en fichier séparé |

### 6.3 Anomalies et incohérences détectées

| # | Anomalie | Localisation | Impact | Script de correction |
|---|---|---|---|---|
| 1 | Champ `explication` au lieu de `explanation` | Questions AWS CCP, AWS DEV, Terraform, et autres certifications AWS | **Élevé** — `Question.getExplanation()` retourne `null` pour ces questions | Script de normalisation JSON (voir §7.4) |
| 2 | `ExamController.createSession()` utilise `getPassingQuestionsCount()` vs `ScoringService` utilise `percentage >= passingScore` | `ExamController.java` | **Moyen** — divergence possible d'1 question sur les bords | Uniformiser sur `percentage >= passingScore` |
| 3 | `duration_minutes` dans SQLite stocke tantôt la config MAX, tantôt le temps réel passé | `DatabaseService.java` + `ExamController.java` | **Moyen** — ambiguïté à la lecture de l'historique | Créer deux colonnes distinctes : `exam_duration_min` (config) + `duration_seconds` (réel) |
| 4 | Aucune validation à l'import de questions (doublons, format) | `ImportQuestionsController.java` | **Faible** — peut créer des questions dupliquées | Validation UUID unicité + JSON Schema dans l'endpoint REST |
| 5 | `messages_en.properties` : clés `duration` et `theme` en double commentées avec `#` | `messages_en.properties` | **Faible** — clés inutilisables | Dédupliquer les clés |
| 6 | `java21` et `ocp21` couvrent tous deux la certification `1Z0-830` | `config.json` des deux certifications | **Moyen** — doublon de contenu | Fusionner ou marquer `ocp21` comme alias de `java21` |

### 6.4 Dépendances tierces actuelles vs cibles

| Lib actuelle | Version | Rôle | Lib cible | Justification |
|---|---|---|---|---|
| `javafx-controls` | 21 | UI desktop | **Supprimée** | Remplacée par Angular 18 + Kotlin/Compose |
| `javafx-fxml` | 21 | Templates UI | **Supprimée** | FXML → composants Angular |
| `jackson-databind` | 2.16.1 | Sérialisation JSON | `jackson-databind` (conservé) | Spring Boot 3 l'inclut via `spring-boot-starter-web` |
| `sqlite-jdbc` | 3.44.1.0 | Base de données locale | `postgresql` driver | Migration SQLite → PostgreSQL/Supabase |
| `itext7-core` | 7.2.5 | Export PDF | `itext7-core` (conservé) | Réutilisation directe de `PdfExportService` dans `certif-infrastructure` |
| `java.util.logging` | JDK | Logging | `slf4j` + `logback` | Standard Spring Boot, meilleur écosystème |
| `java.util.prefs.Preferences` | JDK | Préférences OS | PostgreSQL `user_preferences` | Stockage serveur pour synchronisation multi-device |

---

## 7. PLAN DE MIGRATION PRIORISÉ

### 7.1 Ordre de création des entités domain (`certif-domain`)

| Ordre | Entité | Record Java 21 (champs principaux) | Justification |
|---|---|---|---|
| 1 | `DifficultyLevel` (enum) | `EASY, MEDIUM, HARD` | Aucune dépendance, utilisé partout |
| 2 | `ExamMode` (enum) | `EXAM, FREE, REVISION` | Aucune dépendance |
| 3 | `ExplanationStatus` (enum) | `ORIGINAL, AI_DRAFT, HUMAN_VALIDATED` | Aucune dépendance |
| 4 | `QuestionType` (enum) | `SINGLE_CHOICE, MULTIPLE_CHOICE, TRUE_FALSE` | Aucune dépendance |
| 5 | `ThemeInfo` | `(String name, int questionCount)` | Composant de `Certification` |
| 6 | `Certification` | `(String id, String code, String name, int examQuestionCount, int examDurationMin, int passingScore, List<ThemeInfo> themes)` | Dépend de `ThemeInfo` |
| 7 | `QuestionOption` | `(UUID id, char label, String text, boolean correct, int displayOrder)` | Composant de `Question` |
| 8 | `Question` | `(UUID id, String legacyId, String certificationId, String themeCode, String statement, DifficultyLevel difficulty, QuestionType type, List<QuestionOption> options, String explanationOriginal)` | Dépend de `QuestionOption`, `DifficultyLevel`, `QuestionType` |
| 9 | `UserAnswer` | `(UUID questionId, UUID selectedOptionId, boolean correct, boolean skipped, long responseTimeMs)` | Dépend de `Question` |
| 10 | `ThemeStats` | `(String theme, int correct, int wrong, int skipped, int total)` | Dépend de `UserAnswer` |
| 11 | `ExamSession` | `(UUID id, String certificationId, ExamMode mode, LocalDateTime startedAt, LocalDateTime endedAt, int totalQuestions, int correctCount, double percentage, boolean passed, List<UserAnswer> answers)` | Dépend de `UserAnswer`, `ExamMode` |

### 7.2 Ordre des use cases (`certif-application`) — priorisés par valeur business

**Priorité 1 — MVP bloquant**

| # | Use Case | Description |
|---|---|---|
| 1.1 | `ListCertificationsUseCase` | Lister les certifications actives — première page de l'app |
| 1.2 | `GetCertificationDetailsUseCase` | Détail d'une certification (thèmes, stats) |
| 1.3 | `StartExamSessionUseCase` | Démarrer un examen (mode EXAM) — sélection questions, création session |
| 1.4 | `SubmitAnswerUseCase` | Enregistrer une réponse en temps réel |
| 1.5 | `SubmitExamUseCase` | Finaliser l'examen, calculer le score, sauvegarder |
| 1.6 | `GetExamResultsUseCase` | Récupérer les résultats d'une session terminée |
| 1.7 | `RegisterUserUseCase` | Créer un compte utilisateur |
| 1.8 | `AuthenticateUserUseCase` | Login JWT |

**Priorité 2 — important**

| # | Use Case | Description |
|---|---|---|
| 2.1 | `StartFreeModeExamUseCase` | Examen avec sélection thèmes/durée |
| 2.2 | `StartRevisionSessionUseCase` | Mode révision avec correction immédiate |
| 2.3 | `GetSessionHistoryUseCase` | Historique avec filtres |
| 2.4 | `ExportSessionPdfUseCase` | Export PDF résultats |
| 2.5 | `GetUserProgressUseCase` | Stats de progression par certification/thème |
| 2.6 | `UpdateUserPreferencesUseCase` | Thème, langue, préférences |

**Priorité 3 — enrichissement**

| # | Use Case | Description |
|---|---|---|
| 3.1 | `ImportQuestionsUseCase` | Import admin de questions JSON |
| 3.2 | `EnrichQuestionWithAiUseCase` | Enrichissement IA via LangChain4j |
| 3.3 | `GenerateAdaptiveExamUseCase` | Parcours adaptatif SM-2 |
| 3.4 | `ProcessStripeWebhookUseCase` | Gestion abonnements |
| 3.5 | `ExportUserDataUseCase` | RGPD Art. 20 — portabilité |

### 7.3 Estimation de charge par module Maven

| Module | Nb classes estimé | Complexité | Durée estimée | Développeur recommandé |
|---|---|---|---|---|
| `certif-domain` | ~15 classes (Records + enums + exceptions) | **Faible** | 2–3 jours | Dev Java senior |
| `certif-application` | ~25 classes (16 use cases + ports + DTOs) | **Moyenne** | 5–7 jours | Dev Java senior |
| `certif-infrastructure` | ~30 classes (repositories JPA, Flyway scripts, adapters, PdfService) | **Moyenne-Élevée** | 7–10 jours | Dev Java + DBA |
| `certif-api-rest` | ~25 classes (8 controllers REST, DTOs, sécurité JWT, config Swagger) | **Élevée** | 7–10 jours | Dev Java Spring Boot |
| `certif-ai` | ~15 classes (LangChain4j, ModelRouter, 3 services IA) | **Élevée** | 10–15 jours | Dev Java + expertise LLM |
| Frontend Angular | ~20 composants + services + routing | **Élevée** | 15–20 jours | Dev Angular senior |
| Android Kotlin | ~15 écrans Compose + ViewModel + Hilt | **Élevée** | 15–20 jours | Dev Android Kotlin |

**Durée totale estimée MVP (Phase 2 → Phase 5) : 10–14 semaines avec 2–3 développeurs en parallèle**

### 7.4 Stratégie de migration SQLite → PostgreSQL

#### Étape 1 — Normalisation du corpus JSON (à exécuter AVANT le seed)

```bash
# Script shell de normalisation "explication" → "explanation"
# À exécuter sur le repo source CertiPrepEngine

find src/main/resources/certifications -name "*.json" | \
  xargs sed -i 's/"explication":/"explanation":/g'

# Vérification post-normalisation (doit retourner 0 lignes)
grep -r '"explication"' src/main/resources/certifications/ | wc -l
```

#### Étape 2 — Script Python de conversion JSON → SQL (seed Flyway)

```python
# certif-infrastructure/src/main/resources/scripts/migrate_questions.py
# Convertit les fichiers JSON du corpus en V2__seed_questions.sql

import json, os, uuid
from pathlib import Path

CERT_DIR = "src/main/resources/certifications"
OUTPUT_SQL = "certif-infrastructure/src/main/resources/db/migration/V2__seed_questions.sql"

options_labels = ['A', 'B', 'C', 'D', 'E']

with open(OUTPUT_SQL, 'w', encoding='utf-8') as out:
    out.write("-- Auto-generated migration: JSON corpus → PostgreSQL\n\n")

    for cert_dir in sorted(Path(CERT_DIR).iterdir()):
        config_file = cert_dir / "config.json"
        if not config_file.exists():
            continue

        config = json.loads(config_file.read_text(encoding='utf-8'))
        cert_id = config['id']

        # INSERT certification
        out.write(f"""
INSERT INTO certifications (id, code, name, description, total_questions,
  exam_question_count, exam_duration_min, passing_score)
VALUES ('{cert_id}', '{cert_id.upper()}', 
  '{config['name'].replace("'", "''")}',
  '{config.get('description','').replace("'", "''")}',
  {config['totalQuestions']}, {config['examQuestionCount']},
  {config['examDurationMinutes']}, {config['passingScore']})
ON CONFLICT (id) DO NOTHING;\n""")

        # INSERT themes
        for i, theme in enumerate(config.get('themes', [])):
            theme_id = str(uuid.uuid4())
            theme_code = theme['name'].lower().replace(' ', '_')[:100]
            out.write(f"""
INSERT INTO certification_themes (id, certification_id, code, label, 
  question_count, display_order)
VALUES ('{theme_id}', '{cert_id}', 
  '{theme_code}', '{theme['name'].replace("'", "''")}',
  {theme['count']}, {i})
ON CONFLICT DO NOTHING;\n""")

        # INSERT questions
        questions_dir = cert_dir / "questions"
        if not questions_dir.exists():
            continue

        for json_file in sorted(questions_dir.glob("*.json")):
            questions = json.loads(json_file.read_text(encoding='utf-8'))
            for q in questions:
                q_id = str(uuid.uuid4())
                legacy_id = q.get('id', '')
                explanation = q.get('explanation') or q.get('explication', '')
                statement = q.get('question', '').replace("'", "''")
                difficulty = q.get('difficulty', 'medium')

                out.write(f"""
INSERT INTO questions (id, legacy_id, certification_id, theme_id,
  statement, difficulty, explanation_original)
SELECT '{q_id}', '{legacy_id}',
  '{cert_id}',
  (SELECT id FROM certification_themes 
   WHERE certification_id='{cert_id}' 
   AND label='{q.get('theme','').replace("'","''")}' LIMIT 1),
  '{statement}', '{difficulty}',
  '{explanation.replace("'", "''")}'
WHERE NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='{legacy_id}');\n""")

                # INSERT options
                for i, opt_text in enumerate(q.get('options', [])):
                    is_correct = (i == q.get('correct', -1))
                    out.write(f"""
INSERT INTO question_options (id, question_id, label, text, is_correct, display_order)
SELECT '{str(uuid.uuid4())}',
  (SELECT id FROM questions WHERE legacy_id='{legacy_id}' LIMIT 1),
  '{options_labels[i]}', '{opt_text.replace("'", "''")}',
  {'TRUE' if is_correct else 'FALSE'}, {i}
WHERE EXISTS (SELECT 1 FROM questions WHERE legacy_id='{legacy_id}');\n""")

print(f"Migration SQL générée : {OUTPUT_SQL}")
```

#### Étape 3 — Migration des sessions SQLite existantes

```python
# certif-infrastructure/src/main/resources/scripts/migrate_sessions.py
# Lit certiprep.db SQLite et génère V3__migrate_sessions.sql

import sqlite3, uuid, json

conn = sqlite3.connect('data/certiprep.db')
conn.row_factory = sqlite3.Row

with open('V3__migrate_sessions.sql', 'w') as out:
    # Créer un user "legacy" pour les sessions existantes
    legacy_user_id = str(uuid.uuid4())
    out.write(f"""
INSERT INTO users (id, email, password_hash, role, subscription_tier)
VALUES ('{legacy_user_id}', 'legacy@certiprep.local', 
  '$2b$12$PLACEHOLDER_HASH', 'USER', 'FREE')
ON CONFLICT DO NOTHING;\n""")

    for row in conn.execute("SELECT * FROM exam_sessions"):
        session_id = str(uuid.uuid4())
        out.write(f"""
INSERT INTO exam_sessions (id, user_id, certification_id, mode,
  started_at, ended_at, total_questions, correct_count, percentage, passed)
VALUES ('{session_id}', '{legacy_user_id}', '{row['certification_id']}',
  '{row['mode']}', '{row['start_time']}', 
  {f"'{row['end_time']}'" if row['end_time'] else 'NULL'},
  {row['total_questions']}, {row['score']},
  {row['percentage'] or 0.0}, {1 if row['passed'] else 0});\n""")

        for ans in conn.execute(
            "SELECT * FROM user_answers WHERE session_id=?", (row['session_id'],)):
            out.write(f"""
INSERT INTO user_answers (id, session_id, question_id, 
  selected_option, is_correct, is_skipped, response_time_ms)
SELECT '{str(uuid.uuid4())}', '{session_id}',
  (SELECT id FROM questions WHERE legacy_id='{ans['question_id']}' LIMIT 1),
  CASE WHEN {ans['selected_answer']} >= 0 THEN
    (SELECT id FROM question_options 
     WHERE question_id=(SELECT id FROM questions 
       WHERE legacy_id='{ans['question_id']}' LIMIT 1)
     AND display_order={ans['selected_answer']} LIMIT 1)
  ELSE NULL END,
  {1 if ans['is_correct'] else 0},
  {1 if ans['selected_answer'] == -1 else 0},
  {ans['response_time_ms'] or 0}
WHERE EXISTS (SELECT 1 FROM questions WHERE legacy_id='{ans['question_id']}');\n""")
```

#### Étape 4 — Validation post-migration

```sql
-- Comptages de validation
SELECT 'certifications' as table_name, COUNT(*) as count FROM certifications
UNION ALL SELECT 'certification_themes', COUNT(*) FROM certification_themes
UNION ALL SELECT 'questions', COUNT(*) FROM questions
UNION ALL SELECT 'question_options', COUNT(*) FROM question_options
UNION ALL SELECT 'exam_sessions', COUNT(*) FROM exam_sessions
UNION ALL SELECT 'user_answers', COUNT(*) FROM user_answers;

-- Vérification intégrité : questions sans options
SELECT q.legacy_id FROM questions q
LEFT JOIN question_options o ON o.question_id = q.id
WHERE o.id IS NULL;

-- Vérification : questions sans réponse correcte
SELECT q.legacy_id FROM questions q
WHERE NOT EXISTS (
  SELECT 1 FROM question_options o 
  WHERE o.question_id = q.id AND o.is_correct = TRUE
);

-- Vérification : certifications avec questions manquantes vs config
SELECT c.id, c.total_questions as expected, 
       COUNT(q.id) as actual,
       c.total_questions - COUNT(q.id) as missing
FROM certifications c
LEFT JOIN questions q ON q.certification_id = c.id
GROUP BY c.id, c.total_questions
HAVING COUNT(q.id) < c.total_questions;
```

### 7.5 Top 5 des risques de migration

| # | Risque | Probabilité | Impact | Mitigation |
|---|---|---|---|---|
| 1 | **Perte de données corpus** — erreur dans les scripts de migration JSON→SQL (encoding UTF-8, apostrophes, caractères spéciaux dans les énoncés) | **Moyen** | **Critique** | Validation post-migration avec comptage strict + test round-trip (migrer puis réexporter et comparer) |
| 2 | **Doublon certifications `java21` / `ocp21`** — deux config.json pour le même code d'examen 1Z0-830 crée confusion dans le catalogue | **Élevé** | **Moyen** | Décision produit avant la Phase 2 : conserver un seul ID ou créer un mécanisme d'alias |
| 3 | **Incohérence `explication`/`explanation`** — questions AWS/Terraform avec explication nulle côté API si non normalisée avant migration | **Élevé** | **Élevé** | Exécuter le script de normalisation bash + validation zéro occurrence avant seed |
| 4 | **Couplage fort logique/UI dans ExamController** — toute la logique de création de session (`createSession()`, calcul `durationMinutes`, `setScore`) est dans le controller JavaFX, risque d'oubli lors de la réécriture | **Moyen** | **Moyen** | Documenter précisément les 3 chemins de soumission (manuelle, timer expiré, abandon) et écrire les tests unitaires du use case avant le code |
| 5 | **Pas de gestion des concurrent sessions** — un utilisateur multi-device pourrait démarrer plusieurs sessions simultanées, non géré dans le code JavaFX mono-instance | **Faible** | **Moyen** | Ajouter contrainte de session active unique par user+certification dans `StartExamSessionUseCase` |

---

## 8. RÉSUMÉ EXÉCUTIF

CertiPrep Engine est un projet **JavaFX de bonne facture technique** pour une application desktop mono-utilisateur. L'architecture est claire avec une séparation `ui` / `core.model` / `core.service` / `core.utils`, et la logique métier (scoring, sélection de questions) est déjà isolée dans des services sans dépendance framework.

**Complexité globale de la migration : 4/5**

**Points forts à capitaliser :** (1) Corpus de 4 850+ questions structurées en JSON réutilisables directement comme seed Flyway. (2) `ScoringService` et les entités domain migrables quasi tel quel en Records Java 21. (3) L'architecture Singleton des services préfigure déjà les beans Spring. (4) L'internationalisation FR/EN est complète et transférable.

**Points d'attention critiques :** (1) Normaliser impérativement `explication` → `explanation` avant tout seed. (2) Trancher le doublon `java21`/`ocp21` avant la Phase 2. (3) Réécrire complètement la gestion du timer (côté serveur ou WebSocket Angular). (4) Modéliser correctement `duration_seconds` (réel) vs `exam_duration_min` (config) qui sont confondus dans SQLite.

**Recommandation Phase 2 :** Démarrer par `certif-domain` (Records + ScoringService) + scripts Flyway de migration des données, en parallèle avec la configuration de base Spring Boot 3 + Supabase PostgreSQL. Ces deux flux sont indépendants et peuvent être répartis entre deux développeurs dès J+1.

---

> PHASE 1 COMPLÈTE — En attente de validation pour démarrer la Phase 2
