import {async, ComponentFixture, TestBed} from '@angular/core/testing';
import {LoginComponent} from './login.component';
import {AuthService} from '../auth.service';

describe('LoginComponent', () => {
    let component: LoginComponent;
    let fixture: ComponentFixture<LoginComponent>;
    let authServiceMock: AuthService;

    beforeEach(async(() => {
        authServiceMock = jasmine.createSpyObj('AuthService', ['login']);

        TestBed.configureTestingModule({
            declarations: [LoginComponent],
            providers: [{provide: AuthService, useValue: authServiceMock}]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(LoginComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should call authService.login on form submit', async () => {
        const username = 'testuser';
        const password = 'testpass';

        component.loginForm.setValue({username, password});
        fixture.detectChanges();

        const button = fixture.debugElement.nativeElement.querySelector('button');
        button.click();
        await fixture.whenStable();

        expect(authServiceMock.login).toHaveBeenCalledWith(username, password);
    });

    it('should display error message if login fails', async () => {
        const username = 'testuser';
        const password = 'testpass';

        authServiceMock.login.and.returnValue(Promise.reject('Invalid credentials'));

        component.loginForm.setValue({username, password});
        fixture.detectChanges();

        const button = fixture.debugElement.nativeElement.querySelector('button');
        button.click();
        await fixture.whenStable();

        const errorMessage = fixture.debugElement.nativeElement.querySelector('.error-message');
        expect(errorMessage).toBeTruthy();
    });
});