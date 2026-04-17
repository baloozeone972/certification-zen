import {ComponentFixture, TestBed} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {AuthService} from './core/auth/auth.service';
import {AppComponent} from './app.component';

describe('AppComponent', () => {
    let component: AppComponent;
    let fixture: ComponentFixture<AppComponent>;
    let authService: AuthService;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            imports: [RouterTestingModule, CommonModule],
            declarations: [AppComponent]
        }).compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(AppComponent);
        component = fixture.componentInstance;
        authService = TestBed.inject(AuthService);
    });

    afterEach(() => {
        localStorage.removeItem('theme');
    });

    it('should create the app', () => {
        expect(component).toBeTruthy();
    });

    describe('ngOnInit', () => {
        it('should restore theme from localStorage if available', () => {
            spyOn(localStorage, 'getItem').and.returnValue('dark');
            component.ngOnInit();
            expect(component.theme()).toBe('dark');
        });

        it('should set default theme to "light" if no theme is saved in localStorage', () => {
            spyOn(localStorage, 'getItem').and.returnValue(null);
            component.ngOnInit();
            expect(component.theme()).toBe('light');
        });
    });

    describe('toggleTheme', () => {
        it('should toggle theme between "light" and "dark"', () => {
            component.toggleTheme();
            expect(component.theme()).toBe('dark');

            component.toggleTheme();
            expect(component.theme()).toBe('light');
        });

        it('should save the selected theme to localStorage', () => {
            spyOn(localStorage, 'setItem');
            component.toggleTheme();
            expect(localStorage.setItem).toHaveBeenCalledWith('theme', 'dark');
        });
    });
});

