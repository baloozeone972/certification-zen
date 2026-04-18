import {ComponentFixture, TestBed} from '@angular/core/testing';
import {DifficultyBadgeComponent} from './difficulty-badge.component';

describe('DifficultyBadgeComponent', () => {
    let component: DifficultyBadgeComponent;
    let fixture: ComponentFixture<DifficultyBadgeComponent>;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            declarations: [DifficultyBadgeComponent]
        })
            .compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(DifficultyBadgeComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should display the correct label for "easy" difficulty', () => {
        component.difficulty = 'easy';
        fixture.detectChanges();
        const compiled = fixture.nativeElement as HTMLElement;
        expect(compiled.textContent.trim()).toBe('Facile');
    });

    it('should display the correct label for "medium" difficulty', () => {
        component.difficulty = 'medium';
        fixture.detectChanges();
        const compiled = fixture.nativeElement as HTMLElement;
        expect(compiled.textContent.trim()).toBe('Moyen');
    });

    it('should display the correct label for "hard" difficulty', () => {
        component.difficulty = 'hard';
        fixture.detectChanges();
        const compiled = fixture.nativeElement as HTMLElement;
        expect(compiled.textContent.trim()).toBe('Difficile');
    });

    it('should default to "medium" if no difficulty is provided', () => {
        delete component.difficulty;
        fixture.detectChanges();
        const compiled = fixture.nativeElement as HTMLElement;
        expect(compiled.textContent.trim()).toBe('Moyen');
    });

    it('should handle unknown difficulties gracefully (e.g., "unknown")', () => {
        component.difficulty = 'unknown' as any;
        fixture.detectChanges();
        const compiled = fixture.nativeElement as HTMLElement;
        expect(compiled.textContent.trim()).toBe('unknown');
    });
});

