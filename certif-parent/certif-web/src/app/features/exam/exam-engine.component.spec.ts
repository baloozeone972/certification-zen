import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRouteStub } from '../../test/mock-activated-route.stub';
import { RouterStub } from '../../test/mock-router.stub';
import { ExamService } from '../../core/services/exam.service';
import { ExamSession, Question } from '../../core/models/exam.models';
import { of, throwError } from 'rxjs';

describe('ExamEngineComponent', () => {
  let component: ExamEngineComponent;
  let fixture: ComponentFixture<ExamEngineComponent>;
  let examService: jasmine.SpyObj<ExamService>;
  let route: ActivatedRouteStub;
  let router: RouterStub;

  beforeEach(async () => {
    const examSession: ExamSession = {
      id: '123',
      questions: [
        { id: 'q1', text: 'Q1', options: ['A', 'B'], correctOptionId: 'A' },
        { id: 'q2', text: 'Q2', options: ['C', 'D'], correctOptionId: 'C' }
      ],
      durationSeconds: 30,
      mode: 'NORMAL'
    };

    route = new ActivatedRouteStub();
    router = new RouterStub();

    examService = jasmine.createSpyObj('ExamService', {
      getResults: of(examSession),
      submitAnswer: of(),
      submitExam: of()
    });

    await TestBed.configureTestingModule({
      declarations: [ ExamEngineComponent ],
      providers: [
        { provide: ActivatedRoute, useValue: route },
        { provide: Router, useValue: router },
        { provide: ExamService, useValue: examService }
      ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ExamEngineComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  describe('ngOnInit', () => {
    it('should set session from route param and subscribe to results', () => {
      expect(examService.getResults).toHaveBeenCalledWith('123');
      expect(component.session()).toEqual(examSession);
    });

    it('should handle error when getResults fails', () => {
      examService.getResults.and.returnValue(throwError(() => new Error('Test error')));
      component.ngOnInit();
      fixture.detectChanges();
      // Add expectations for handling the error
    });
  });

  describe('onAnswered', () => {
    it('should update answers and submit answer on correct option ID', () => {
      component.onAnswered('A');
      expect(component.answers()).toEqual(new Map([['q1', 'A']]));
      expect(examService.submitAnswer).toHaveBeenCalledWith('123', 'q1', 'A', jasmine.any(Number));
    });

    it('should handle null or undefined option ID', () => {
      component.onAnswered(null);
      expect(component.answers()).toEqual(new Map());
      expect(examService.submitAnswer).not.toHaveBeenCalled();
    });
  });

  describe('skipQuestion', () => {
    it('should submit answer with null and next question', () => {
      component.skipQuestion();
      expect(examService.submitAnswer).toHaveBeenCalledWith('123', 'q1', null, 0);
      expect(component.currentIndex()).toBe(1);
    });
  });

  describe('nextQuestion', () => {
    it('should update current index if not at last question', () => {
      component.nextQuestion();
      expect(component.currentIndex()).toBe(1);
    });

    it('should not update current index if at last question', () => {
      component.currentIndex.set(1);
      component.nextQuestion();
      expect(component.currentIndex()).toBe(1);
    });
  });

  describe('onTimerExpired', () => {
    it('should call submitExam', () => {
      component.onTimerExpired();
      expect(component.submitting()).toBe(true);
      expect(examService.submitExam).toHaveBeenCalledWith('123');
    });
  });

  describe('submitExam', () => {
    it('should navigate to results on success', () => {
      component.submitExam();
      expect(router.navigate).toHaveBeenCalledWith(['/results', '123']);
    });

    it('should handle error on submitExam failure', () => {
      examService.submitExam.and.returnValue(throwError(() => new Error('Test error')));
      component.submitExam();
      fixture.detectChanges();
      // Add expectations for handling the error
    });
  });
});
