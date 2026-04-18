import {TestBed} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {AuthService} from './auth.service';
import {adminGuard} from './admin.guard';

describe('adminGuard', () => {
    let authService: AuthService;
    let router: Router;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [RouterTestingModule],
            providers: [
                {provide: AuthService, useValue: {isAdmin: () => true}}
            ]
        });

        authService = TestBed.inject(AuthService);
        router = TestBed.inject(Router);
    });

    it('should return true if user is admin', async () => {
        // Arrange
        const guard = TestBed.inject(adminGuard);

        // Act
        const result = await guard();

        // Assert
        expect(result).toBe(true);
    });

    it('should redirect to root if user is not admin', async () => {
        // Arrange
        const guard = TestBed.inject(adminGuard);
        lenient().when(authService.isAdmin()).thenReturn(false);

        // Act
        const result = await guard();

        // Assert
        expect(result).toEqual(['/']);
    });
});