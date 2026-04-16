```typescript
import { TestBed, getTestBed } from '@angular/core/testing';
import { RouterModule, Routes } from '@angular/router';

describe('ExamRoutes', () => {
  let injector: TestBed;
  let routes: Routes;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        {
          provide: RouterModule,
          useValue: { forRoot: () => ({}) }
        }
      ]
    });
    injector = getTestBed();
    routes = TestBed.inject(RouterModule).routes as Routes;
  });

  it('should contain the root route', () => {
    const route = routes.find(r => r.path === '');
    expect(route).toBeTruthy();
    expect(route.loadComponent).toBeDefined();
  });

  it('should contain the session route', () => {
    const route = routes.find(r => r.path === 'session/:sessionId');
    expect(route).toBeTruthy();
    expect(route.loadComponent).toBeDefined();
  });

  it('should not allow empty path for session route', () => {
    try {
      const route = routes.find(r => r.path === 'session/');
      fail('Expected an error to be thrown');
    } catch (error) {
      expect(error).toBeInstanceOf(Error);
      expect(error.message).toContain('Path cannot be empty');
    }
  });

  it('should not allow missing sessionId in session route', () => {
    try {
      const route = routes.find(r => r.path === 'session');
      fail('Expected an error to be thrown');
    } catch (error) {
      expect(error).toBeInstanceOf(Error);
      expect(error.message).toContain('SessionId parameter is required');
    }
  });

  it('should handle invalid path', () => {
    const route = routes.find(r => r.path === 'invalid-path');
    expect(route).toBeFalsy();
  });
});
```
