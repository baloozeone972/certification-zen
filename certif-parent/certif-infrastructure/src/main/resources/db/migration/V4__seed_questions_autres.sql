-- =============================================================================
-- certif-infrastructure/src/main/resources/db/migration/V4__seed_questions_autres.sql
-- CertifApp — Stratégie d'import pour les 14 autres certifications
-- Ce script est un TEMPLATE. Le contenu réel est généré par migrate_questions.py
-- =============================================================================

-- Normalisation "explication" → "explanation" déjà effectuée par le script bash
-- avant l'exécution de Flyway.

-- Ce script définit la procédure stockée réutilisable d'import de questions
-- utilisée par migrate_questions.py et l'endpoint admin /admin/questions/import

CREATE
OR REPLACE FUNCTION import_question(
    p_legacy_id         VARCHAR(50),
    p_certification_id  VARCHAR(50),
    p_theme_label       VARCHAR(200),
    p_statement         TEXT,
    p_difficulty        VARCHAR(10),
    p_explanation       TEXT,
    p_options           TEXT[],    -- tableau des textes d'options
    p_correct_index     SMALLINT   -- index 0-based de la bonne réponse
) RETURNS UUID AS $$
DECLARE
v_question_id UUID;
    v_theme_id
UUID;
    v_option_text
TEXT;
    v_labels
CHAR(1)[] := ARRAY['A','B','C','D','E'];
    v_i
INT;
BEGIN
    -- Résolution du thème
SELECT id
INTO v_theme_id
FROM certification_themes
WHERE certification_id = p_certification_id
  AND label = p_theme_label LIMIT 1;

IF
v_theme_id IS NULL THEN
        RAISE WARNING 'Thème introuvable: % pour %', p_theme_label, p_certification_id;
RETURN NULL;
END IF;

    -- Évite les doublons par legacy_id
    IF
EXISTS (SELECT 1 FROM questions WHERE legacy_id = p_legacy_id) THEN
        RETURN (SELECT id FROM questions WHERE legacy_id = p_legacy_id);
END IF;

    -- Insertion de la question
INSERT INTO questions (legacy_id, certification_id, theme_id, statement,
                       difficulty, question_type, explanation_original)
VALUES (p_legacy_id, p_certification_id, v_theme_id, p_statement,
        p_difficulty, 'SINGLE_CHOICE', p_explanation) RETURNING id
INTO v_question_id;

-- Insertion des options
FOR v_i IN 1..array_length(p_options, 1) LOOP
        INSERT INTO question_options (question_id, label, text, is_correct, display_order)
        VALUES (
            v_question_id,
            v_labels[v_i],
            p_options[v_i],
            (v_i - 1 = p_correct_index),
            v_i - 1
        );
END LOOP;

RETURN v_question_id;
END;
$$
LANGUAGE plpgsql;

COMMENT
ON FUNCTION import_question IS
    'Importe une question depuis le corpus JSON en évitant les doublons par legacy_id. '
    'Retourne l UUID de la question créée ou existante.';

-- Exemple d'utilisation (commenté — décommenté par migrate_questions.py) :
/*
SELECT import_question(
    'AWS-CCP-001',
    'aws_ccp',
    'Cloud Concepts',
    'Qu est-ce que le cloud computing ?',
    'easy',
    'Le cloud computing est la livraison de ressources informatiques à la demande via Internet.',
    ARRAY['Hébergement de serveurs locaux', 'Services informatiques via Internet', 'Stockage sur disque dur', 'Réseau local d entreprise'],
    1   -- index 0-based : "Services informatiques via Internet"
);
*/

-- Vue de suivi de l'import
CREATE
OR REPLACE VIEW v_import_progress AS
SELECT c.id                                                         AS certification_id,
       c.name                                                       AS certification_name,
       c.total_questions                                            AS expected_questions,
       COUNT(q.id)                                                  AS imported_questions,
       c.total_questions - COUNT(q.id)                              AS missing_questions,
       ROUND(COUNT(q.id) * 100.0 / NULLIF(c.total_questions, 0), 1) AS completion_pct
FROM certifications c
         LEFT JOIN questions q ON q.certification_id = c.id AND q.is_active = TRUE
GROUP BY c.id, c.name, c.total_questions
ORDER BY completion_pct DESC;

COMMENT
ON VIEW v_import_progress IS
    'Suivi de l avancement du seed questions par certification. '
    'Utiliser SELECT * FROM v_import_progress pour vérifier l import.';
