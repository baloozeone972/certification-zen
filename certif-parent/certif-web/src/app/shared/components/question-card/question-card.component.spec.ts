import {ComponentFixture, TestBed} from '@angular/core/testing';
import {CommonModule} from '@angular/common';
import {QuestionCardComponent} from './question-card.component';
import {DifficultyBadgeComponent} from '../difficulty-badge/difficulty-badge.component';
import {Question} from '../../../core/models/exam.models';

describe('QuestionCardComponent', () => {
    let component: QuestionCardComponent;
    let fixture: ComponentFixture<QuestionCardComponent>;
    let difficultyBadgeComponent: any;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            imports: [CommonModule, DifficultyBadgeComponent],
            declarations: [QuestionCardComponent]
        })
            .compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(QuestionCardComponent);
        component = fixture.componentInstance;
        difficultyBadgeComponent = TestBed.inject(DifficultyBadgeComponent);

        const mockQuestion: Question = {
            id: '1',
            statement: 'What is the capital of France?',
            themeCode: 'Geography',
            difficulty: 2,
            options: [
                {id: 'A', label: 'A', text: 'Paris'},
                {id: 'B', label: 'B', text: 'London'}
            ]
        };

        component.question = mockQuestion;
        fixture.detectChanges();
    });

    afterEach(() => {
        fixture.destroy();
    });

    it('should create the component', () => {
        expect(component).toBeTruthy();
    });

    it('should render question details correctly', () => {
        const compiled = fixture.nativeElement as HTMLElement;
        expect(compiled.querySelector('.q-card__theme').textContent).toContain('Geography');
        expect(compiled.querySelector('.q-card__statement').innerHTML).toContain('What is the capital of France?');
        expect(compiled.querySelectorAll('.q-option').length).toBe(2);
    });

    it('should emit selected option when clicked', () => {
        const selectOptionSpy = spyOn(component.answered, 'emit');
        fixture.debugElement.nativeElement.querySelector('.q-option').click();
        expect(selectOptionSpy).toHaveBeenCalledWith('A');
    });

    it('should disable buttons when locked', () => {
        component.locked = true;
        fixture.detectChanges();
        const options = fixture.debugElement.nativeElement.querySelectorAll('.q-option');
        options.forEach(option => expect(option.disabled).toBeTrue());
    });

    it('should correctly mark selected option as correct and wrong', () => {
        component.correctOptionId = 'A';
        fixture.detectChanges();

        const firstOption = fixture.debugElement.nativeElement.querySelector('.q-option:nth-child(1)');
        expect(firstOption.classList.contains('q-option--correct')).toBeTrue();
        expect(firstOption.classList.contains('q-option--wrong')).toBeFalse();

        component.selectedOptionId.set('B');
        fixture.detectChanges();

        expect(firstOption.classList.contains('q-option--correct')).toBeFalse();
        expect(firstOption.classList.contains('q-option--wrong')).toBeTrue();
    });

    it('should reveal correct answer when in reveal mode', () => {
        component.correctOptionId = 'A';
        component.revealMode = true;
        fixture.detectChanges();

        const options = fixture.debugElement.nativeElement.querySelectorAll('.q-option');
        expect(options[0].classList.contains('q-option--correct')).toBeTrue();
    });

    it('should not emit answer if locked', () => {
        component.locked = true;
        const selectOptionSpy = spyOn(component.answered, 'emit');
        fixture.debugElement.nativeElement.querySelector('.q-option').click();
        expect(selectOptionSpy).not.toHaveBeenCalled();
    });
});