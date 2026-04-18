# certif-ai

Module **IA** — LangChain4j, ModelRouter Ollama↔Claude, RAG pgvector.

## ModelRouter

| Profil | Modèle léger | Modèle lourd |
|---|---|---|
| `local` | Ollama qwen2.5-coder:7b | Ollama qwen2.5-coder:7b |
| `prod` | claude-haiku-4-5 | claude-sonnet-4-6 |

## Fonctionnalités

- **EnrichQuestionService** : enrichit les explications des questions (idempotent)
- **FlashcardGenerator** : génère des flashcards SM-2 par thème
- **CourseGenerator** : génère des fiches de révision Markdown
- **ChatAssistant** : assistant conversationnel RAG (pgvector)
- **InterviewSimulator** : génère et évalue des questions d'entretien
- **WeeklyCoachReport** : rapport hebdomadaire personnalisé
- **DiagnosticAnalyzer** : analyse les points faibles + plan d'action

## Prompts

Tous les prompts sont externalisés dans `src/main/resources/prompts/*.mustache`.

## Démarrer Ollama localement

```bash
docker compose --profile local up -d ollama
# Attendre le téléchargement du modèle (~5 min)
curl http://localhost:11434/api/version
```
