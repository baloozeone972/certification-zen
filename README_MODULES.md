# certif-domain — README
<!-- certif-domain/README.md -->

## Responsabilité

Module de domaine pur (architecture hexagonale). Contient **uniquement** la logique métier :
Records Java 21, enums, exceptions domaine, services purs (`ScoringService`, `SM2Service`,
`QuestionSelectionService`), et les interfaces des ports hexagonaux (input/output).
**Aucune dépendance** Spring, JPA, Hibernate ou framework externe.

## Dépendances Maven

Ce module n'a **aucune dépendance** vers un autre module interne.
Dépendances externes limitées à `jackson-annotations` et `jakarta.validation-api`.

## Build isolé

```bash
cd certif-parent
mvn clean install -pl certif-domain --no-transfer-progress
```

## Tests

```bash
mvn test -pl certif-domain
```

Tests purs JUnit 5 + AssertJ, aucun contexte Spring requis.

## Packages principaux

| Package | Contenu |
|---|---|
| `domain.model.certification` | `Certification`, `CertificationTheme`, `CertificationId` |
| `domain.model.question` | `Question`, `QuestionOption`, `DifficultyLevel`, `QuestionType` |
| `domain.model.session` | `ExamSession`, `UserAnswer`, `ExamMode`, `ThemeStats` |
| `domain.model.user` | `User`, `UserRole`, `SubscriptionTier`, `UserPreferences` |
| `domain.model.learning` | `Course`, `Flashcard`, `SM2Schedule`, `SM2Algorithm` |
| `domain.model.community` | `WeeklyChallenge`, `StudyGroup`, `CertifiedWallProfile` |
| `domain.model.coaching` | `DiagnosticResult`, `CertificationPath`, `WeeklyCoachReport` |
| `domain.port.input` | 30+ interfaces use cases |
| `domain.port.output` | 19 interfaces repositories |
| `domain.service` | `ScoringService`, `SM2Service`, `QuestionSelectionService`, `FreemiumGuardService` |
| `domain.exception` | 11 exceptions métier |

## Développeur responsable

**Senior Java** — aucune connaissance Spring requise. Java 21 (Records, Sealed Classes,
Pattern Matching) fortement recommandé.

---
---

# certif-application — README
<!-- certif-application/README.md -->

## Responsabilité

Couche applicative : orchestration des use cases, coordination des ports hexagonaux,
DTOs applicatifs (Records Java 21). Implémente les interfaces du module `certif-domain`.
Aucune dépendance Spring ou JPA — les use cases sont testables sans framework.

## Dépendances Maven

```
certif-domain
```

## Build isolé

```bash
cd certif-parent
mvn clean install -pl certif-application -am --no-transfer-progress
# -am = also make : construit aussi certif-domain
```

## Tests

```bash
mvn test -pl certif-application -am
```

Tests JUnit 5 + Mockito, aucun contexte Spring. Les ports output sont mockés.

## Packages principaux

| Package | Contenu |
|---|---|
| `application.usecase.certification` | `ListCertificationsUseCaseImpl`, `GetCertificationDetailsUseCaseImpl` |
| `application.usecase.exam` | `StartExamSessionUseCaseImpl`, `SubmitAnswerUseCaseImpl`, `SubmitExamUseCaseImpl` |
| `application.usecase.learning` | `GetFlashcardsUseCaseImpl`, `ReviewFlashcardUseCaseImpl`, `GetAdaptivePlanUseCaseImpl` |
| `application.usecase.session` | `GetSessionHistoryUseCaseImpl`, `ExportSessionPdfUseCaseImpl` |
| `application.usecase.community` | `JoinChallengeUseCaseImpl`, `CreateStudyGroupUseCaseImpl` |
| `application.usecase.coaching` | `RunDiagnosticUseCaseImpl`, `GetWeeklyCoachReportUseCaseImpl` |
| `application.usecase.user` | `RegisterUserUseCaseImpl`, `AuthenticateUserUseCaseImpl` |
| `application.usecase.payment` | `ProcessStripeWebhookUseCaseImpl` |
| `application.dto` | DTOs Records par feature (request + response) |

## Développeur responsable

**Senior Java** — maîtrise de l'architecture hexagonale recommandée.

---
---

# certif-infrastructure — README
<!-- certif-infrastructure/README.md -->

## Responsabilité

Couche infrastructure : implémente les ports output de `certif-domain`. Contient les entités JPA
(séparées des Records domain), les repositories Spring Data, les scripts de migration Flyway V1-V5,
l'adaptateur iText7 pour l'export PDF, l'envoi d'emails Thymeleaf, le cache Caffeine et
le scheduler de rapports coach hebdomadaires.

## Dépendances Maven

```
certif-domain
certif-application
```

## Build isolé

```bash
cd certif-parent
mvn clean install -pl certif-infrastructure -am -DskipTests --no-transfer-progress
```

## Tests d'intégration (Testcontainers)

```bash
# Nécessite Docker en fonctionnement
mvn verify -pl certif-infrastructure -am -Dspring.profiles.active=test
```

## Scripts Flyway

| Script | Contenu |
|---|---|
| `V1__init_schema.sql` | Schéma complet (users → notifications, ~25 tables) |
| `V2__seed_certifications.sql` | 15 certifications + thèmes |
| `V3__seed_questions_ocp21.sql` | 5 questions OCP21 d'exemple (seed complet via script Python) |
| `V4__seed_questions_autres.sql` | Fonction `import_question()` PL/pgSQL + vue `v_import_progress` |
| `V5__add_pgvector.sql` | Extension pgvector + colonnes embedding + index ivfflat |

## Normalisation du corpus avant seed

```bash
find src/main/resources/certifications -name "*.json" \
  | xargs sed -i 's/"explication":/"explanation":/g'
```

## Packages principaux

| Package | Contenu |
|---|---|
| `infrastructure.persistence.entity` | 24 entités JPA |
| `infrastructure.persistence.repository` | 23 repositories Spring Data |
| `infrastructure.persistence.mapper` | 7 mappers MapStruct |
| `infrastructure.persistence.adapter` | 19 adapters (ports output) |
| `infrastructure.pdf` | `IText7PdfExportAdapter` |
| `infrastructure.mail` | `SpringMailAdapter`, templates Thymeleaf |
| `infrastructure.cache` | `CaffeineCacheConfig` |
| `infrastructure.scheduling` | `WeeklyCoachScheduler` |

## Développeur responsable

**Senior Java + DBA PostgreSQL** — maîtrise JPA/Hibernate, Flyway, pgvector, Testcontainers.

---
---

# certif-api-rest — README
<!-- certif-api-rest/README.md -->

## Responsabilité

Point d'entrée de l'application Spring Boot. Expose l'API REST publique et interne :
controllers REST, sécurité JWT (access 15min + refresh 7j), WebSocket STOMP pour les
challenges live et groupes d'étude, configuration OpenAPI/Swagger, gestion des webhooks Stripe.
Contient la seule classe `@SpringBootApplication` du projet.

## Dépendances Maven

```
certif-application
certif-infrastructure
certif-ai
```

## Lancer l'API

```bash
# Prérequis : docker compose up -d db redis ollama

cd certif-parent
mvn spring-boot:run -pl certif-api-rest -Dspring-boot.run.profiles=local

# URL : http://localhost:8080
# Swagger : http://localhost:8080/swagger-ui.html
# Health : http://localhost:8080/actuator/health
```

## Tests

```bash
mvn verify -pl certif-api-rest -am -Dspring.profiles.active=test
```

## Profils disponibles

| Profil | LLM | BDD | Usage |
|---|---|---|---|
| `local` | Ollama | PostgreSQL docker-compose | Développement |
| `test` | Mocks | Testcontainers | CI |
| `prod` | Claude API | Supabase | Production |

## Packages principaux

| Package | Contenu |
|---|---|
| `api.controller` | 12 controllers REST |
| `api.dto.request` | 14 DTOs de requête |
| `api.dto.response` | 6 DTOs de réponse communs |
| `api.security` | `JwtTokenProvider`, `JwtAuthenticationFilter`, `SecurityConfig` |
| `api.websocket` | `GroupStudyWebSocketController`, `ChallengeWebSocketController` |
| `api.config` | `OpenApiConfig`, `WebConfig`, `AsyncConfig` |
| `api.exception` | `GlobalExceptionHandler` |

## Variables d'environnement requises (prod)

```
APP_JWT_SECRET              (min 256 bits)
STRIPE_SECRET_KEY
STRIPE_WEBHOOK_SECRET
SPRING_DATASOURCE_URL       (Supabase JDBC URL)
ANTHROPIC_API_KEY           (profil prod uniquement)
```

## Développeur responsable

**Senior Spring Boot + Spring Security** — maîtrise JWT, WebSocket STOMP, OpenAPI.

---
---

# certif-ai — README
<!-- certif-ai/README.md -->

## Responsabilité

Services IA de CertifApp. Implémente le `ModelRouter` LangChain4j : Ollama en local,
Claude API (Anthropic) en production. Fournit 8 services IA : enrichissement d'explications,
génération de cours et flashcards, assistant RAG conversationnel, coach hebdomadaire,
simulateur d'entretien, analyse diagnostic, recommandation de parcours certifications.
Gère l'ingestion du corpus dans pgvector et la recherche sémantique.

## Dépendances Maven

```
certif-domain
certif-application
```

## Prérequis locaux

```bash
# Télécharger les modèles Ollama (première fois, ~5Go)
docker exec certifapp-ollama ollama pull llama3.1:8b-instruct-q4_K_M
docker exec certifapp-ollama ollama pull nomic-embed-text

# Vérifier
docker exec certifapp-ollama ollama list
```

## Build isolé

```bash
cd certif-parent
mvn clean install -pl certif-ai -am -DskipTests --no-transfer-progress
```

## Ingestion du corpus (RAG)

Le corpus de 4850+ questions et les fiches de cours sont ingérés dans pgvector
au démarrage de l'application si la table `langchain4j_embeddings` est vide.

```bash
# Forcer la ré-ingestion (admin)
curl -X POST http://localhost:8080/api/v1/admin/ai/ingest \
  -H "Authorization: Bearer $ADMIN_TOKEN"
```

## Configuration ModelRouter

```yaml
# application-local.yml
certifapp:
  ai:
    model-router:
      provider: ollama
      text-model: llama3.1:8b-instruct-q4_K_M
      embedding-model: nomic-embed-text
      cache-ttl-hours: 24

# application-prod.yml
certifapp:
  ai:
    model-router:
      provider: anthropic
      text-model-light: claude-3-haiku-20240307
      text-model-heavy: claude-3-5-sonnet-20241022
      embedding-model: text-embedding-3-small
      cache-ttl-hours: 24
```

## Packages principaux

| Package | Contenu |
|---|---|
| `ai.config` | `ModelRouterConfig`, `OllamaConfig`, `AnthropicConfig`, `EmbeddingConfig` |
| `ai.service` | 8 services IA |
| `ai.rag` | `DocumentIngester`, `VectorStoreAdapter`, `RetrievalService` |
| `ai.prompt` | `PromptTemplates` + 9 fichiers `.mustache` |

## Coûts estimés (prod Claude API)

| Tâche | Coût/appel | Volume mensuel estimé | Coût/mois |
|---|---|---|---|
| Enrichissement explication | ~0.01€ | 200/mois (admin) | ~2€ |
| Génération cours | ~0.05€ | 50/mois (admin) | ~2.5€ |
| Chat RAG (PRO users) | ~0.10€ | 5000/mois | ~500€ |
| Coach hebdo | ~0.20€ | 1000/semaine | ~800€ |
| **Total estimé** | | | **~1500€/mois** |

## Développeur responsable

**Senior Java + expertise LLM/LangChain4j** — maîtrise prompt engineering,
RAG, embeddings, pgvector. Expérience LangChain4j ou Spring AI recommandée.
