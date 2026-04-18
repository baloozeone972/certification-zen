-- =============================================================================
-- certif-infrastructure/src/main/resources/db/migration/V3__seed_questions_ocp21.sql
-- CertifApp — Stratégie seed questions OCP21 (java21 + ocp21 fusionnés)
-- NOTE : Le seed complet des 500+ questions est généré par le script Python
-- certif-infrastructure/src/main/resources/scripts/migrate_questions.py
-- Ce fichier contient 5 questions d'exemple valides pour valider le schéma.
-- =============================================================================

-- Normalisation préalable : ce script suppose que les JSON ont été normalisés
-- ("explication" → "explanation") par le script bash avant exécution Flyway.

DO
$$
DECLARE
v_cert_id    VARCHAR(50) := 'ocp21';
    v_theme_id
UUID;
    v_q1_id
UUID := uuid_generate_v4();
    v_q2_id
UUID := uuid_generate_v4();
    v_q3_id
UUID := uuid_generate_v4();
    v_q4_id
UUID := uuid_generate_v4();
    v_q5_id
UUID := uuid_generate_v4();
BEGIN
    -- Récupération du theme_id pour 'virtual_threads'
SELECT id
INTO v_theme_id
FROM certification_themes
WHERE certification_id = v_cert_id
  AND code = 'virtual_threads' LIMIT 1;

-- Question 1 : Virtual Threads
INSERT INTO questions (id, legacy_id, certification_id, theme_id,
                       statement, difficulty, question_type, explanation_original)
VALUES (v_q1_id,
        'OCP21-VT-001',
        v_cert_id,
        v_theme_id,
        'Quelle méthode de la classe Thread permet de créer un Virtual Thread en Java 21 ?',
        'easy',
        'SINGLE_CHOICE',
        'Thread.ofVirtual() est la méthode factory introduite en Java 21 pour créer des virtual threads. Thread.ofPlatform() crée un thread de plateforme classique.');
INSERT INTO question_options (id, question_id, label, text, is_correct, display_order)
VALUES (uuid_generate_v4(), v_q1_id, 'A', 'Thread.ofVirtual().start(() -> {})', TRUE, 0),
       (uuid_generate_v4(), v_q1_id, 'B', 'Thread.ofPlatform().start(() -> {})', FALSE, 1),
       (uuid_generate_v4(), v_q1_id, 'C', 'new VirtualThread(() -> {})', FALSE, 2),
       (uuid_generate_v4(), v_q1_id, 'D', 'Executors.newVirtualThreadPerTaskExecutor()', FALSE, 3);

-- Question 2 : Virtual Threads (Executors)
INSERT INTO questions (id, legacy_id, certification_id, theme_id,
                       statement, difficulty, question_type, explanation_original)
VALUES (v_q2_id,
        'OCP21-VT-002',
        v_cert_id,
        v_theme_id,
        'Quel executor utilise un Virtual Thread par tâche soumise en Java 21 ?',
        'medium',
        'SINGLE_CHOICE',
        'Executors.newVirtualThreadPerTaskExecutor() crée un ExecutorService qui démarre un nouveau virtual thread pour chaque tâche. Idéal pour les I/O-bound tasks.');
INSERT INTO question_options (id, question_id, label, text, is_correct, display_order)
VALUES (uuid_generate_v4(), v_q2_id, 'A', 'Executors.newVirtualThreadPerTaskExecutor()', TRUE, 0),
       (uuid_generate_v4(), v_q2_id, 'B', 'Executors.newCachedThreadPool()', FALSE, 1),
       (uuid_generate_v4(), v_q2_id, 'C', 'Executors.newFixedThreadPool(100)', FALSE, 2),
       (uuid_generate_v4(), v_q2_id, 'D', 'ForkJoinPool.commonPool()', FALSE, 3);

-- Changement de thème : Pattern Matching
SELECT id
INTO v_theme_id
FROM certification_themes
WHERE certification_id = v_cert_id
  AND code = 'pattern_matching' LIMIT 1;

-- Question 3 : Pattern Matching switch
INSERT INTO questions (id, legacy_id, certification_id, theme_id,
                       statement, difficulty, question_type, explanation_original)
VALUES (v_q3_id,
        'OCP21-PM-001',
        v_cert_id,
        v_theme_id,
        'Quel résultat produit ce code Java 21 ?\nObject o = 42;\nString result = switch(o) {\n  case Integer i when i > 0 -> "positif";\n  case Integer i -> "négatif ou zéro";\n  default -> "autre";\n};',
        'medium',
        'SINGLE_CHOICE',
        'Le pattern matching dans switch avec "when" (guarded pattern) évalue d abord le type puis la condition. 42 est un Integer > 0, donc le premier case correspond.');
INSERT INTO question_options (id, question_id, label, text, is_correct, display_order)
VALUES (uuid_generate_v4(), v_q3_id, 'A', '"positif"', TRUE, 0),
       (uuid_generate_v4(), v_q3_id, 'B', '"négatif ou zéro"', FALSE, 1),
       (uuid_generate_v4(), v_q3_id, 'C', '"autre"', FALSE, 2),
       (uuid_generate_v4(), v_q3_id, 'D', 'NullPointerException', FALSE, 3);

-- Thème : Records et Sealed Classes
SELECT id
INTO v_theme_id
FROM certification_themes
WHERE certification_id = v_cert_id
  AND code = 'records_sealed' LIMIT 1;

-- Question 4 : Records
INSERT INTO questions (id, legacy_id, certification_id, theme_id,
                       statement, difficulty, question_type, explanation_original)
VALUES (v_q4_id,
        'OCP21-RC-001',
        v_cert_id,
        v_theme_id,
        'Lequel des éléments suivants NE peut PAS être redéfini dans un Record Java 21 ?',
        'hard',
        'SINGLE_CHOICE',
        'Les Records génèrent automatiquement equals(), hashCode(), toString() et les accesseurs. On peut redéfinir les méthodes canonique du constructeur, les accesseurs et les méthodes statiques. On ne peut PAS ajouter de champs d instance supplémentaires.');
INSERT INTO question_options (id, question_id, label, text, is_correct, display_order)
VALUES (uuid_generate_v4(), v_q4_id, 'A', 'Le constructeur compact', FALSE, 0),
       (uuid_generate_v4(), v_q4_id, 'B', 'La méthode equals()', FALSE, 1),
       (uuid_generate_v4(), v_q4_id, 'C', 'Les champs d instance supplémentaires', TRUE, 2),
       (uuid_generate_v4(), v_q4_id, 'D', 'La méthode toString()', FALSE, 3);

-- Thème : Structured Concurrency
SELECT id
INTO v_theme_id
FROM certification_themes
WHERE certification_id = v_cert_id
  AND code = 'structured_concurrency' LIMIT 1;

-- Question 5 : Structured Concurrency
INSERT INTO questions (id, legacy_id, certification_id, theme_id,
                       statement, difficulty, question_type, explanation_original)
VALUES (v_q5_id,
        'OCP21-SC-001',
        v_cert_id,
        v_theme_id,
        'Quelle classe introduite en Java 21 (preview) permet de gérer des tâches concurrentes structurées avec annulation automatique en cas d échec ?',
        'hard',
        'SINGLE_CHOICE',
        'StructuredTaskScope est la classe clé de l API Structured Concurrency (JEP 453 en Java 21). Elle garantit que toutes les sous-tâches se terminent avant que la portée ne se ferme, avec propagation automatique des annulations.');
INSERT INTO question_options (id, question_id, label, text, is_correct, display_order)
VALUES (uuid_generate_v4(), v_q5_id, 'A', 'StructuredTaskScope', TRUE, 0),
       (uuid_generate_v4(), v_q5_id, 'B', 'CompletableFuture', FALSE, 1),
       (uuid_generate_v4(), v_q5_id, 'C', 'ExecutorService', FALSE, 2),
       (uuid_generate_v4(), v_q5_id, 'D', 'ForkJoinTask', FALSE, 3);

-- Mise à jour du compteur de questions
UPDATE certifications
SET total_questions = 5
WHERE id = v_cert_id;

END $$;

-- =============================================================================
-- NOTES POUR LE DÉVELOPPEUR :
-- Le seed complet des ~4850 questions est généré par :
--   certif-infrastructure/src/main/resources/scripts/migrate_questions.py
-- Ce script lit les JSON sources et génère V3_full__seed_questions_all.sql
-- qui remplace ce fichier en production.
-- =============================================================================
