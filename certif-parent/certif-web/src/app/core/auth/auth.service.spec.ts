import { TestBed, getTestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { User, TokenResponse, ApiResponse } from '../models/user.models';

describe('AuthService', () => {
  let service: AuthService;
  let httpMock: HttpTestingController;
  let routerSpy: jasmine.SpyObj<Router>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule],
      providers: [AuthService]
    });

    service = TestBed.inject(AuthService);
    httpMock = TestBed.inject(HttpTestingController);
    routerSpy = jasmine.createSpyObj('Router', ['navigate']);
    (service as any).router = routerSpy;
  });

  afterEach(() => {
    httpMock.verify();
  });

  describe('register', () => {
    it('should register a new user and login', () => {
      const email = 'test@example.com';
      const password = 'password123';

      service.register(email, password).subscribe();

      const req = httpMock.expectOne(`${environment.apiUrl}/auth/register`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ email, password, locale: 'fr', timezone: 'Europe/Paris' });

      const tokenResponse: TokenResponse = { accessToken: 'access_token', refreshToken: 'refresh_token' };
      req.flush({ data: tokenResponse } as ApiResponse<TokenResponse>);

      expect(localStorage.getItem('certifapp_access')).toBe('access_token');
      expect(localStorage.getItem('certifapp_refresh')).toBe('refresh_token');
      expect(service.currentUser()).toEqual({
        id: '',
        email: '',
        role: 'USER',
        subscriptionTier: 'FREE',
        locale: 'fr',
        timezone: 'Europe/Paris',
        createdAt: ''
      });
    });

    it('should handle registration error', () => {
      const email = 'test@example.com';
      const password = 'password123';

      service.register(email, password).subscribe(
        () => fail('Expected an error to be thrown'),
        (error) => expect(error).toBeTruthy()
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/auth/register`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ email, password, locale: 'fr', timezone: 'Europe/Paris' });

      req.flush({ error: 'Invalid credentials' }, { status: 401, statusText: 'Unauthorized' });
    });
  });

  describe('login', () => {
    it('should login and update currentUser', () => {
      const email = 'test@example.com';
      const password = 'password123';

      service.login(email, password).subscribe();

      const req = httpMock.expectOne(`${environment.apiUrl}/auth/login`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ email, password });

      const tokenResponse: TokenResponse = { accessToken: 'access_token', refreshToken: 'refresh_token' };
      req.flush({ data: tokenResponse } as ApiResponse<TokenResponse>);

      expect(localStorage.getItem('certifapp_access')).toBe('access_token');
      expect(localStorage.getItem('certifapp_refresh')).toBe('refresh_token');
      expect(service.currentUser()).toEqual({
        id: '',
        email: '',
        role: 'USER',
        subscriptionTier: 'FREE',
        locale: 'fr',
        timezone: 'Europe/Paris',
        createdAt: ''
      });
    });

    it('should handle login error', () => {
      const email = 'test@example.com';
      const password = 'password123';

      service.login(email, password).subscribe(
        () => fail('Expected an error to be thrown'),
        (error) => expect(error).toBeTruthy()
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/auth/login`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ email, password });

      req.flush({ error: 'Invalid credentials' }, { status: 401, statusText: 'Unauthorized' });
    });
  });

  describe('refreshToken', () => {
    it('should refresh access token', () => {
      const accessToken = 'access_token';
      localStorage.setItem('certifapp_access', accessToken);
      localStorage.setItem('certifapp_refresh', 'refresh_token');

      service.refreshToken().subscribe();

      const req = httpMock.expectOne(`${environment.apiUrl}/auth/refresh`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ refreshToken: 'refresh_token' });

      const tokenResponse: TokenResponse = { accessToken: 'new_access_token', refreshToken: 'new_refresh_token' };
      req.flush({ data: tokenResponse } as ApiResponse<TokenResponse>);

      expect(localStorage.getItem('certifapp_access')).toBe('new_access_token');
      expect(localStorage.getItem('certifapp_refresh')).toBe('new_refresh_token');
    });

    it('should handle refresh error and logout', () => {
      const accessToken = 'access_token';
      localStorage.setItem('certifapp_access', accessToken);
      localStorage.setItem('certifapp_refresh', 'refresh_token');

      service.refreshToken().subscribe(
        () => fail('Expected an error to be thrown'),
        (error) => expect(error).toBeTruthy()
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/auth/refresh`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ refreshToken: 'refresh_token' });

      req.flush({ error: 'Invalid refresh token' }, { status: 401, statusText: 'Unauthorized' });
      expect(service.isAuthenticated()).toBeFalsy();
      expect(routerSpy.navigate).toHaveBeenCalledWith(['/']);
    });
  });

  describe('logout', () => {
    it('should clear tokens and navigate to home', () => {
      localStorage.setItem('certifapp_access', 'access_token');
      localStorage.setItem('certifapp_refresh', 'refresh_token');

      service.logout();

      expect(localStorage.getItem('certifapp_access')).toBeNull();
      expect(localStorage.getItem('certifapp_refresh')).toBeNull();
      expect(service.currentUser()).toBe(null);
      expect(routerSpy.navigate).toHaveBeenCalledWith(['/']);
    });
  });

  describe('getAccessToken', () => {
    it('should return stored access token', () => {
      localStorage.setItem('certifapp_access', 'access_token');

      const accessToken = service.getAccessToken();

      expect(accessToken).toBe('access_token');
    });

    it('should return null if no token is stored', () => {
      const accessToken = service.getAccessToken();

      expect(accessToken).toBeNull();
    });
  });
});
