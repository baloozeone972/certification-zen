import {TestBed} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {AuthService} from './auth.service';
import {Router} from '@angular/router';

describe('AuthGuard', () => {
    let authService: AuthService;
    let router: Router;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [RouterTestingModule],
            providers: [
                AuthService,
                {provide: Router, useValue: {createUrlTree: jasmine.createSpy('createUrlTree')}}
            ]
        });

        authService = TestBed.inject(AuthService);
        router = TestBed.inject(Router);
    });

    it('should return true if user is authenticated', () => {
        // Arrange
        lenient().when(authService.isAuthenticated()).thenReturn(true);

        // Act
        const result = authGuard({}, {});

        // Assert
        expect(result).toBe(true);
    });

    it('should redirect to /auth/login if user is not authenticated', async () => {
        // Arrange
        lenient().when(authService.isAuthenticated()).thenReturn(false);
        const routerSpy = spyOn(router, 'createUrlTree');

        // Act
        await authGuard({}, {});

        // Assert
        expect(routerSpy).toHaveBeenCalledWith(['/auth/login'], {queryParams: {returnUrl: ''}});
    });
});