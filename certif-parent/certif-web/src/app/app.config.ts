// certif-parent/certif-web/src/app/app.config.ts
import { ApplicationConfig, importProvidersFrom } from '@angular/core';
import { provideRouter, withPreloading, PreloadAllModules } from '@angular/router';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { provideAnimations } from '@angular/platform-browser/animations';
import { provideServiceWorker } from '@angular/service-worker';
import { isDevMode } from '@angular/core';
import { routes } from './app.routes';
import { authInterceptor } from './core/auth/auth.interceptor';

/**
 * Root application configuration — bootstrapped in main.ts.
 * Uses the new standalone API (Angular 18 — no NgModule).
 */
export const appConfig: ApplicationConfig = {
  providers: [
    // Router with lazy loading + preloading all modules
    provideRouter(routes, withPreloading(PreloadAllModules)),

    // HTTP client with JWT interceptor
    provideHttpClient(withInterceptors([authInterceptor])),

    // Animations for transitions
    provideAnimations(),

    // Service Worker (PWA) — disabled in dev mode
    provideServiceWorker('ngsw-worker.js', {
      enabled: !isDevMode(),
      registrationStrategy: 'registerWhenStable:30000'
    }),
  ]
};
