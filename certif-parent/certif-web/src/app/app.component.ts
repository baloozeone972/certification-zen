import {ComponentFixture, TestBed, async} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {AuthService} from '../core/auth/auth.service';
import {AppComponent} from './app.component';

describe('AppComponent', () => {
    let fixture: ComponentFixture<AppComponent>;
    let component: AppComponent;
    let authServiceMock: AuthService;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            imports: [RouterTestingModule],
            declarations: [AppComponent],
            providers: [
                {provide: AuthService, useValue: authServiceMock}
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(AppComponent);
        component = fixture.componentInstance;
        authServiceMock = TestBed.inject(AuthService);
    });

    it('should create the app', () => {
        expect(component).toBeTruthy();
    });

    it('should display "CertifApp" in the navbar brand', () => {
        fixture.detectChanges();
        const compiled = fixture.nativeElement;
        expect(compiled.querySelector('.navbar__brand').textContent).toContain('CertifApp');
    });

    it('should show login and registration buttons when not authenticated', () => {
        spyOn(authServiceMock, 'isAuthenticated').and.returnValue(false);
        fixture.detectChanges();
        const compiled = fixture.nativeElement;
        expect(compiled.querySelector('.btn-primary').textContent).toContain('Connexion');
        expect(compiled.querySelector('.btn-secondary').textContent).toContain('Inscription gratuite');
    });

    it('should show learning, community, coaching, chat, and profile links when authenticated', () => {
        spyOn(authServiceMock, 'isAuthenticated').and.returnValue(true);
        spyOn(authServiceMock, 'currentUser').and.returnValue({email: 'test@example.com'});
        fixture.detectChanges();
        const compiled = fixture.nativeElement;
        expect(compiled.querySelector('.navbar__links a:nth-child(1)').textContent).toContain('Révisions');
        expect(compiled.querySelector('.navbar__links a:nth-child(2)').textContent).toContain('Communauté');
        expect(compiled.querySelector('.navbar__links a:nth-child(3)').textContent).toContain('Coach IA');
        expect(compiled.querySelector('.navbar__links a:nth-child(4)').textContent).toContain('Assistant');
        expect(compiled.querySelector('.navbar__links a:nth-child(5)').textContent).toContain('test@example.com');
    });

    it('should toggle theme on button click', () => {
        spyOn(authServiceMock, 'isAuthenticated').and.returnValue(true);
        fixture.detectChanges();
        const button = fixture.nativeElement.querySelector('.btn-icon');
        button.click();
        fixture.detectChanges();
        expect(component.theme()).toBe('dark');
    });
});