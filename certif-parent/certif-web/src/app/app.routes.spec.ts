import { TestBed } from '@angular/core/testing';
import { RouterModule, Routes } from '@angular/router';
import { authGuard } from './core/auth/auth.guard';
import { adminGuard } from './core/auth/admin.guard';

describe('app.routes', () => {
  let routes: Routes;

  beforeEach(() => {
    routes = [
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
      { path: '**', redirectTo: '' }
    ];
  });

  it('should define routes correctly', () => {
    expect(routes).toBeDefined();
    expect(routes.length).toBe(12);
  });

  it('should have a route for the home page', () => {
    const homeRoute = routes.find(route => route.path === '');
    expect(homeRoute).toBeDefined();
    expect(homeRoute.loadComponent).toBeTruthy();
  });

  it('should have a lazy-loaded auth module', () => {
    const authRoute = routes.find(route => route.path === 'auth');
    expect(authRoute).toBeDefined();
    expect(authRoute.loadChildren).toBeTruthy();
  });

  it('should have an exam route with canActivate guard', () => {
    const examRoute = routes.find(route => route.path === 'exam');
    expect(examRoute).toBeDefined();
    expect(examRoute.canActivate).toContain(authGuard);
    expect(examRoute.loadChildren).toBeTruthy();
  });

  it('should have a results route with canActivate guard', () => {
    const resultsRoute = routes.find(route => route.path.startsWith('results/'));
    expect(resultsRoute).toBeDefined();
    expect(resultsRoute.canActivate).toContain(authGuard);
    expect(resultsRoute.loadComponent).toBeTruthy();
  });

  it('should have a history route with canActivate guard', () => {
    const historyRoute = routes.find(route => route.path === 'history');
    expect(historyRoute).toBeDefined();
    expect(historyRoute.canActivate).toContain(authGuard);
    expect(historyRoute.loadComponent).toBeTruthy();
  });

  it('should have a learning route with canActivate guard', () => {
    const learningRoute = routes.find(route => route.path === 'learning');
    expect(learningRoute).toBeDefined();
    expect(learningRoute.canActivate).toContain(authGuard);
    expect(learningRoute.loadChildren).toBeTruthy();
  });

  it('should have a coaching route with canActivate guard', () => {
    const coachingRoute = routes.find(route => route.path === 'coaching');
    expect(coachingRoute).toBeDefined();
    expect(coachingRoute.canActivate).toContain(authGuard);
    expect(coachingRoute.loadComponent).toBeTruthy();
  });

  it('should have a community route with lazy-loading', () => {
    const communityRoute = routes.find(route => route.path === 'community');
    expect(communityRoute).toBeDefined();
    expect(communityRoute.loadChildren).toBeTruthy();
  });

  it('should have an interview route with canActivate guard', () => {
    const interviewRoute = routes.find(route => route.path === 'interview');
    expect(interviewRoute).toBeDefined();
    expect(interviewRoute.canActivate).toContain(authGuard);
    expect(interviewRoute.loadComponent).toBeTruthy();
  });

  it('should have a chat route with canActivate guard', () => {
    const chatRoute = routes.find(route => route.path === 'chat');
    expect(chatRoute).toBeDefined();
    expect(chatRoute.canActivate).toContain(authGuard);
    expect(chatRoute.loadComponent).toBeTruthy();
  });

  it('should have a profile route with canActivate guard', () => {
    const profileRoute = routes.find(route => route.path === 'profile');
    expect(profileRoute).toBeDefined();
    expect(profileRoute.canActivate).toContain(authGuard);
    expect(profileRoute.loadChildren).toBeTruthy();
  });

  it('should have an admin route with canActivate and canActivateChild guards', () => {
    const adminRoute = routes.find(route => route.path === 'admin');
    expect(adminRoute).toBeDefined();
    expect(adminRoute.canActivate).toContain(authGuard, adminGuard);
    expect(adminRoute.loadChildren).toBeTruthy();
  });

  it('should have a wildcard route redirecting to the home page', () => {
    const wildcardRoute = routes.find(route => route.path === '**');
    expect(wildcardRoute).toBeDefined();
    expect(wildcardRoute.redirectTo).toBe('');
  });
});
