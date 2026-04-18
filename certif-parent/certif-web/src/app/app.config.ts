import {TestBed} from '@angular/core/testing';
import {ApplicationConfig, isDevMode} from '@angular/core';
import {PreloadAllModules, provideRouter, withPreloading} from '@angular/router';
import {provideHttpClient, withInterceptors} from '@angular/common/http';
import {provideAnimations} from '@angular/platform-browser/animations';
import {provideServiceWorker} from '@angular/service-worker';
import {routes} from './app.routes';
import {authInterceptor} from './core/auth/auth.interceptor';

describe('appConfig', () => {
    let appConfig: ApplicationConfig;

    beforeEach(() => {
        TestBed.configureTestingModule({
            providers: [
                provideRouter(routes, withPreloading(PreloadAllModules)),
                provideHttpClient(withInterceptors([authInterceptor])),
                provideAnimations(),
                provideServiceWorker('ngsw-worker.js', {
                    enabled: !isDevMode(),
                    registrationStrategy: 'registerWhenStable:30000'
                }),
            ]
        });
        appConfig = TestBed.inject(ApplicationConfig);
    });

    it('should provide router with preloading', () => {
        expect(appConfig.providers).toContainEqual(provideRouter(routes, withPreloading(PreloadAllModules)));
    });

    it('should provide HTTP client with JWT interceptor', () => {
        expect(appConfig.providers).toContainEqual(provideHttpClient(withInterceptors([authInterceptor])));
    });

    it('should provide animations', () => {
        expect(appConfig.providers).toContainEqual(provideAnimations());
    });

    it('should provide service worker with registration strategy', () => {
        expect(appConfig.providers).toContainEqual(provideServiceWorker('ngsw-worker.js', {
            enabled: !isDevMode(),
            registrationStrategy: 'registerWhenStable:30000'
        }));
    });
});