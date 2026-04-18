import {TestBed} from '@angular/core/testing';
import {Certification} from './certification.model';

describe('Certification', () => {
    let certification: Certification;

    beforeEach(() => {
        TestBed.configureTestingModule({
            providers: [
                {
                    provide: Certification, useValue: new Certification(
                        '1',
                        'C1',
                        'Test Certification',
                        50,
                        40,
                        30,
                        60,
                        'MCQ',
                        [
                            {id: 'T1', code: 'T1C', label: 'Theme 1', questionCount: 20},
                            {id: 'T2', code: 'T2C', label: 'Theme 2', questionCount: 30}
                        ],
                        true
                    )
                }
            ]
        });
        certification = TestBed.inject(Certification);
    });

    it('should create an instance with default values', () => {
        const instance = new Certification('', '', '', 0, 0, 0, 0, '', [], false);
        expect(instance).toBeDefined();
    });

    it('should have correct totalQuestions and examQuestionCount', () => {
        expect(certification.totalQuestions).toBe(50);
        expect(certification.examQuestionCount).toBe(40);
    });

    it('should have correct passingScore, examDurationMin, and examType', () => {
        expect(certification.passingScore).toBe(30);
        expect(certification.examDurationMin).toBe(60);
        expect(certification.examType).toBe('MCQ');
    });

    it('should have themes with correct properties', () => {
        expect(certification.themes).toEqual([
            {id: 'T1', code: 'T1C', label: 'Theme 1', questionCount: 20},
            {id: 'T2', code: 'T2C', label: 'Theme 2', questionCount: 30}
        ]);
    });

    it('should have isActive as true by default', () => {
        expect(certification.isActive).toBe(true);
    });
});