import {ComponentFixture, TestBed} from '@angular/core/testing';
import {ActivatedRouteStub} from '../../testing/activated-route.stub';
import {RouterTestingModule} from '@angular/router/testing';
import {FlashcardSwipeComponent} from '../../shared/components/flashcard-swipe/flashcard-swipe.component';
import {LearningService} from '../../core/services/learning.service';
import {of, throwError} from 'rxjs';
import {CommonModule} from '@angular/common';

describe('FlashcardDeckComponent', () => {
    let component: FlashcardDeckComponent;
    let fixture: ComponentFixture<FlashcardDeckComponent>;
    let learningServiceSpy: jasmine.SpyObj<LearningService>;

    beforeEach(async () => {
        const activatedRouteStub = new ActivatedRouteStub();
        activatedRouteStub.paramMap({get: () => 'testCertId'});

        learningServiceSpy = jasmine.createSpyObj('LearningService', ['getFlashcardsDue', 'reviewFlashcard']);

        await TestBed.configureTestingModule({
            imports: [CommonModule, RouterTestingModule.withRoutes([]), FlashcardSwipeComponent],
            providers: [
                {provide: ActivatedRoute, useValue: activatedRouteStub},
                {provide: LearningService, useValue: learningServiceSpy}
            ],
            declarations: [FlashcardDeckComponent]
        }).compileComponents();

        fixture = TestBed.createComponent(FlashcardDeckComponent);
        component = fixture.componentInstance;
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    describe('ngOnInit', () => {
        let flashcards: Flashcard[];

        beforeEach(() => {
            flashcards = [
                {id: '1', question: 'Q1', answer: 'A1'},
                {id: '2', question: 'Q2', answer: 'A2'}
            ];

            learningServiceSpy.getFlashcardsDue.and.returnValue(of(flashcards));
        });

        it('should initialize flashcards and certId from route', () => {
            fixture.detectChanges();
            expect(component.certId()).toEqual('testCertId');
            expect(component.flashcards()).toEqual(flashcards);
        });

        it('should handle error when fetching flashcards', () => {
            learningServiceSpy.getFlashcardsDue.and.returnValue(throwError(() => new Error('Fetch failed')));
            fixture.detectChanges();
            expect(console.error).toHaveBeenCalledWith('Fetch failed');
            expect(component.flashcards()).toEqual([]);
        });
    });

    describe('onRated', () => {
        let card: Flashcard;

        beforeEach(() => {
            card = {id: '1', question: 'Q1', answer: 'A1'};
            component.flashcards.set([card]);
            component.currentIndex.set(0);
            learningServiceSpy.reviewFlashcard.and.returnValue(of());
        });

        it('should update reviewed and current index on rating', () => {
            component.onRated(5);
            expect(component.reviewed()).toEqual(1);
            expect(component.currentIndex()).toEqual(1);
        });

        it('should not call reviewFlashcard if no current card', () => {
            component.current.set(null);
            component.onRated(5);
            expect(learningServiceSpy.reviewFlashcard).not.toHaveBeenCalled();
        });
    });
});

