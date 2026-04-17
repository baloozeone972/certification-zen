# Configuration SonarQube — GitHub Actions

## Secrets requis (Settings > Secrets and variables > Actions)

| Secret | Description |
|---|---|
| `SONAR_TOKEN` | Token SonarQube / SonarCloud |
| `SONAR_HOST_URL` | `https://sonarcloud.io` ou URL self-hosted |
| `APP_JWT_SECRET_TEST` | Secret JWT tests (256 bits minimum) |

## SonarCloud (gratuit, open source)

1. https://sonarcloud.io — importer `baloozeone972/certification-zen`
2. Créer : `certifapp-backend` et `certifapp-frontend`
3. My Account > Security > Generate Token
4. Ajouter `sonar.organization=baloozeone972` dans sonar-project.properties

## Bloquer les PRs si Quality Gate KO

Settings > Branches > `develop` > Branch protection rules :
- [x] Require status checks: `Backend — SonarQube` + `Frontend — SonarQube`

## Quality Gate recommandé

| Métrique (nouveau code) | Seuil |
|---|---|
| Coverage | >= 70% |
| Duplicated lines | <= 3% |
| Security / Reliability / Maintainability | A |
| Hotspots reviewed | 100% |
