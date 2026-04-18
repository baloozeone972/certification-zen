import {TestBed} from '@angular/core/testing';
import {HttpClientTestingModule, HttpTestingController} from '@angular/common/http/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {AuthService} from './auth.service';
import {environment} from '../../../environments/environment';
import {TokenResponse, User} from '../models/user.models';

describe('AuthService', () => {
    let service: AuthService;
    let httpMock: HttpTestingController;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [HttpClientTestingModule, RouterTestingModule],
            providers: [
                AuthService,
                {provide: environment, useValue: {apiUrl: 'http://localhost:3000'}}
            ]
        });
        service = TestBed.inject(AuthService);
        httpMock = TestBed.inject(HttpTestingController);
    });

    afterEach(() => {
        httpMock.verify();
    });

    it('should be created', () => {
        expect(service).toBeTruthy();
    });

    describe('register', () => {
        it('should register a new account and auto-login', async () => {
            const email = 'test@example.com';
            const password = 'password123';
            const user: User = {
                id: '1',
                email,
                role: 'USER',
                subscriptionTier: 'FREE',
                locale: 'fr',
                timezone: 'Europe/Paris',
                createdAt: ''
            };
            const tokenResponse: TokenResponse = {
                accessToken: 'access_token',
                refreshToken: 'refresh_token'
            };

            service.register(email, password).subscribe(response => {
                expect(response.data).toEqual(tokenResponse);
                expect(service.currentUser()).toEqual(user);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/auth/register`);
            expect(req.request.method).toBe('POST');
            req.flush({data: tokenResponse});
        });
    });

    describe('login', () => {
        it('should authenticate with email/password', async () => {
            const email = 'test@example.com';
            const password = 'password123';
            const user: User = {
                id: '1',
                email,
                role: 'USER',
                subscriptionTier: 'FREE',
                locale: 'fr',
                timezone: 'Europe/Paris',
                createdAt: ''
            };
            const tokenResponse: TokenResponse = {
                accessToken: 'access_token',
                refreshToken: 'refresh_token'
            };

            service.login(email, password).subscribe(response => {
                expect(response.data).toEqual(tokenResponse);
                expect(service.currentUser()).toEqual(user);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/auth/login`);
            expect(req.request.method).toBe('POST');
            req.flush({data: tokenResponse});
        });
    });

    describe('refreshToken', () => {
        it('should refresh access token using stored refresh token', async () => {
            const refreshToken = 'refresh_token';
            localStorage.setItem('certifapp_refresh', refreshToken);
            const user: User = {
                id: '1',
                email: 'test@example.com',
                role: 'USER',
                subscriptionTier: 'FREE',
                locale: 'fr',
                timezone: 'Europe/Paris',
                createdAt: ''
            };
            const tokenResponse: TokenResponse = {
                accessToken: 'new_access_token',
                refreshToken: 'new_refresh_token'
            };

            service.refreshToken().subscribe(response => {
                expect(response.data).toEqual(tokenResponse);
                expect(service.currentUser()).toEqual(user);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/auth/refresh`);
            expect(req.request.method).toBe('POST');
            req.flush({data: tokenResponse});
        });

        it('should handle refresh token error and logout', async () => {
            localStorage.setItem('certifapp_refresh', 'refresh_token');

            service.refreshToken().subscribe({
                error: () => {
                    expect(service.currentUser()).toBeNull();
                    expect(localStorage.getItem('certifapp_access')).toBeNull();
                    expect(localStorage.getItem('certifapp_refresh')).toBeNull();
                }
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/auth/refresh`);
            expect(req.request.method).toBe('POST');
            req.error(new ErrorEvent('Network error'));
        });
    });

    describe('logout', () => {
        it('should clear tokens and navigate to home', async () => {
            localStorage.setItem('certifapp_access', 'access_token');
            localStorage.setItem('certifapp_refresh', 'refresh_token');

            service.logout();

            expect(service.currentUser()).toBeNull();
            expect(localStorage.getItem('certifapp_access')).toBeNull();
            expect(localStorage.getItem('certifapp_refresh')).toBeNull()
        )
            ;
        });
    });

    describe('getAccessToken', () => {
        it('should return the stored access token', async () => {
            localStorage.setItem('certifapp_access', 'access_token');

            expect(service.getAccessToken()).toBe('access_token');
        });

        it('should return null if no access token is stored', async () => {
            expect(service.getAccessToken()).toBeNull();
        });
    });
});