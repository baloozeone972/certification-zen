# certif-web

Module **Angular 18 PWA** — application web progressive.

## Démarrage

```bash
cd certif-parent/certif-web
npm install
npm start
# → http://localhost:4200
```

## Architecture

- **Standalone Components** (pas de NgModule)
- **Signals** Angular 18 pour tous les états réactifs
- **Lazy loading** sur toutes les routes feature
- **OnPush** ChangeDetection partout
- **PWA** Service Worker avec cache stratégies différenciées

## Features

| Route | Composant | Auth |
|---|---|---|
| `/` | HomeComponent | Public |
| `/auth/login` | LoginComponent | Public |
| `/exam` | ExamSetupComponent | ✅ |
| `/results/:id` | ResultsComponent | ✅ |
| `/history` | HistoryComponent | ✅ |
| `/learning` | LearningDashboard | ✅ |
| `/coaching` | CoachDashboard | ✅ PRO |
| `/community` | CommunityComponent | Public |
| `/chat` | ChatComponent | ✅ |
| `/interview` | InterviewComponent | ✅ PRO |
| `/profile` | ProfileComponent | ✅ |

## Build production

```bash
npm run build
# → dist/certif-web/
```
