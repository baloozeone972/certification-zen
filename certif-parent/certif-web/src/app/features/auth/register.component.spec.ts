import {ComponentFixture, TestBed} from '@angular/core/testing';
import {ReactiveFormsModule} from '@angular/forms';
import {RouterTestingModule} from '@angular/router/testing';
import {AuthService} from '../../core/auth/auth.service';
import {RegisterComponent} from './register.component';

describe('RegisterComponent', () => {
    let component: RegisterComponent;
    let fixture: ComponentFixture<RegisterComponent>;
    let authService: AuthService;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            imports: [ReactiveFormsModule, RouterTestingModule.withRoutes([])],
            declarations: [RegisterComponent],
            providers: [
                {provide: AuthService, useValue: jasmine.createSpyObj('AuthService', ['register'])},
                {provide: Router, useValue: jasmine.createSpyObj('Router', ['navigate'])}
            ]
        }).compileComponents();

        fixture = TestBed.createComponent(RegisterComponent);
        component = fixture.componentInstance;
        authService = TestBed.inject(AuthService);
        fixture.detectChanges();
    });

    it('should create the component', () => {
        expect(component).toBeTruthy();
    });

    describe('submit', () => {
        it('should call AuthService.register with form values and navigate on success', () => {
            const email = 'test@example.com';
            const password = 'password123456';
            component.form.setValue({email, password});

            authService.register.and.returnValue(of(undefined));

            component.submit();

            expect(authService.register).toHaveBeenCalledWith(email, password);
            expect(component.router.navigate).toHaveBeenCalledWith(['/']);
        });

        it('should set error message on failure', () => {
            const errorMessage = 'Invalid credentials';
            authService.register.and.returnValue(throwError(() => new Error(errorMessage)));

            component.submit();

            expect(authService.register).toHaveBeenCalledWith(email, password);
            expect(component.error()).toBe(errorMessage);
        });

        it('should disable button and show loading state while submitting', () => {
            const email = 'test@example.com';
            const password = 'password123456';
            component.form.setValue({email, password});

            authService.register.and.returnValue(of(undefined));

            component.submit();

            expect(component.loading()).toBeTrue();
        });
    });

    describe('error', () => {
        it('should return the error message if there is an error', () => {
            const errorMessage = 'Invalid credentials';
            component.error.set(errorMessage);

            expect(component.error()).toBe(errorMessage);
        });

        it('should return null if there is no error', () => {
            component.error.set(null);

            expect(component.error()).toBeNull();
        });
    });
});

