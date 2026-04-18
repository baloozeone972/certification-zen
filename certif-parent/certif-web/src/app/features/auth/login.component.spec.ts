import {ComponentFixture, TestBed} from '@angular/core/testing';
import {ReactiveFormsModule} from '@angular/forms';
import {RouterTestingModule} from '@angular/router/testing';
import {AuthService} from '../../core/auth/auth.service';
import {ActivatedRouteStub, RouterStub} from '../../testing/stubs';
import {LoginComponent} from './login.component';

describe('LoginComponent', () => {
    let component: LoginComponent;
    let fixture: ComponentFixture<LoginComponent>;
    let authService: jasmine.SpyObj<AuthService>;
    let router: RouterStub;

    beforeEach(async () => {
        authService = jasmine.createSpyObj(['login']);
        router = new RouterStub();

        await TestBed.configureTestingModule({
            imports: [ReactiveFormsModule, RouterTestingModule.withRoutes([])],
            declarations: [LoginComponent],
            providers: [
                {provide: AuthService, useValue: authService},
                {provide: Router, useValue: router},
                {provide: ActivatedRoute, useClass: ActivatedRouteStub}
            ]
        }).compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(LoginComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    describe('submit method', () => {
        it('should not call authService.login if form is invalid', () => {
            component.form.setValue({email: 'test@example.com', password: '123'});
            component.submit();
            expect(authService.login).not.toHaveBeenCalled();
        });

        it('should set loading to true and clear error before calling authService.login', () => {
            component.form.patchValue({email: 'test@example.com', password: '12345678'});
            component.submit();
            expect(component.loading).toBe(true);
            expect(component.error).toBe(null);
        });

        it('should navigate to returnUrl if login is successful', () => {
            component.form.patchValue({email: 'test@example.com', password: '12345678'});
            const returnUrl = '/dashboard';
            router.setQueryParamMap({returnUrl});
            authService.login.and.returnValue(of(null));
            component.submit();
            expect(router.navigateByUrl).toHaveBeenCalledWith(returnUrl);
        });

        it('should set error message and reset loading if login fails', () => {
            component.form.patchValue({email: 'test@example.com', password: '12345678'});
            authService.login.and.returnValue(throwError(() => new Error()));
            component.submit();
            expect(component.error).toBe('Email ou mot de passe incorrect.');
            expect(component.loading).toBe(false);
        });

        it('should handle error if router.navigateByUrl fails', () => {
            component.form.patchValue({email: 'test@example.com', password: '12345678'});
            const returnUrl = '/dashboard';
            router.setQueryParamMap({returnUrl});
            authService.login.and.returnValue(of(null));
            spyOn(router, 'navigateByUrl').and.throwError(() => new Error());
            component.submit();
            expect(component.error).toBe('Email ou mot de passe incorrect.');
            expect(component.loading).toBe(false);
        });
    });
});