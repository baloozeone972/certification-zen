-- =============================================================================
-- certif-infrastructure/src/main/resources/db/migration/V5__add_pgvector.sql
-- CertifApp — Extension pgvector pour le RAG LangChain4j
-- Dimensions : 1536 (text-embedding-3-small OpenAI / Claude) ou 384 (all-MiniLM-L6-v2 Ollama local)
-- NOTE : La dimension 1536 est compatible avec les deux modèles (on padding à 384 si Ollama).
--        En pratique, utiliser 1536 pour compatibilité maximale.
-- =============================================================================

-- Extension pgvector
CREATE EXTENSION IF NOT EXISTS vector;

-- =============================================================================
-- Colonnes embeddings sur les tables existantes
-- =============================================================================

ALTER TABLE questions
    ADD COLUMN IF NOT EXISTS embedding vector(1536);

COMMENT ON COLUMN questions.embedding IS
    'Embedding sémantique du statement — 1536 dims (text-embedding-3-small) ou '
    '384 dims padded (all-MiniLM-L6-v2 Ollama local). Généré par DocumentIngester.';

ALTER TABLE courses
    ADD COLUMN IF NOT EXISTS embedding vector(1536);

COMMENT ON COLUMN courses.embedding IS
    'Embedding sémantique du contenu du cours — pour la recherche RAG.';

-- =============================================================================
-- Index ivfflat pour la recherche approchée de voisins (ANN)
-- nlist=100 : bon défaut pour < 1M vecteurs
-- =============================================================================

-- Index sur questions.embedding (similarité cosinus)
CREATE INDEX IF NOT EXISTS idx_questions_embedding_cosine
    ON questions USING ivfflat (embedding vector_cosine_ops)
    WITH (lists = 100);

COMMENT ON INDEX idx_questions_embedding_cosine IS
    'Index ivfflat pour la recherche sémantique ANN sur les questions. '
    'Reconstruire avec REINDEX si les données changent significativement.';

-- Index sur courses.embedding (similarité cosinus)
CREATE INDEX IF NOT EXISTS idx_courses_embedding_cosine
    ON courses USING ivfflat (embedding vector_cosine_ops)
    WITH (lists = 100);

-- =============================================================================
-- Table dédiée LangChain4j pgvector store (métadonnées RAG)
-- LangChain4j pgvector store utilise sa propre table avec ce schéma exact.
-- =============================================================================

CREATE TABLE IF NOT EXISTS langchain4j_embeddings (
    id          UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    embedding   vector(1536) NOT NULL,
    text        TEXT         NOT NULL,
    metadata    JSONB        NOT NULL DEFAULT '{}',
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE  langchain4j_embeddings          IS 'Store pgvector géré par LangChain4j — ne pas modifier manuellement';
COMMENT ON COLUMN langchain4j_embeddings.metadata IS 'JSONB : {source: "question"|"course", id: UUID, certificationId, themeCode}';

CREATE INDEX IF NOT EXISTS idx_lc4j_embeddings_vector
    ON langchain4j_embeddings USING ivfflat (embedding vector_cosine_ops)
    WITH (lists = 100);

CREATE INDEX IF NOT EXISTS idx_lc4j_embeddings_metadata
    ON langchain4j_embeddings USING gin(metadata);

-- =============================================================================
-- Vue de suivi de la couverture d'embeddings
-- =============================================================================

CREATE OR REPLACE VIEW v_embedding_coverage AS
SELECT
    'questions' AS table_name,
    COUNT(*)                                               AS total,
    COUNT(embedding)                                       AS with_embedding,
    ROUND(COUNT(embedding) * 100.0 / NULLIF(COUNT(*), 0), 1) AS coverage_pct
FROM questions
WHERE is_active = TRUE
UNION ALL
SELECT
    'courses',
    COUNT(*),
    COUNT(embedding),
    ROUND(COUNT(embedding) * 100.0 / NULLIF(COUNT(*), 0), 1)
FROM courses;

COMMENT ON VIEW v_embedding_coverage IS
    'Suivi de la couverture des embeddings pour le RAG. '
    'Objectif : 100% avant la mise en prod de l assistant IA.';
