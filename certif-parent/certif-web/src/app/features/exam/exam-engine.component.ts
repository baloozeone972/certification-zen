import {ComponentFixture, TestBed} from '@angular/core/testing';
import {ExamEngineComponent} from './exam-engine.component';
import {ActivatedRoute, Router} from '@angular/router';
import {ExamService} from '../../core/services/exam.service';
import {of, throwError} from 'rxjs';
import {ExamSession, Question} from '../../core/models/exam.models';

describe('ExamEngineComponent', () => {
    let component: ExamEngineComponent;
    let fixture: ComponentFixture<ExamEngineComponent>;
    let examServiceMock: jasmine.SpyObj<ExamService>;
    let routerMock: jasmine.SpyObj<Router>;
    let routeMock: ActivatedRoute;

    beforeEach(async () => {
        examServiceMock = jasmine.createSpyObj('ExamService', ['getResults', 'submitAnswer', 'submitExam']);
        routerMock = jasmine.createSpyObj('Router', ['navigate']);
        routeMock = {snapshot: {paramMap: {get: () => '123'}}} as ActivatedRoute;

        await TestBed.configureTestingModule({
            declarations: [ExamEngineComponent],
            providers: [
                {provide: ExamService, useValue: examServiceMock},
                {provide: Router, useValue: routerMock},
                {provide: ActivatedRoute, useValue: routeMock}
            ]
        }).compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(ExamEngineComponent);
        component = fixture.componentInstance;
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should load session on init', async () => {
        const mockSession: ExamSession = {id: '123', questions: [], durationSeconds: 60, mode: 'NORMAL'};
        examServiceMock.getResults.and.returnValue(of(mockSession));

        await fixture.whenStable();
        expect(component.session()).toEqual(mockSession);
    });

    it('should handle session loading error', async () => {
        examServiceMock.getResults.and.returnValue(throwError(() => new Error('Failed to load session')));

        await fixture.whenStable();
        expect(component.session()).toBeNull();
    });

    it('should submit answer on answered event', async () => {
        const mockQuestion: Question = {id: '1', text: 'Q1', options: []};
        const mockSession: ExamSession = {id: '123', questions: [mockQuestion], durationSeconds: 60, mode: 'NORMAL'};
        component.session.set(mockSession);
        examServiceMock.submitAnswer.and.returnValue(of(null));

        component.onAnswered('A1');
        await fixture.whenStable();
        expect(examServiceMock.submitAnswer).toHaveBeenCalledWith('123', '1', 'A1', jasmine.any(Number));
    });

    it('should skip question and submit answer', async () => {
        const mockQuestion: Question = {id: '1', text: 'Q1', options: []};
        const mockSession: ExamSession = {id: '123', questions: [mockQuestion], durationSeconds: 60, mode: 'NORMAL'};
        component.session.set(mockSession);
        examServiceMock.submitAnswer.and.returnValue(of(null));

        component.skipQuestion();
        await fixture.whenStable();
        expect(examServiceMock.submitAnswer).toHaveBeenCalledWith('123', '1', null, 0);
        expect(component.currentIndex()).toBe(1);
    });

    it('should submit exam on timer expired', async () => {
        const mockSession: ExamSession = {id: '123', questions: [], durationSeconds: 60, mode: 'NORMAL'};
        component.session.set(mockSession);
        examServiceMock.submitExam.and.returnValue(of(null));

        component.onTimerExpired();
        await fixture.whenStable();
        expect(examServiceMock.submitExam).toHaveBeenCalledWith('123');
    });

    it('should navigate to results on exam submission success', async () => {
        const mockSession: ExamSession = {id: '123', questions: [], durationSeconds: 60, mode: 'NORMAL'};
        component.session.set(mockSession);
        examServiceMock.submitExam.and.returnValue(of(null));

        component.submitExam();
        await fixture.whenStable();
        expect(routerMock.navigate).toHaveBeenCalledWith(['/results', '123']);
    });

    it('should handle exam submission error', async () => {
        const mockSession: ExamSession = {id: '123', questions: [], durationSeconds: 60, mode: 'NORMAL'};
        component.session.set(mockSession);
        examServiceMock.submitExam.and.returnValue(throwError(() => new Error('Failed to submit exam')));

        component.submitExam();
        await fixture.whenStable();
        expect(component.submitting()).toBeFalse();
    });
});