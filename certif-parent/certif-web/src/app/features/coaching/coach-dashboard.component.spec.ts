import {ComponentFixture, TestBed} from '@angular/core/testing';
import {CommonModule} from '@angular/common';
import {CoachDashboardComponent} from './coach-dashboard.component';

describe('CoachDashboardComponent', () => {
    let component: CoachDashboardComponent;
    let fixture: ComponentFixture<CoachDashboardComponent>;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            imports: [CommonModule],
            declarations: [CoachDashboardComponent]
        })
            .compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(CoachDashboardComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should have the correct template selector and class', () => {
        const compiled = fixture.nativeElement as HTMLElement;
        expect(compiled.querySelector('.placeholder.container')).toBeTruthy();
        expect(compiled.querySelector('h1').textContent).toContain('Coach IA');
        expect(compiled.querySelector('.placeholder__msg').textContent).toContain('Cette section sera disponible prochainement.');
    });

    it('should have correct styles', () => {
        const compiled = fixture.nativeElement as HTMLElement;
        const placeholder = compiled.querySelector('.placeholder');
        const message = compiled.querySelector('.placeholder__msg');

        expect(placeholder.style.padding).toBe('3rem 1rem');
        expect(message.style.color).toContain('--color-text-muted');
    });
});

