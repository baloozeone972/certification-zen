# CertifApp — Guide développement local Docker

## Prérequis

- Docker Desktop 4.x+
- Docker Compose 2.x (`docker compose`)
- 16 Go RAM (8 Go minimum sans Ollama)
- 20 Go espace disque (modèles Ollama inclus)

## Démarrage rapide (5 minutes)

```bash
# 1. Cloner le repo et se placer dans certif-parent/
git clone https://github.com/baloozeone972/certification-zen.git
cd certification-zen/certif-parent

# 2. Configurer les variables d'environnement
cp .env.exemple .env
# Éditer .env et remplir APP_JWT_SECRET (64+ chars)

# 3. Démarrer tous les services en mode local
docker compose --profile local up -d

# 4. Attendre que l'API soit healthy (~2 min au premier démarrage)
docker compose ps

# 5. Accéder aux services
open http://localhost:4200  # Angular PWA
open http://localhost:8080/swagger-ui.html  # API Swagger
open http://localhost:8025  # MailHog (emails de dev)
open http://localhost:8888  # Adminer (base de données)
```

## Services disponibles

| Service | URL | Description |
|---|---|---|
| **Angular PWA** | http://localhost:4200 | Application web |
| **API REST** | http://localhost:8080 | Spring Boot 3 |
| **Swagger UI** | http://localhost:8080/swagger-ui.html | Documentation API |
| **Actuator** | http://localhost:8080/actuator/health | Santé de l'API |
| **MailHog** | http://localhost:8025 | Emails de développement |
| **Adminer** | http://localhost:8888 | Interface PostgreSQL |
| **Ollama** | http://localhost:11434 | LLM local |
| **PostgreSQL** | localhost:5432 | Base principale |
| **PostgreSQL test** | localhost:5433 | Base de tests |

## Commandes utiles

```bash
# Voir les logs en temps réel
docker compose logs -f api
docker compose logs -f postgres

# Reconstruire et redémarrer l'API après un changement de code
docker compose build api && docker compose up -d api

# Accéder au shell PostgreSQL
docker compose exec postgres psql -U certifapp -d certifapp

# Réinitialiser la base de données (ATTENTION : supprime toutes les données)
docker compose down -v && docker compose --profile local up -d

# Vérifier la santé de tous les services
docker compose ps

# Démarrer uniquement pour les tests (sans Ollama ni MailHog)
docker compose --profile test up -d
```

## Variables d'environnement requises (.env)

| Variable | Description | Exemple |
|---|---|---|
| `POSTGRES_PASSWORD` | Mot de passe PostgreSQL local | `certifapp_dev` |
| `APP_JWT_SECRET` | Secret JWT (64+ chars) | `changeme_64_chars...` |
| `STRIPE_SECRET_KEY` | Clé Stripe test | `sk_test_xxx` |
| `STRIPE_WEBHOOK_SECRET` | Secret webhook Stripe | `whsec_xxx` |
| `ANTHROPIC_API_KEY` | Clé Anthropic (prod seulement) | `sk-ant-xxx` |

## Profils Docker Compose

| Profil | Services | Usage |
|---|---|---|
| `local` | Tout (PostgreSQL, Ollama, MailHog, API, Web, Adminer) | Développement complet |
| `test` | PostgreSQL test uniquement | Tests d'intégration CI |
| `prod` | PostgreSQL, API | Déploiement production |

## Première utilisation — Ollama

Au premier démarrage, Ollama télécharge automatiquement le modèle `qwen2.5-coder:7b` (~4 Go).
Ce téléchargement peut prendre 5-15 minutes selon la connexion.

```bash
# Suivre le téléchargement
docker compose logs -f ollama

# Tester Ollama manuellement
curl http://localhost:11434/api/version
```

## Ports utilisés

| Port | Service |
|---|---|
| 5432 | PostgreSQL principal |
| 5433 | PostgreSQL test |
| 8080 | API Spring Boot |
| 4200 | Angular PWA |
| 8025 | MailHog Web UI |
| 1025 | MailHog SMTP |
| 8888 | Adminer |
| 11434 | Ollama |
