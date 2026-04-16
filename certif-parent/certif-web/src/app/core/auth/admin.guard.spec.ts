```typescript
import { TestBed } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { AuthService } from '../auth.service';
import { adminGuard } from './admin.guard';

describe('adminGuard', () => {
  let authService: AuthService;
  let router: any; // Mocked Router
  let guard: CanActivateFn;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [RouterTestingModule],
      providers: [
        { provide: AuthService, useValue: { isAdmin: null } }
      ]
    });

    authService = TestBed.inject(AuthService);
    router = TestBed.inject(Router);
    guard = adminGuard;
  });

  it('should return true if the user is an admin', () => {
    spyOn(authService, 'isAdmin').and.returnValue(true);

    const result = guard();

    expect(result).toBe(true);
  });

  it('should redirect to root if the user is not an admin', () => {
    spyOn(authService, 'isAdmin').and.returnValue(false);
    const navigateSpy = spyOn(router, 'createUrlTree').and.returnValue(['/']);

    const result = guard();

    expect(navigateSpy).toHaveBeenCalledWith(['']);
    expect(result).toEqual(['/']);
  });

  it('should handle null/undefined isAdmin return value', () => {
    authService.isAdmin = undefined;
    const navigateSpy = spyOn(router, 'createUrlTree').and.returnValue(['/']);

    const result = guard();

    expect(navigateSpy).toHaveBeenCalledWith(['']);
    expect(result).toEqual(['/']);
  });
});
```
