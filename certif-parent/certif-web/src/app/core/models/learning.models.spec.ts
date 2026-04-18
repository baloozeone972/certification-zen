import {TestBed} from '@angular/core/testing';
import {AdaptivePlan, Course, Flashcard, SM2Progress} from './learning.models';

describe('Learning Models', () => {
    let flashcard: Flashcard;
    let sm2Progress: SM2Progress;
    let course: Course;
    let adaptivePlan: AdaptivePlan;

    beforeEach(() => {
        TestBed.configureTestingModule({
            declarations: [],
            providers: []
        });

        flashcard = new Flashcard({
            id: '1',
            frontText: 'Question',
            backText: 'Answer',
            codeExample: 'console.log("Hello");',
            nextReviewDate: new Date().toISOString(),
            easeFactor: 2.5,
            intervalDays: 3,
            repetitions: 1
        });

        sm2Progress = new SM2Progress({
            flashcardId: '1',
            nextReviewDate: new Date().toISOString(),
            intervalDays: 3,
            easeFactor: 2.5,
            repetitions: 1
        });

        course = new Course({
            id: '1',
            certificationId: 'cert123',
            themeCode: 'theme001',
            title: 'Introduction to Angular',
            contentMarkdown: '# Angular Introduction',
            contentHtml: '<h1>Angular Introduction</h1>',
            aiStatus: 'processed'
        });

        adaptivePlan = new AdaptivePlan({
            userId: 'user123',
            certificationId: 'cert123',
            dueTodayCount: 5,
            weakThemes: ['theme001', 'theme002'],
            predictedScore: 85,
            recommendedExamDate: new Date().toISOString()
        });
    });

    afterEach(() => {
        TestBed.resetTestingModule();
    });

    it('should create a Flashcard object', () => {
        expect(flashcard).toBeTruthy();
        expect(flashcard.id).toBe('1');
        expect(flashcard.frontText).toBe('Question');
        expect(flashcard.backText).toBe('Answer');
        expect(flashcard.codeExample).toBe('console.log("Hello");');
        expect(flashcard.nextReviewDate).toEqual(jasmine.any(String));
        expect(flashcard.easeFactor).toBe(2.5);
        expect(flashcard.intervalDays).toBe(3);
        expect(flashcard.repetitions).toBe(1);
    });

    it('should create an SM2Progress object', () => {
        expect(sm2Progress).toBeTruthy();
        expect(sm2Progress.flashcardId).toBe('1');
        expect(sm2Progress.nextReviewDate).toEqual(jasmine.any(String));
        expect(sm2Progress.intervalDays).toBe(3);
        expect(sm2Progress.easeFactor).toBe(2.5);
        expect(sm2Progress.repetitions).toBe(1);
    });

    it('should create a Course object', () => {
        expect(course).toBeTruthy();
        expect(course.id).toBe('1');
        expect(course.certificationId).toBe('cert123');
        expect(course.themeCode).toBe('theme001');
        expect(course.title).toBe('Introduction to Angular');
        expect(course.contentMarkdown).toBe('# Angular Introduction');
        expect(course.contentHtml).toBe('<h1>Angular Introduction</h1>');
        expect(course.aiStatus).toBe('processed');
    });

    it('should create an AdaptivePlan object', () => {
        expect(adaptivePlan).toBeTruthy();
        expect(adaptivePlan.userId).toBe('user123');
        expect(adaptivePlan.certificationId).toBe('cert123');
        expect(adaptivePlan.dueTodayCount).toBe(5);
        expect(adaptivePlan.weakThemes).toEqual(['theme001', 'theme002']);
        expect(adaptivePlan.predictedScore).toBe(85);
        expect(adaptivePlan.recommendedExamDate).toEqual(jasmine.any(String));
    });

    it('should handle edge case for Flashcard with missing properties', () => {
        const partialFlashcard: Partial<Flashcard> = {
            id: '1',
            frontText: 'Question'
        };
        expect(partialFlashcard).toBeTruthy();
        expect(partialFlashcard.id).toBe('1');
        expect(partialFlashcard.frontText).toBe('Question');
    });

    it('should handle edge case for SM2Progress with missing properties', () => {
        const partialSM2Progress: Partial<SM2Progress> = {
            flashcardId: '1',
            nextReviewDate: new Date().toISOString()
        };
        expect(partialSM2Progress).toBeTruthy();
        expect(partialSM2Progress.flashcardId).toBe('1');
        expect(partialSM2Progress.nextReviewDate).toEqual(jasmine.any(String));
    });

    it('should handle edge case for Course with missing properties', () => {
        const partialCourse: Partial<Course> = {
            id: '1',
            certificationId: 'cert123'
        };
        expect(partialCourse).toBeTruthy();
        expect(partialCourse.id).toBe('1');
        expect(partialCourse.certificationId).toBe('cert123');
    });

    it('should handle edge case for AdaptivePlan with missing properties', () => {
        const partialAdaptivePlan: Partial<AdaptivePlan> = {
            userId: 'user123',
            certificationId: 'cert123'
        };
        expect(partialAdaptivePlan).toBeTruthy();
        expect(partialAdaptivePlan.userId).toBe('user123');
        expect(partialAdaptivePlan.certificationId).toBe('cert123');
    });

    it('should handle error case for Flashcard with invalid date format', () => {
        const invalidFlashcard: Partial<Flashcard> = {
            id: '1',
            frontText: 'Question',
            nextReviewDate: 'invalid-date'
        };
        expect(() => new Flashcard(invalidFlashcard as Flashcard)).toThrowError('Invalid date format');
    });

    it('should handle error case for SM2Progress with invalid date format', () => {
        const invalidSM2Progress: Partial<SM2Progress> = {
            flashcardId: '1',
            nextReviewDate: 'invalid-date'
        };
        expect(() => new SM2Progress(invalidSM2Progress as SM2Progress)).toThrowError('Invalid date format');
    });

    it('should handle error case for AdaptivePlan with invalid date format', () => {
        const invalidAdaptivePlan: Partial<AdaptivePlan> = {
            userId: 'user123',
            certificationId: 'cert123',
            recommendedExamDate: 'invalid-date'
        };
        expect(() => new AdaptivePlan(invalidAdaptivePlan as AdaptivePlan)).toThrowError('Invalid date format');
    });
});