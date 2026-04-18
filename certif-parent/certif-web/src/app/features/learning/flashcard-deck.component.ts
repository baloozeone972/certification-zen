import {async, ComponentFixture, TestBed} from '@angular/core/testing';
import {FlashcardDeckComponent} from './flashcard-deck.component';
import {FlashcardService} from '../services/flashcard.service';
import {of} from 'rxjs';

describe('FlashcardDeckComponent', () => {
    let component: FlashcardDeckComponent;
    let fixture: ComponentFixture<FlashcardDeckComponent>;
    let flashcardService: FlashcardService;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [FlashcardDeckComponent],
            providers: [
                {
                    provide: FlashcardService, useValue: {
                        getFlashcards: () => of([])
                    }
                }
            ]
        })
            .compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(FlashcardDeckComponent);
        component = fixture.componentInstance;
        flashcardService = TestBed.inject(FlashcardService);
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should fetch flashcards on init', async(() => {
        fixture.detectChanges();
        expect(flashcardService.getFlashcards).toHaveBeenCalled();
    }));

    it('should display flashcards', async(() => {
        const mockFlashcards = [
            {id: 1, question: 'Q1', answer: 'A1'},
            {id: 2, question: 'Q2', answer: 'A2'}
        ];
        spyOn(flashcardService, 'getFlashcards').and.returnValue(of(mockFlashcards));
        fixture.detectChanges();
        await fixture.whenStable();
        const flashcardElements = fixture.nativeElement.querySelectorAll('.flashcard');
        expect(flashcardElements.length).toBe(2);
    }));

    it('should handle error when fetching flashcards', async(() => {
        spyOn(flashcardService, 'getFlashcards').and.returnValue(of(null));
        fixture.detectChanges();
        await fixture.whenStable();
        const errorElement = fixture.nativeElement.querySelector('.error');
        expect(errorElement).toBeTruthy();
    }));
});