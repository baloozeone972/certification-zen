# certif-domain

Module **domaine métier** — Java pur, zéro dépendance framework.

## Rôle dans l'architecture hexagonale

```
certif-domain ← certif-application ← certif-infrastructure
                                   ← certif-api-rest
                                   ← certif-ai
```

Le domain ne dépend de rien. Tous les autres modules dépendent de lui.

## Contenu

| Package | Contenu |
|---|---|
| `domain.model.*` | Records Java 21 (entités domain) |
| `domain.service.*` | Services domain purs (ScoringService, SM2AlgorithmService…) |
| `domain.port.input.*` | Interfaces use cases (ports entrants) |
| `domain.port.output.*` | Interfaces repositories (ports sortants) |
| `domain.exception.*` | Exceptions métier typées |

## Règles strictes

- ❌ Aucun import `org.springframework.*`
- ❌ Aucun import `jakarta.persistence.*`
- ✅ Java 21 uniquement (Records, Pattern Matching, Sealed Classes)
- ✅ Invariants défendus dans les constructeurs compacts des Records

## Lancer les tests

```bash
cd certif-parent
mvn test -pl certif-domain
```
