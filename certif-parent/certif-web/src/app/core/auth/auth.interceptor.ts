import {TestBed} from '@angular/core/testing';
import {HttpClientTestingModule, HttpTestingController} from '@angular/common/http/testing';
import {AuthService} from './auth.service';
import {authInterceptor} from './auth.interceptor';

describe('AuthInterceptor', () => {
    let httpMock: HttpTestingController;
    let authService: AuthService;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [HttpClientTestingModule],
            providers: [
                {
                    provide: AuthService,
                    useValue: jasmine.createSpyObj('AuthService', ['getAccessToken', 'refreshToken', 'logout'])
                }
            ]
        });

        httpMock = TestBed.inject(HttpTestingController);
        authService = TestBed.inject(AuthService);
    });

    afterEach(() => {
        httpMock.verify();
    });

    it('should attach Bearer token to requests', async () => {
        const token = 'testToken';
        authService.getAccessToken.and.returnValue(token);

        authInterceptor(
            new HttpRequest('GET', 'https://example.com/api/data'),
            (req) => {
                expect(req.headers.get('Authorization')).toBe(`Bearer ${token}`);
                return of(null);
            }
        );

        httpMock.expectOne('https://example.com/api/data').flush({});
    });

    it('should refresh token and retry request on 401', async () => {
        const token = 'testToken';
        authService.getAccessToken.and.returnValue(token);
        authService.refreshToken.and.returnValue(of('newToken'));

        authInterceptor(
            new HttpRequest('GET', 'https://example.com/api/data'),
            (req) => {
                return of(null);
            }
        ).subscribe();

        httpMock.expectOne('https://example.com/api/data').error(new HttpErrorResponse({status: 401}));
        httpMock.expectOne('https://example.com/auth/refresh').flush({access_token: 'newToken'});

        httpMock.expectOne('https://example.com/api/data').flush({});
    });

    it('should logout and throw error on refresh failure', async () => {
        const token = 'testToken';
        authService.getAccessToken.and.returnValue(token);
        authService.refreshToken.and.returnValue(throwError(() => new HttpErrorResponse({status: 401})));

        authInterceptor(
            new HttpRequest('GET', 'https://example.com/api/data'),
            (req) => {
                return of(null);
            }
        ).subscribe(
            () => fail('Should not reach here'),
            (error) => expect(error.status).toBe(401)
        );

        httpMock.expectOne('https://example.com/api/data').error(new HttpErrorResponse({status: 401}));
        httpMock.expectOne('https://example.com/auth/refresh').flush(null, {status: 401, statusText: 'Unauthorized'});

        authService.logout.and.callFake(() => {
            expect(authService.logout).toHaveBeenCalled();
        });
    });

    it('should skip auth endpoints', async () => {
        authInterceptor(
            new HttpRequest('GET', 'https://example.com/auth/login'),
            (req) => {
                return of(null);
            }
        );

        httpMock.expectNone('https://example.com/auth/login');
    });
});