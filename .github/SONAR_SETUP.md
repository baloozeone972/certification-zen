# Configuration SonarQube — GitHub Actions

## Secrets requis (Settings > Secrets and variables > Actions)

| Secret | Description |
|---|---|
| `SONAR_TOKEN` | Token SonarQube / SonarCloud |
| `SONAR_HOST_URL` | `https://sonarcloud.io` ou URL self-hosted |
| `APP_JWT_SECRET_TEST` | Secret JWT tests (256 bits minimum) |

## Option A — SonarCloud (recommandé, gratuit open source)

1. Aller sur https://sonarcloud.io
2. Importer le repo `baloozeone972/certification-zen`
3. Créer les projets `certifapp-backend` et `certifapp-frontend`
4. My Account > Security > Generate Token → copier dans `SONAR_TOKEN`
5. `SONAR_HOST_URL` = `https://sonarcloud.io`
6. Ajouter `sonar.organization=baloozeone972` dans les deux sonar-project.properties

## Option B — SonarQube self-hosted (Docker)

```bash
docker run -d --name sonarqube -p 9000:9000 sonarqube:community
# Login : http://localhost:9000  admin/admin
```

## Bloquer les PRs si Quality Gate KO

Settings > Branches > `develop` > Branch protection rules :
- [x] Require status checks to pass before merging
  - `Backend — SonarQube (bloque PR si Quality Gate KO)`
  - `Frontend — SonarQube (bloque PR si Quality Gate KO)`

## Quality Gate recommandé

| Métrique (nouveau code) | Seuil |
|---|---|
| Coverage | >= 70% |
| Duplicated lines | <= 3% |
| Security rating | A |
| Reliability rating | A |
| Maintainability rating | A |
| Security hotspots reviewed | 100% |

## Note sur le scope "workflows"

Pour que le fichier `.github/workflows/ci.yml` soit créé automatiquement
via l'API GitHub, le token PAT doit avoir le scope **`workflow`** activé
(en plus de `repo`).

Créer un token avec : ✅ `repo` + ✅ `workflow`
puis relancer la commande de déploiement.
