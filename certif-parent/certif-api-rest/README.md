# certif-api-rest

Module **API REST** — Spring Boot 3, point d'entrée de l'application.

## Démarrage

```bash
cd certif-parent
cp .env.exemple .env
# Éditer .env (JWT_SECRET, POSTGRES_PASSWORD)
mvn spring-boot:run -pl certif-api-rest -Dspring.profiles.active=local
```

## Documentation API

- Swagger UI : http://localhost:8080/swagger-ui.html
- OpenAPI JSON : http://localhost:8080/v3/api-docs
- Actuator health : http://localhost:8080/actuator/health

## Profils Spring

| Profil | Usage | Base de données |
|---|---|---|
| `local` | Développement avec docker-compose | PostgreSQL localhost:5432 |
| `test` | Tests Testcontainers | PostgreSQL localhost:5433 |
| `prod` | Production Supabase | PostgreSQL Supabase |

## Sécurité

- JWT HS512 (access 1h, refresh 7j)
- Rate limiting sur `/auth/**` et `/exam/**`
- CORS restreint en prod (liste blanche)
- Stripe webhook : vérification HMAC-SHA256 native
