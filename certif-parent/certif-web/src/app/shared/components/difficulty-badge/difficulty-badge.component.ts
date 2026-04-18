import {ComponentFixture, TestBed} from '@angular/core/testing';
import {By} from '@angular/platform-browser';
import {DifficultyBadgeComponent} from './difficulty-badge.component';

describe('DifficultyBadgeComponent', () => {
    let component: DifficultyBadgeComponent;
    let fixture: ComponentFixture<DifficultyBadgeComponent>;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            declarations: [DifficultyBadgeComponent],
            imports: []
        }).compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(DifficultyBadgeComponent);
        component = fixture.componentInstance;
    });

    it('should display "Facile" for difficulty "easy"', async () => {
        component.difficulty = 'easy';
        fixture.detectChanges();
        await fixture.whenStable();

        const badgeElement = fixture.debugElement.query(By.css('.badge-diff--easy'));
        expect(badgeElement).toBeTruthy();
        expect(badgeElement.nativeElement.textContent.trim()).toBe('Facile');
    });

    it('should display "Moyen" for difficulty "medium"', async () => {
        component.difficulty = 'medium';
        fixture.detectChanges();
        await fixture.whenStable();

        const badgeElement = fixture.debugElement.query(By.css('.badge-diff--medium'));
        expect(badgeElement).toBeTruthy();
        expect(badgeElement.nativeElement.textContent.trim()).toBe('Moyen');
    });

    it('should display "Difficile" for difficulty "hard"', async () => {
        component.difficulty = 'hard';
        fixture.detectChanges();
        await fixture.whenStable();

        const badgeElement = fixture.debugElement.query(By.css('.badge-diff--hard'));
        expect(badgeElement).toBeTruthy();
        expect(badgeElement.nativeElement.textContent.trim()).toBe('Difficile');
    });

    it('should default to "Moyen" if no difficulty is provided', async () => {
        fixture.detectChanges();
        await fixture.whenStable();

        const badgeElement = fixture.debugElement.query(By.css('.badge-diff--medium'));
        expect(badgeElement).toBeTruthy();
        expect(badgeElement.nativeElement.textContent.trim()).toBe('Moyen');
    });
});