import {async, ComponentFixture, TestBed} from '@angular/core/testing';
import {CommonModule} from '@angular/common';
import {FlashcardSwipeComponent} from './flashcard-swipe.component';

describe('FlashcardSwipeComponent', () => {
    let component: FlashcardSwipeComponent;
    let fixture: ComponentFixture<FlashcardSwipeComponent>;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            imports: [CommonModule],
            declarations: [FlashcardSwipeComponent]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(FlashcardSwipeComponent);
        component = fixture.componentInstance;
        component.flashcard = {
            frontText: 'Front Text',
            backText: 'Back Text',
            codeExample: null
        };
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should flip the card on click', async(() => {
        const card = fixture.debugElement.nativeElement.querySelector('.fc-card');
        expect(component.flipped()).toBe(false);
        card.click();
        fixture.detectChanges();
        expect(component.flipped()).toBe(true);
    }));

    it('should emit rated event with value on rate button click', async(() => {
        const card = fixture.debugElement.nativeElement.querySelector('.fc-card');
        card.click();
        fixture.detectChanges();

        const buttons = fixture.debugElement.nativeElement.querySelectorAll('.fc-btn');
        expect(buttons.length).toBe(5);

        buttons[2].click(); // Click on '3 — Correct' button
        fixture.detectChanges();

        expect(component.rated.emit).toHaveBeenCalledWith(3);
    }));
});