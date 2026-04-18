# Configuration des secrets GitHub Actions

## Étapes pour activer la CI/CD complète

### 1. Configurer les secrets

Aller sur : https://github.com/baloozeone972/certification-zen/settings/secrets/actions

Ajouter les 3 secrets suivants :

| Nom | Valeur | Comment l'obtenir |
|---|---|---|
| `SONAR_TOKEN` | `sqp_xxx...` | SonarCloud → My Account → Security → Generate Token |
| `SONAR_HOST_URL` | `https://sonarcloud.io` | Valeur fixe |
| `APP_JWT_SECRET_TEST` | `PbKltSln2oFDV3H6N1pMVs8u4uT0KZp9Bd98HLhV_hLM49IMu_lru-gXRsmkphkc7x7SczBczgU5sbmHywJR0A` | Déjà généré |

### 2. Créer les projets SonarCloud

1. Aller sur https://sonarcloud.io/login (login avec GitHub)
2. Cliquer "+" → "Analyze new project"
3. Sélectionner `baloozeone972/certification-zen`
4. Créer les deux projets :
   - Project Key : `certifapp-backend`
   - Project Key : `certifapp-frontend`
5. Organization : `baloozeone972`

### 3. Activer le blocage des PRs

Settings → Branches → `develop` → Branch protection rules :
- ✅ Require status checks to pass before merging
- Ajouter : `Backend — SonarQube (bloque PR si Quality Gate KO)`
- Ajouter : `Frontend — SonarQube (bloque PR si Quality Gate KO)`

### 4. Vérifier que la CI fonctionne

Après le merge de la prochaine PR, vérifier :
https://github.com/baloozeone972/certification-zen/actions

### Quality Gate configuré

| Métrique (nouveau code) | Seuil |
|---|---|
| Coverage | ≥ 70% |
| Duplications | ≤ 3% |
| Security / Reliability / Maintainability | A |
| Hotspots reviewed | 100% |
