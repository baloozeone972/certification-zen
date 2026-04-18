# certif-application

Module **use cases** — orchestre le domaine, zéro logique métier ici.

## Rôle

Implémente les interfaces `port.input.*` définies dans `certif-domain`.
Coordonne les ports output (repositories, services) sans jamais contenir de règles métier.

## Règles strictes

- ❌ Aucun import `org.springframework.data.*`
- ❌ Aucun import `jakarta.persistence.*`
- ✅ Les transactions sont gérées dans `certif-infrastructure` (pas ici)
- ✅ Les DTOs applicatifs sont des **Records Java 21**
- ✅ BCrypt injecté via `Function<String, String>` (pas de Spring Security ici)

## Lancer les tests

```bash
cd certif-parent
mvn test -pl certif-application
```
