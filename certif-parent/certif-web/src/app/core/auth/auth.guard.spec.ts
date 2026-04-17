import {TestBed} from '@angular/core/testing';
import {CanActivateFn, Router} from '@angular/router';
import {AuthService} from './auth.service';

describe('AuthGuard', () => {
    let guard: CanActivateFn;
    let authService: AuthService;
    let router: Router;

    beforeEach(() => {
        TestBed.configureTestingModule({
            providers: [
                {provide: AuthService, useValue: {}},
                {provide: Router, useValue: {}}
            ]
        });

        guard = TestBed.inject(CanActivateFn);
        authService = TestBed.inject(AuthService);
        router = TestBed.inject(Router);
    });

    it('should return true if the user is authenticated', () => {
        spyOn(authService, 'isAuthenticated').and.returnValue(true);

        expect(guard({} as any, {} as any)).toBeTrue();
    });

    it('should redirect to /auth/login and pass returnUrl when the user is not authenticated', () => {
        const returnUrl = '/some-route';
        spyOn(authService, 'isAuthenticated').and.returnValue(false);
        const navigateSpy = spyOn(router, 'createUrlTree');

        guard({url: returnUrl} as any, {} as any);

        expect(navigateSpy).toHaveBeenCalledWith(['/auth/login'], {queryParams: {returnUrl}});
    });

    it('should handle error when AuthService.isAuthenticated throws an exception', () => {
        const error = new Error('Authentication check failed');
        spyOn(authService, 'isAuthenticated').and.throwError(error);
        const navigateSpy = spyOn(router, 'createUrlTree');

        expect(() => guard({} as any, {} as any)).toThrow(error);
        expect(navigateSpy).not.toHaveBeenCalled();
    });
});

