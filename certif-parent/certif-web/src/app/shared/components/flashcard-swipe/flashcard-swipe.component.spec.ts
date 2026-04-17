import {ComponentFixture, TestBed} from '@angular/core/testing';
import {FlashcardSwipeComponent} from './flashcard-swipe.component';
import {CommonModule} from '@angular/common';

describe('FlashcardSwipeComponent', () => {
    let component: FlashcardSwipeComponent;
    let fixture: ComponentFixture<FlashcardSwipeComponent>;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            declarations: [FlashcardSwipeComponent],
            imports: [CommonModule]
        }).compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(FlashcardSwipeComponent);
        component = fixture.componentInstance;
        component.flashcard = {
            frontText: 'Front Text',
            backText: 'Back Text',
            codeExample: 'Code Example'
        };
        fixture.detectChanges();
    });

    afterEach(() => {
        fixture.destroy();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should flip the card when clicked', () => {
        const spy = spyOn(component.flipped, 'set');
        component.flip();
        expect(spy).toHaveBeenCalledWith(true);
    });

    it('should emit rated event with correct value and flip the card after rating', () => {
        const spyFlip = spyOn(component.flipped, 'set');
        const spyRate = spyOn(component.rated, 'emit');

        component.rate(3);

        expect(spyFlip).toHaveBeenCalledWith(false);
        expect(spyRate).toHaveBeenCalledWith(3);
    });

    it('should handle edge case: rating with value outside of valid range', () => {
        const spyFlip = spyOn(component.flipped, 'set');
        const spyRate = spyOn(component.rated, 'emit');

        component.rate(-1);

        expect(spyFlip).not.toHaveBeenCalled();
        expect(spyRate).not.toHaveBeenCalled();

        component.rate(6);

        expect(spyFlip).not.toHaveBeenCalled();
        expect(spyRate).not.toHaveBeenCalled();
    });

    it('should handle error case: no flashcard provided', () => {
        const spy = spyOn(console, 'error');
        component.ngOnInit();
        expect(spy).toHaveBeenCalledWith('FlashcardSwipeComponent requires a Flashcard input.');
    });
});

