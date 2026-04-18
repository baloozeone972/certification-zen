import {TestBed} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {AuthService} from './auth.service';
import {AdminGuard, adminGuard} from './admin.guard';
import {Router} from "@angular/router";

describe('AdminGuard', () => {
    let authService: AuthService;
    let router: Router;
    let guard: AdminGuard;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [RouterTestingModule],
            providers: [
                AuthService,
                {provide: Router, useValue: {createUrlTree: jest.fn()}}
            ]
        });

        authService = TestBed.inject(AuthService);
        router = TestBed.inject(Router);
        guard = new AdminGuard(authService, router);
    });

    it('should return true if the user is an admin', () => {
        spyOn(authService, 'isAdmin').and.returnValue(true);

        const result = guard.canActivate();

        expect(result).toBe(true);
    });

    it('should redirect to root if the user is not an admin', () => {
        spyOn(authService, 'isAdmin').and.returnValue(false);
        const navigateSpy = spyOn(router, 'createUrlTree');

        guard.canActivate();

        expect(navigateSpy).toHaveBeenCalledWith(['/']);
    });

    it('should handle null/undefined isAdmin return value', () => {
        authService.isAdmin = undefined;
        const navigateSpy = spyOn(router, 'createUrlTree');

        guard.canActivate();

        expect(navigateSpy).toHaveBeenCalledWith(['/']);
    });
});