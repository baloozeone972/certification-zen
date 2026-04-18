import {async, ComponentFixture, TestBed} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {ReactiveFormsModule} from '@angular/forms';
import {AuthService} from '../../core/auth/auth.service';
import {CommonModule} from '@angular/common';

describe('RegisterComponent', () => {
    let component: RegisterComponent;
    let fixture: ComponentFixture<RegisterComponent>;
    let authServiceMock: AuthService;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            imports: [ReactiveFormsModule, RouterTestingModule.withRoutes([]), CommonModule],
            declarations: [RegisterComponent],
            providers: [
                {provide: AuthService, useValue: authServiceMock}
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(RegisterComponent);
        component = fixture.componentInstance;
        authServiceMock = TestBed.inject(AuthService);
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should display error message on form submission with invalid email', async(() => {
        component.form.controls.email.setValue('invalid-email');
        component.form.controls.password.setValue('password123');

        fixture.detectChanges();
        const submitButton = fixture.debugElement.nativeElement.querySelector('button[type="submit"]');
        submitButton.click();

        fixture.whenStable().then(() => {
            const errorMessage = fixture.debugElement.nativeElement.querySelector('.error-msg');
            expect(errorMessage).toBeTruthy();
            expect(errorMessage.textContent.trim()).toContain('Email professionnel invalide');
        });
    }));

    it('should display error message on form submission with short password', async(() => {
        component.form.controls.email.setValue('valid@example.com');
        component.form.controls.password.setValue('pass');

        fixture.detectChanges();
        const submitButton = fixture.debugElement.nativeElement.querySelector('button[type="submit"]');
        submitButton.click();

        fixture.whenStable().then(() => {
            const errorMessage = fixture.debugElement.nativeElement.querySelector('.error-msg');
            expect(errorMessage).toBeTruthy();
            expect(errorMessage.textContent.trim()).toContain('Mot de passe (min. 8 caractères)');
        });
    }));

    it('should navigate to home page on successful registration', async(() => {
        component.form.controls.email.setValue('valid@example.com');
        component.form.controls.password.setValue('password123');

        spyOn(authServiceMock, 'register').and.returnValue(Promise.resolve());

        fixture.detectChanges();
        const submitButton = fixture.debugElement.nativeElement.querySelector('button[type="submit"]');
        submitButton.click();

        fixture.whenStable().then(() => {
            expect(component.router.navigate).toHaveBeenCalledWith(['/']);
        });
    }));

    it('should display error message on registration failure', async(() => {
        component.form.controls.email.setValue('valid@example.com');
        component.form.controls.password.setValue('password123');

        spyOn(authServiceMock, 'register').and.returnValue(Promise.reject(new Error('Registration failed')));

        fixture.detectChanges();
        const submitButton = fixture.debugElement.nativeElement.querySelector('button[type="submit"]');
        submitButton.click();

        fixture.whenStable().then(() => {
            const errorMessage = fixture.debugElement.nativeElement.querySelector('.error-msg');
            expect(errorMessage).toBeTruthy();
            expect(errorMessage.textContent.trim()).toContain('Une erreur est survenue.');
        });
    }));
});