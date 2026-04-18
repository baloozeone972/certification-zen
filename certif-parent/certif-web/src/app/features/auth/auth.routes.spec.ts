import { TestBed, getTestBed } from '@angular/core/testing';
import { Routes } from '@angular/router';
import { AUTH_ROUTES } from './auth.routes';

describe('AUTH_ROUTES', () => {
  let testBed: TestBed;

  beforeEach(() => {
    testBed = getTestBed();
  });

  it('should have a route for "login"', () => {
    const routes = testBed.inject(Routes);
    const loginRoute = routes.find(route => route.path === 'login');
    expect(loginRoute).toBeTruthy();
    expect(loginRoute?.loadComponent).toBeDefined();
  });

  it('should have a route for "register"', () => {
    const routes = testBed.inject(Routes);
    const registerRoute = routes.find(route => route.path === 'register');
    expect(registerRoute).toBeTruthy();
    expect(registerRoute?.loadComponent).toBeDefined();
  });

  it('should redirect an empty path to "login"', () => {
    const routes = testBed.inject(Routes);
    const emptyPathRoute = routes.find(route => route.path === '');
    expect(emptyPathRoute).toBeTruthy();
    expect(emptyPathRoute?.redirectTo).toBe('login');
    expect(emptyPathRoute?.pathMatch).toBe('full');
  });

  it('should not have a route for undefined path', () => {
    const routes = testBed.inject(Routes);
    const undefinedPathRoute = routes.find(route => route.path === 'undefined');
    expect(undefinedPathRoute).toBeFalsy();
  });
});
