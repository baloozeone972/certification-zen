// certif-parent/certif-web/src/app/app.routes.ts
import {Routes} from '@angular/router';
import {authGuard} from './core/auth/auth.guard';
import {adminGuard} from './core/auth/admin.guard';

/**
 * Root route configuration with lazy loading per feature.
 * All feature modules load on demand — only the home page is eagerly loaded.
 */
export const routes: Routes = [
    {
        path: '',
        loadComponent: () =>
            import('./features/home/home.component').then(m => m.HomeComponent)
    },
    {
        path: 'auth',
        loadChildren: () =>
            import('./features/auth/auth.routes').then(m => m.AUTH_ROUTES)
    },
    {
        path: 'exam',
        canActivate: [authGuard],
        loadChildren: () =>
            import('./features/exam/exam.routes').then(m => m.EXAM_ROUTES)
    },
    {
        path: 'results/:sessionId',
        canActivate: [authGuard],
        loadComponent: () =>
            import('./features/results/results.component').then(m => m.ResultsComponent)
    },
    {
        path: 'history',
        canActivate: [authGuard],
        loadComponent: () =>
            import('./features/history/history.component').then(m => m.HistoryComponent)
    },
    {
        path: 'learning',
        canActivate: [authGuard],
        loadChildren: () =>
            import('./features/learning/learning.routes').then(m => m.LEARNING_ROUTES)
    },
    {
        path: 'coaching',
        canActivate: [authGuard],
        loadComponent: () =>
            import('./features/coaching/coach-dashboard.component').then(m => m.CoachDashboardComponent)
    },
    {
        path: 'community',
        loadChildren: () =>
            import('./features/community/community.routes').then(m => m.COMMUNITY_ROUTES)
    },
    {
        path: 'interview',
        canActivate: [authGuard],
        loadComponent: () =>
            import('./features/interview/interview.component').then(m => m.InterviewComponent)
    },
    {
        path: 'chat',
        canActivate: [authGuard],
        loadComponent: () =>
            import('./features/chat/chat.component').then(m => m.ChatComponent)
    },
    {
        path: 'profile',
        canActivate: [authGuard],
        loadChildren: () =>
            import('./features/profile/profile.routes').then(m => m.PROFILE_ROUTES)
    },
    {
        path: 'admin',
        canActivate: [authGuard, adminGuard],
        loadChildren: () =>
            import('./features/admin/admin.routes').then(m => m.ADMIN_ROUTES)
    },
    {path: '**', redirectTo: ''}
];
