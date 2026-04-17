import {TestBed} from '@angular/core/testing';
import {HttpErrorResponse, HttpHandlerFn, HttpInterceptorFn, HttpRequest} from '@angular/common/http';
import {AuthService} from '../auth.service';

describe('Auth Interceptor', () => {
    let authService: AuthService;
    let interceptor: HttpInterceptorFn;

    beforeEach(() => {
        TestBed.configureTestingModule({
            providers: [
                {provide: AuthService, useClass: MockAuthService}
            ]
        });

        authService = TestBed.inject(AuthService);
        interceptor = authInterceptor(inject(HttpRequest), inject(HttpHandlerFn));
    });

    it('should attach Bearer token to request', () => {
        const req = new HttpRequest('GET', 'https://example.com/api/resource');
        const handler = jasmine.createSpyObj<HttpHandlerFn>('HttpHandler', ['handle']);
        interceptor(req, handler).subscribe(() => {
        });
        expect(handler.handle).toHaveBeenCalledWith(jasmine.objectContaining({headers: {Authorization: `Bearer ${authService.getAccessToken()}`}}));
    });

    it('should skip auth endpoints', () => {
        const req = new HttpRequest('GET', 'https://example.com/api/auth/login');
        const handler = jasmine.createSpyObj<HttpHandlerFn>('HttpHandler', ['handle']);
        interceptor(req, handler).subscribe(() => {
        });
        expect(handler.handle).toHaveBeenCalledWith(req);
    });

    it('should attempt token refresh on 401 error and retry request', () => {
        const req = new HttpRequest('GET', 'https://example.com/api/resource');
        const handler = jasmine.createSpyObj<HttpHandlerFn>('HttpHandler', ['handle']);
        authService.refreshToken = jasmine.createSpy().and.returnValue(Promise.resolve());
        interceptor(req, handler).subscribe(() => {
        });
        expect(authService.refreshToken).toHaveBeenCalled();
    });

    it('should log out user if token refresh fails', () => {
        const req = new HttpRequest('GET', 'https://example.com/api/resource');
        const handler = jasmine.createSpyObj<HttpHandlerFn>('HttpHandler', ['handle']);
        authService.refreshToken = jasmine.createSpy().and.returnValue(Promise.reject(new Error('Refresh failed')));
        interceptor(req, handler).subscribe(() => {
        });
        expect(authService.logout).toHaveBeenCalled();
    });

    it('should rethrow error if refresh fails and logout', () => {
        const req = new HttpRequest('GET', 'https://example.com/api/resource');
        const handler = jasmine.createSpyObj<HttpHandlerFn>('HttpHandler', ['handle']);
        authService.refreshToken = jasmine.createSpy().and.returnValue(Promise.reject(new Error('Refresh failed')));
        interceptor(req, handler).subscribe(
            () => {
            },
            error => {
                expect(error.message).toBe('Refresh failed');
            }
        );
    });

    it('should rethrow original error if token is invalid and not refreshable', () => {
        const req = new HttpRequest('GET', 'https://example.com/api/resource');
        const handler = jasmine.createSpyObj<HttpHandlerFn>('HttpHandler', ['handle']);
        authService.refreshToken = jasmine.createSpy().and.returnValue(Promise.reject(new HttpErrorResponse({status: 401})));
        interceptor(req, handler).subscribe(
            () => {
            },
            error => {
                expect(error.status).toBe(401);
            }
        );
    });
});

class MockAuthService {
    getAccessToken(): string {
        return 'mock-access-token';
    }

    refreshToken(): Promise<void> {
        return new Promise(resolve => resolve());
    }

    logout(): void {
    }
}

