import {TestBed} from '@angular/core/testing';
import {Routes} from '@angular/router';
import {AUTH_ROUTES} from './auth.routes';

describe('AUTH_ROUTES', () => {
    let routes: Routes;

    beforeEach(() => {
        TestBed.configureTestingModule({
            providers: [
                {provide: Routes, useValue: AUTH_ROUTES}
            ]
        });
        routes = TestBed.inject(Routes);
    });

    it('should have a route for "login"', () => {
        const loginRoute = routes.find(route => route.path === 'login');
        expect(loginRoute).toBeTruthy();
        expect(loginRoute?.loadComponent).toBeDefined();
    });

    it('should have a route for "register"', () => {
        const registerRoute = routes.find(route => route.path === 'register');
        expect(registerRoute).toBeTruthy();
        expect(registerRoute?.loadComponent).toBeDefined();
    });

    it('should redirect an empty path to "login"', () => {
        const emptyPathRoute = routes.find(route => route.path === '');
        expect(emptyPathRoute).toBeTruthy();
        expect(emptyPathRoute?.redirectTo).toBe('login');
        expect(emptyPathRoute?.pathMatch).toBe('full');
    });

    it('should not have a route for undefined path', () => {
        const undefinedPathRoute = routes.find(route => route.path === 'undefined');
        expect(undefinedPathRoute).toBeFalsy();
    });
});