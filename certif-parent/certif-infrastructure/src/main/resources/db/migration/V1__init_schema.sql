-- =============================================================================
-- certif-infrastructure/src/main/resources/db/migration/V1__init_schema.sql
-- CertifApp — Schéma PostgreSQL complet
-- Version : 1.0.0  |  Flyway V1
-- =============================================================================

-- Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm"; -- Recherche full-text trigram

-- =============================================================================
-- MODULE USERS
-- =============================================================================

CREATE TABLE users (
    id                  UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    email               VARCHAR(255) NOT NULL UNIQUE,
    password_hash       VARCHAR(255) NOT NULL,
    role                VARCHAR(20)  NOT NULL DEFAULT 'USER'
                            CHECK (role IN ('USER', 'ADMIN', 'PARTNER')),
    subscription_tier   VARCHAR(20)  NOT NULL DEFAULT 'FREE'
                            CHECK (subscription_tier IN ('FREE', 'PRO', 'PACK')),
    locale              VARCHAR(10)  NOT NULL DEFAULT 'fr',
    timezone            VARCHAR(50)  NOT NULL DEFAULT 'Europe/Paris',
    stripe_customer_id  VARCHAR(100),
    is_active           BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE  users                          IS 'Comptes utilisateurs CertifApp';
COMMENT ON COLUMN users.password_hash            IS 'BCrypt hash force 12 minimum — plaintext INTERDIT';
COMMENT ON COLUMN users.role                     IS 'USER=standard, ADMIN=back-office, PARTNER=accès API';
COMMENT ON COLUMN users.subscription_tier        IS 'FREE=freemium, PRO=illimité, PACK=certification unique';
COMMENT ON COLUMN users.locale                   IS 'BCP-47 : fr, en, ar — pour i18n emails et UI';
COMMENT ON COLUMN users.timezone                 IS 'IANA timezone : Europe/Paris, Africa/Casablanca, America/Montreal';
COMMENT ON COLUMN users.stripe_customer_id       IS 'ID Stripe — NULL pour les utilisateurs FREE sans CB';

CREATE INDEX idx_users_email        ON users(email);
CREATE INDEX idx_users_subscription ON users(subscription_tier);
CREATE INDEX idx_users_active       ON users(is_active) WHERE is_active = TRUE;

-- -----------------------------------------------------------------------------

CREATE TABLE user_preferences (
    user_id                  UUID        PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    theme                    VARCHAR(10) NOT NULL DEFAULT 'light'
                                 CHECK (theme IN ('light', 'dark', 'system')),
    language                 VARCHAR(10) NOT NULL DEFAULT 'fr',
    default_mode             VARCHAR(20) NOT NULL DEFAULT 'EXAM'
                                 CHECK (default_mode IN ('EXAM', 'FREE', 'REVISION')),
    notifications_enabled    BOOLEAN     NOT NULL DEFAULT TRUE,
    last_certification_id    VARCHAR(50),
    free_mode_question_count SMALLINT    NOT NULL DEFAULT 30
                                 CHECK (free_mode_question_count BETWEEN 1 AND 200),
    free_mode_duration_min   SMALLINT    NOT NULL DEFAULT 60
                                 CHECK (free_mode_duration_min >= 0),
    updated_at               TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN user_preferences.theme                    IS 'light, dark ou system (suit les préfs OS)';
COMMENT ON COLUMN user_preferences.last_certification_id    IS 'Dernière certification consultée — reprise rapide';
COMMENT ON COLUMN user_preferences.free_mode_duration_min   IS '0 = illimité';

-- =============================================================================
-- MODULE CERTIFICATIONS
-- =============================================================================

CREATE TABLE certifications (
    id                  VARCHAR(50)  PRIMARY KEY,
    code                VARCHAR(30)  NOT NULL UNIQUE,
    name                VARCHAR(200) NOT NULL,
    description         TEXT,
    total_questions     INT          NOT NULL DEFAULT 0
                            CHECK (total_questions >= 0),
    exam_question_count INT          NOT NULL
                            CHECK (exam_question_count > 0),
    exam_duration_min   INT          NOT NULL
                            CHECK (exam_duration_min > 0),
    passing_score       SMALLINT     NOT NULL
                            CHECK (passing_score BETWEEN 1 AND 100),
    exam_type           VARCHAR(20)  NOT NULL DEFAULT 'MCQ'
                            CHECK (exam_type IN ('MCQ', 'PRACTICAL', 'MIXED')),
    is_active           BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN certifications.id                  IS 'Slug interne : java21, aws_ccp, ocp21';
COMMENT ON COLUMN certifications.code                IS 'Code officiel : 1Z0-830, CLF-C02, SAA-C03';
COMMENT ON COLUMN certifications.exam_question_count IS 'Nombre de questions tirées par examen';
COMMENT ON COLUMN certifications.passing_score       IS 'Seuil en % pour valider (ex: 68 pour OCP)';
COMMENT ON COLUMN certifications.exam_type           IS 'MCQ=QCM, PRACTICAL=pratique lab (CKA/CKAD), MIXED';

CREATE INDEX idx_certifications_active ON certifications(is_active) WHERE is_active = TRUE;

-- -----------------------------------------------------------------------------

CREATE TABLE certification_themes (
    id               UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    certification_id VARCHAR(50) NOT NULL REFERENCES certifications(id) ON DELETE CASCADE,
    code             VARCHAR(100) NOT NULL,
    label            VARCHAR(200) NOT NULL,
    question_count   INT         NOT NULL DEFAULT 0
                         CHECK (question_count >= 0),
    weight_percent   NUMERIC(5,2)
                         CHECK (weight_percent IS NULL OR weight_percent BETWEEN 0 AND 100),
    display_order    SMALLINT    NOT NULL DEFAULT 0,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (certification_id, code)
);

COMMENT ON COLUMN certification_themes.code          IS 'Slug URL : lambda_streams, virtual_threads';
COMMENT ON COLUMN certification_themes.label         IS 'Nom affiché issu de config.json';
COMMENT ON COLUMN certification_themes.weight_percent IS 'Pondération officielle — NULL si non publiée';

CREATE INDEX idx_themes_certification ON certification_themes(certification_id);
CREATE INDEX idx_themes_code          ON certification_themes(certification_id, code);

-- =============================================================================
-- MODULE QUESTIONS
-- =============================================================================

CREATE TABLE questions (
    id                    UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    legacy_id             VARCHAR(50)  UNIQUE,
    certification_id      VARCHAR(50)  NOT NULL REFERENCES certifications(id),
    theme_id              UUID         NOT NULL REFERENCES certification_themes(id),
    statement             TEXT         NOT NULL,
    difficulty            VARCHAR(10)  NOT NULL DEFAULT 'medium'
                              CHECK (difficulty IN ('easy', 'medium', 'hard')),
    question_type         VARCHAR(20)  NOT NULL DEFAULT 'SINGLE_CHOICE'
                              CHECK (question_type IN ('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TRUE_FALSE')),
    explanation_original  TEXT,
    explanation_enriched  TEXT,
    explanation_status    VARCHAR(20)  NOT NULL DEFAULT 'ORIGINAL'
                              CHECK (explanation_status IN ('ORIGINAL', 'AI_DRAFT', 'HUMAN_VALIDATED')),
    explanation_version   SMALLINT     NOT NULL DEFAULT 1
                              CHECK (explanation_version >= 1),
    official_doc_url      VARCHAR(500),
    code_example          TEXT,
    ai_confidence_score   NUMERIC(3,2)
                              CHECK (ai_confidence_score IS NULL OR
                                     (ai_confidence_score >= 0.0 AND ai_confidence_score <= 1.0)),
    last_reviewed_by      UUID         REFERENCES users(id) ON DELETE SET NULL,
    last_reviewed_at      TIMESTAMPTZ,
    is_active             BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at            TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN questions.legacy_id            IS 'ID original JSON : JAVA-001, AWS-CCP-065 — traçabilité migration';
COMMENT ON COLUMN questions.statement            IS 'Énoncé — peut contenir du Markdown pour les blocs de code';
COMMENT ON COLUMN questions.explanation_original IS 'Texte original importé depuis CertiPrep Engine — référence immuable';
COMMENT ON COLUMN questions.explanation_enriched IS 'Version enrichie par IA ou manuellement — NULL si non enrichie';
COMMENT ON COLUMN questions.explanation_status   IS 'ORIGINAL=non relu, AI_DRAFT=généré, HUMAN_VALIDATED=approuvé';
COMMENT ON COLUMN questions.ai_confidence_score  IS 'Score certitude IA 0.0-1.0 — guide la relecture humaine';
COMMENT ON COLUMN questions.official_doc_url     IS 'Lien doc officielle Oracle/AWS/CNCF — pour l enrichissement';

CREATE INDEX idx_questions_certification ON questions(certification_id);
CREATE INDEX idx_questions_theme         ON questions(theme_id);
CREATE INDEX idx_questions_difficulty    ON questions(difficulty);
CREATE INDEX idx_questions_status        ON questions(explanation_status);
CREATE INDEX idx_questions_active        ON questions(is_active) WHERE is_active = TRUE;
CREATE INDEX idx_questions_legacy        ON questions(legacy_id);
CREATE INDEX idx_questions_fts           ON questions USING gin(to_tsvector('french', statement));

-- -----------------------------------------------------------------------------

CREATE TABLE question_options (
    id            UUID     PRIMARY KEY DEFAULT uuid_generate_v4(),
    question_id   UUID     NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    label         CHAR(1)  NOT NULL CHECK (label IN ('A','B','C','D','E')),
    text          TEXT     NOT NULL,
    is_correct    BOOLEAN  NOT NULL DEFAULT FALSE,
    display_order SMALLINT NOT NULL DEFAULT 0
                      CHECK (display_order BETWEEN 0 AND 4),
    UNIQUE (question_id, label)
);

COMMENT ON COLUMN question_options.label         IS 'Lettre A/B/C/D/E affichée';
COMMENT ON COLUMN question_options.is_correct    IS 'TRUE = bonne réponse — plusieurs TRUE possibles pour MULTIPLE_CHOICE';
COMMENT ON COLUMN question_options.display_order IS 'Ordre original depuis options[] JSON (0-based → A/B/C/D)';

CREATE INDEX idx_options_question ON question_options(question_id);
CREATE INDEX idx_options_correct  ON question_options(question_id) WHERE is_correct = TRUE;

-- =============================================================================
-- MODULE EXAM SESSIONS
-- =============================================================================

CREATE TABLE exam_sessions (
    id               UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id          UUID         NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    certification_id VARCHAR(50)  NOT NULL REFERENCES certifications(id),
    mode             VARCHAR(20)  NOT NULL
                         CHECK (mode IN ('EXAM', 'FREE', 'REVISION')),
    status           VARCHAR(20)  NOT NULL DEFAULT 'IN_PROGRESS'
                         CHECK (status IN ('IN_PROGRESS', 'COMPLETED', 'ABANDONED', 'EXPIRED')),
    started_at       TIMESTAMPTZ  NOT NULL,
    ended_at         TIMESTAMPTZ,
    duration_seconds INT
                         CHECK (duration_seconds IS NULL OR duration_seconds >= 0),
    total_questions  SMALLINT     NOT NULL
                         CHECK (total_questions > 0),
    correct_count    SMALLINT     NOT NULL DEFAULT 0
                         CHECK (correct_count >= 0),
    percentage       NUMERIC(5,2) NOT NULL DEFAULT 0.0
                         CHECK (percentage >= 0.0 AND percentage <= 100.0),
    passed           BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at       TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN exam_sessions.duration_seconds IS 'Durée RÉELLE passée = ended_at - started_at en secondes';
COMMENT ON COLUMN exam_sessions.correct_count    IS 'Nombre de bonnes réponses — dénormalisé pour les performances';
COMMENT ON COLUMN exam_sessions.percentage       IS 'correct_count*100/total_questions — CHECK 0-100';
COMMENT ON COLUMN exam_sessions.passed           IS 'TRUE si percentage >= certifications.passing_score';

CREATE INDEX idx_sessions_user        ON exam_sessions(user_id);
CREATE INDEX idx_sessions_cert        ON exam_sessions(certification_id);
CREATE INDEX idx_sessions_user_cert   ON exam_sessions(user_id, certification_id);
CREATE INDEX idx_sessions_started     ON exam_sessions(started_at DESC);
CREATE INDEX idx_sessions_mode        ON exam_sessions(mode);
CREATE INDEX idx_sessions_status      ON exam_sessions(status);

-- -----------------------------------------------------------------------------

CREATE TABLE user_answers (
    id               UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id       UUID        NOT NULL REFERENCES exam_sessions(id) ON DELETE CASCADE,
    question_id      UUID        NOT NULL REFERENCES questions(id),
    selected_option  UUID        REFERENCES question_options(id) ON DELETE SET NULL,
    is_correct       BOOLEAN     NOT NULL DEFAULT FALSE,
    is_skipped       BOOLEAN     NOT NULL DEFAULT FALSE,
    response_time_ms INT
                         CHECK (response_time_ms IS NULL OR response_time_ms >= 0),
    answered_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (session_id, question_id)
);

COMMENT ON COLUMN user_answers.selected_option  IS 'NULL = question ignorée (remplace selected_answer=-1 de SQLite)';
COMMENT ON COLUMN user_answers.is_skipped       IS 'Flag explicite pour questions non répondues';
COMMENT ON COLUMN user_answers.response_time_ms IS 'Temps entre affichage question et sélection réponse en ms';

CREATE INDEX idx_answers_session  ON user_answers(session_id);
CREATE INDEX idx_answers_question ON user_answers(question_id);

-- =============================================================================
-- MODULE LEARNING (cours, flashcards, SM-2)
-- =============================================================================

CREATE TABLE courses (
    id               UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    certification_id VARCHAR(50) NOT NULL REFERENCES certifications(id) ON DELETE CASCADE,
    theme_id         UUID        NOT NULL REFERENCES certification_themes(id),
    title            VARCHAR(300) NOT NULL,
    content_markdown TEXT,
    content_html     TEXT,
    ai_status        VARCHAR(20) NOT NULL DEFAULT 'DRAFT'
                         CHECK (ai_status IN ('DRAFT', 'AI_GENERATED', 'HUMAN_REVIEWED', 'PUBLISHED')),
    version          SMALLINT    NOT NULL DEFAULT 1,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (certification_id, theme_id)
);

COMMENT ON COLUMN courses.content_markdown IS 'Source Markdown — éditable par les admins';
COMMENT ON COLUMN courses.content_html     IS 'HTML pré-rendu pour performance côté client';
COMMENT ON COLUMN courses.ai_status        IS 'Statut de validation du contenu généré par IA';

CREATE INDEX idx_courses_certification ON courses(certification_id);
CREATE INDEX idx_courses_theme         ON courses(theme_id);

-- -----------------------------------------------------------------------------

CREATE TABLE flashcards (
    id           UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    question_id  UUID        REFERENCES questions(id) ON DELETE SET NULL,
    course_id    UUID        REFERENCES courses(id) ON DELETE SET NULL,
    front_text   TEXT        NOT NULL,
    back_text    TEXT        NOT NULL,
    code_example TEXT,
    ai_generated BOOLEAN     NOT NULL DEFAULT FALSE,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (question_id IS NOT NULL OR course_id IS NOT NULL)
);

COMMENT ON COLUMN flashcards.question_id  IS 'Source : question du corpus — NULL si générée depuis cours';
COMMENT ON COLUMN flashcards.course_id    IS 'Source : fiche de cours — NULL si générée depuis question';
COMMENT ON COLUMN flashcards.ai_generated IS 'TRUE = générée par LangChain4j, FALSE = saisie manuelle';

CREATE INDEX idx_flashcards_question ON flashcards(question_id);
CREATE INDEX idx_flashcards_course   ON flashcards(course_id);

-- -----------------------------------------------------------------------------

CREATE TABLE user_flashcard_progress (
    user_id         UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    flashcard_id    UUID        NOT NULL REFERENCES flashcards(id) ON DELETE CASCADE,
    ease_factor     NUMERIC(4,2) NOT NULL DEFAULT 2.5
                        CHECK (ease_factor >= 1.3),
    interval_days   INT         NOT NULL DEFAULT 1
                        CHECK (interval_days >= 0),
    repetitions     INT         NOT NULL DEFAULT 0
                        CHECK (repetitions >= 0),
    next_review_date DATE        NOT NULL DEFAULT CURRENT_DATE,
    last_reviewed_at TIMESTAMPTZ,
    PRIMARY KEY (user_id, flashcard_id)
);

COMMENT ON COLUMN user_flashcard_progress.ease_factor    IS 'Facteur de facilité SM-2, minimum 1.3';
COMMENT ON COLUMN user_flashcard_progress.interval_days  IS 'Intervalle en jours avant prochaine révision';
COMMENT ON COLUMN user_flashcard_progress.next_review_date IS 'Date planifiée pour la prochaine révision';

CREATE INDEX idx_fc_progress_user        ON user_flashcard_progress(user_id);
CREATE INDEX idx_fc_progress_review_date ON user_flashcard_progress(user_id, next_review_date);

-- -----------------------------------------------------------------------------

CREATE TABLE user_sm2_schedule (
    id               UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id          UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    question_id      UUID        NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    ease_factor      NUMERIC(4,2) NOT NULL DEFAULT 2.5
                         CHECK (ease_factor >= 1.3),
    interval_days    INT         NOT NULL DEFAULT 1
                         CHECK (interval_days >= 0),
    repetitions      INT         NOT NULL DEFAULT 0
                         CHECK (repetitions >= 0),
    due_date         DATE        NOT NULL DEFAULT CURRENT_DATE,
    last_reviewed_at TIMESTAMPTZ,
    UNIQUE (user_id, question_id)
);

COMMENT ON TABLE  user_sm2_schedule IS 'Planification répétition espacée SM-2 par question et utilisateur';
COMMENT ON COLUMN user_sm2_schedule.due_date IS 'Date à partir de laquelle la question doit être révisée';

CREATE INDEX idx_sm2_user      ON user_sm2_schedule(user_id);
CREATE INDEX idx_sm2_due_date  ON user_sm2_schedule(user_id, due_date);
CREATE INDEX idx_sm2_question  ON user_sm2_schedule(question_id);

-- =============================================================================
-- MODULE DIAGNOSTIC & COACHING
-- =============================================================================

CREATE TABLE user_diagnostic_results (
    id                          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id                     UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    completed_at                TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    total_questions             SMALLINT    NOT NULL,
    score_by_domain             JSONB       NOT NULL DEFAULT '{}',
    skill_map                   JSONB       NOT NULL DEFAULT '{}',
    recommended_certifications  JSONB       NOT NULL DEFAULT '[]',
    created_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN user_diagnostic_results.score_by_domain            IS 'JSONB : {domain: score} ex: {"Lambda":75, "POO":60}';
COMMENT ON COLUMN user_diagnostic_results.skill_map                   IS 'JSONB : {skill: confidence_0_to_1}';
COMMENT ON COLUMN user_diagnostic_results.recommended_certifications  IS 'JSONB : [{id, rationale, priority}]';

CREATE INDEX idx_diagnostic_user ON user_diagnostic_results(user_id);

-- -----------------------------------------------------------------------------

CREATE TABLE user_certification_paths (
    id             UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id        UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role_type      VARCHAR(100),
    project_goal   TEXT,
    generated_path JSONB       NOT NULL DEFAULT '[]',
    ai_rationale   TEXT,
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN user_certification_paths.generated_path IS 'JSONB : [{certificationId, order, rationale, estimatedWeeks}]';
COMMENT ON COLUMN user_certification_paths.role_type      IS 'Ex: "Java Developer", "DevOps Engineer", "Cloud Architect"';

CREATE INDEX idx_cert_paths_user ON user_certification_paths(user_id);

-- -----------------------------------------------------------------------------

CREATE TABLE weekly_coach_reports (
    id             UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id        UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    week_start     DATE        NOT NULL,
    report_content TEXT        NOT NULL,
    study_plan     JSONB       NOT NULL DEFAULT '{}',
    sent_at        TIMESTAMPTZ,
    opened_at      TIMESTAMPTZ,
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, week_start)
);

COMMENT ON COLUMN weekly_coach_reports.study_plan IS 'JSONB : planning de révision de la semaine par jour et thème';
COMMENT ON COLUMN weekly_coach_reports.sent_at    IS 'NULL si non encore envoyé';
COMMENT ON COLUMN weekly_coach_reports.opened_at  IS 'NULL si email non ouvert (tracking pixel)';

CREATE INDEX idx_coach_reports_user ON weekly_coach_reports(user_id);
CREATE INDEX idx_coach_reports_week ON weekly_coach_reports(week_start);

-- =============================================================================
-- MODULE JOB MARKET
-- =============================================================================

CREATE TABLE job_market_data (
    id                UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    certification_id  VARCHAR(50) NOT NULL REFERENCES certifications(id),
    country_code      VARCHAR(10) NOT NULL,
    job_count         INT         NOT NULL DEFAULT 0
                          CHECK (job_count >= 0),
    median_salary_eur INT
                          CHECK (median_salary_eur IS NULL OR median_salary_eur >= 0),
    top_companies     JSONB       NOT NULL DEFAULT '[]',
    trend_data        JSONB       NOT NULL DEFAULT '{}',
    fetched_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires_at        TIMESTAMPTZ NOT NULL,
    UNIQUE (certification_id, country_code)
);

COMMENT ON COLUMN job_market_data.country_code      IS 'ISO 3166-1 alpha-2 : FR, MA, TN, BE, CH, CA, CI, SN';
COMMENT ON COLUMN job_market_data.median_salary_eur IS 'Salaire médian en EUR (normalisé par taux de change)';
COMMENT ON COLUMN job_market_data.top_companies     IS 'JSONB : [{name, jobCount, logoUrl}]';
COMMENT ON COLUMN job_market_data.trend_data        IS 'JSONB : {monthly: [{month, count}], growth12m: 0.15}';
COMMENT ON COLUMN job_market_data.expires_at        IS 'Cache TTL : 7 jours par défaut';

CREATE INDEX idx_job_market_cert    ON job_market_data(certification_id);
CREATE INDEX idx_job_market_country ON job_market_data(country_code);
CREATE INDEX idx_job_market_expiry  ON job_market_data(expires_at);

-- =============================================================================
-- MODULE COMMUNITY (challenges, groupes, mur des certifiés)
-- =============================================================================

CREATE TABLE weekly_challenges (
    id                  UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    certification_id    VARCHAR(50) NOT NULL REFERENCES certifications(id),
    theme_id            UUID        REFERENCES certification_themes(id),
    title               VARCHAR(200) NOT NULL,
    description         TEXT,
    starts_at           TIMESTAMPTZ NOT NULL,
    ends_at             TIMESTAMPTZ NOT NULL,
    question_ids        UUID[]      NOT NULL DEFAULT '{}',
    total_participants  INT         NOT NULL DEFAULT 0
                            CHECK (total_participants >= 0),
    created_by          UUID        NOT NULL REFERENCES users(id),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (ends_at > starts_at),
    CHECK (array_length(question_ids, 1) >= 5)
);

COMMENT ON COLUMN weekly_challenges.question_ids      IS 'Array UUIDs des questions — 10 questions recommandées';
COMMENT ON COLUMN weekly_challenges.total_participants IS 'Dénormalisé pour le classement — mis à jour par trigger';

CREATE INDEX idx_challenges_cert     ON weekly_challenges(certification_id);
CREATE INDEX idx_challenges_dates    ON weekly_challenges(starts_at, ends_at);
CREATE INDEX idx_challenges_active   ON weekly_challenges(ends_at) WHERE ends_at > NOW();

-- -----------------------------------------------------------------------------

CREATE TABLE challenge_participations (
    id           UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id      UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    challenge_id UUID        NOT NULL REFERENCES weekly_challenges(id) ON DELETE CASCADE,
    score        INT         NOT NULL DEFAULT 0
                     CHECK (score >= 0),
    percentage   NUMERIC(5,2) NOT NULL DEFAULT 0.0
                     CHECK (percentage >= 0 AND percentage <= 100),
    completed_at TIMESTAMPTZ,
    rank         INT
                     CHECK (rank IS NULL OR rank > 0),
    badge_earned VARCHAR(50),
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, challenge_id)
);

COMMENT ON COLUMN challenge_participations.badge_earned IS 'Ex: GOLD, SILVER, BRONZE, TOP_10_PERCENT';
COMMENT ON COLUMN challenge_participations.rank         IS 'NULL jusqu à la clôture du challenge';

CREATE INDEX idx_participations_user      ON challenge_participations(user_id);
CREATE INDEX idx_participations_challenge ON challenge_participations(challenge_id);
CREATE INDEX idx_participations_score     ON challenge_participations(challenge_id, score DESC);

-- -----------------------------------------------------------------------------

CREATE TABLE study_groups (
    id               UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name             VARCHAR(100) NOT NULL,
    certification_id VARCHAR(50) NOT NULL REFERENCES certifications(id),
    created_by       UUID        NOT NULL REFERENCES users(id),
    max_members      SMALLINT    NOT NULL DEFAULT 10
                         CHECK (max_members BETWEEN 2 AND 50),
    is_public        BOOLEAN     NOT NULL DEFAULT TRUE,
    invite_code      VARCHAR(20) NOT NULL UNIQUE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN study_groups.invite_code IS 'Code unique de 8 caractères pour rejoindre le groupe';

CREATE INDEX idx_groups_certification ON study_groups(certification_id);
CREATE INDEX idx_groups_invite_code   ON study_groups(invite_code);
CREATE INDEX idx_groups_public        ON study_groups(is_public) WHERE is_public = TRUE;

-- -----------------------------------------------------------------------------

CREATE TABLE study_group_members (
    group_id       UUID        NOT NULL REFERENCES study_groups(id) ON DELETE CASCADE,
    user_id        UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role           VARCHAR(20) NOT NULL DEFAULT 'MEMBER'
                       CHECK (role IN ('OWNER', 'MODERATOR', 'MEMBER')),
    joined_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_active_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (group_id, user_id)
);

CREATE INDEX idx_group_members_user  ON study_group_members(user_id);
CREATE INDEX idx_group_members_group ON study_group_members(group_id);

-- -----------------------------------------------------------------------------

CREATE TABLE certified_wall_profiles (
    id                   UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id              UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    certification_id     VARCHAR(50) NOT NULL REFERENCES certifications(id),
    exam_score           SMALLINT
                             CHECK (exam_score IS NULL OR (exam_score BETWEEN 0 AND 100)),
    prep_duration_weeks  SMALLINT
                             CHECK (prep_duration_weeks IS NULL OR prep_duration_weeks > 0),
    testimonial          TEXT,
    is_public            BOOLEAN     NOT NULL DEFAULT TRUE,
    linkedin_url         VARCHAR(500),
    country_code         VARCHAR(10),
    certified_at         DATE,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, certification_id)
);

COMMENT ON COLUMN certified_wall_profiles.prep_duration_weeks IS 'Durée de préparation auto-déclarée en semaines';

CREATE INDEX idx_wall_certification ON certified_wall_profiles(certification_id);
CREATE INDEX idx_wall_public        ON certified_wall_profiles(is_public) WHERE is_public = TRUE;
CREATE INDEX idx_wall_country       ON certified_wall_profiles(country_code);

-- =============================================================================
-- MODULE INTERVIEW
-- =============================================================================

CREATE TABLE interview_sessions (
    id               UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id          UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    certification_id VARCHAR(50) NOT NULL REFERENCES certifications(id),
    mode             VARCHAR(20) NOT NULL DEFAULT 'TEXT'
                         CHECK (mode IN ('TEXT', 'VOICE', 'MIXED')),
    started_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ended_at         TIMESTAMPTZ,
    total_questions  SMALLINT    NOT NULL DEFAULT 0,
    overall_feedback TEXT,
    score_by_domain  JSONB       NOT NULL DEFAULT '{}'
);

CREATE INDEX idx_interview_user ON interview_sessions(user_id);

-- -----------------------------------------------------------------------------

CREATE TABLE interview_answers (
    id            UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id    UUID        NOT NULL REFERENCES interview_sessions(id) ON DELETE CASCADE,
    question_text TEXT        NOT NULL,
    user_answer   TEXT        NOT NULL,
    ai_feedback   TEXT,
    score         SMALLINT
                      CHECK (score IS NULL OR (score BETWEEN 0 AND 10)),
    domain        VARCHAR(100),
    answered_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_interview_answers_session ON interview_answers(session_id);

-- =============================================================================
-- MODULE NOTIFICATIONS
-- =============================================================================

CREATE TABLE notifications (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id    UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type       VARCHAR(50) NOT NULL,
    title      VARCHAR(200) NOT NULL,
    body       TEXT,
    action_url VARCHAR(500),
    read_at    TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN notifications.type IS 'CHALLENGE_REMINDER, COACH_REPORT, BADGE_EARNED, REVIEW_DUE, etc.';

CREATE INDEX idx_notifications_user    ON notifications(user_id);
CREATE INDEX idx_notifications_unread  ON notifications(user_id, created_at DESC) WHERE read_at IS NULL;

-- -----------------------------------------------------------------------------

CREATE TABLE push_subscriptions (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id    UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    endpoint   TEXT        NOT NULL UNIQUE,
    p256dh     VARCHAR(200) NOT NULL,
    auth       VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON COLUMN push_subscriptions.p256dh IS 'Clé publique WebPush encodée base64url';
COMMENT ON COLUMN push_subscriptions.auth   IS 'Secret d authentification WebPush encodé base64url';

CREATE INDEX idx_push_user ON push_subscriptions(user_id);
