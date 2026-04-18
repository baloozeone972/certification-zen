# certif-infrastructure

Module **infrastructure** — JPA, Flyway, cache, PDF, adapters.

## Rôle

Implémente les ports output définis dans `certif-domain` :
- `UserRepository` → `UserRepositoryAdapter` (Spring Data JPA)
- `QuestionRepository` → `QuestionRepositoryAdapter`
- `PdfExportPort` → `IText7PdfExportAdapter`
- `StripePort` → `StripeWebhookAdapter` (HMAC-SHA256 natif)

## Migrations Flyway

| Version | Contenu |
|---|---|
| V1 | Schéma PostgreSQL initial (tables, index, contraintes) |
| V2 | Seed 42 certifications et leurs thèmes |
| V3 | Questions OCP21 (exemple validation schéma) |
| V4 | Questions autres certifications (exemple) |
| V5 | Extension pgvector pour les embeddings IA |
| V6a→V6m | Import complet pool 6 287 questions |

## Lancer les tests (Testcontainers)

```bash
cd certif-parent
mvn verify -pl certif-infrastructure -Dspring.profiles.active=test
```

> Nécessite Docker Desktop démarré.
