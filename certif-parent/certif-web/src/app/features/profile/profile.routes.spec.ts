import { TestBed } from '@angular/core/testing';
import { Routes } from '@angular/router';
import { PROFILE_ROUTES } from './profile.routes';

describe('PROFILE_ROUTES', () => {
  let routes: Routes;

  beforeEach(() => {
    routes = PROFILE_ROUTES;
  });

  it('should have a route with path "" and loadComponent for ProfileComponent', () => {
    expect(routes).toContain({
      path: '',
      loadComponent: jasmine.any(Function)
    });
  });

  it('loadComponent should correctly import and return ProfileComponent', async () => {
    const component = await routes[0].loadComponent();
    expect(component.name).toBe('ProfileComponent');
  });

  it('should handle error cases when importing ProfileComponent fails', async () => {
    spyOn(routes[0], 'loadComponent').and.throwError(new Error('Failed to load component'));

    try {
      await routes[0].loadComponent();
      fail('Expected an error to be thrown');
    } catch (error) {
      expect(error.message).toBe('Failed to load component');
    }
  });
});
