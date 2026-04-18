import {ComponentFixture, TestBed} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {CommonModule} from '@angular/common';
import {HistoryComponent} from './history.component';
import {ExamService} from '../../core/services/exam.service';
import {ExamSessionSummary} from '../../core/models/exam.models';
import {DurationPipe} from '../../shared/pipes/duration.pipe';

describe('HistoryComponent', () => {
    let component: HistoryComponent;
    let fixture: ComponentFixture<HistoryComponent>;
    let examService: jasmine.SpyObj<ExamService>;

    beforeEach(async () => {
        TestBed.configureTestingModule({
            declarations: [HistoryComponent],
            imports: [CommonModule, RouterTestingModule.withRoutes([]), DurationPipe],
            providers: [
                {provide: ExamService, useValue: jasmine.createSpyObj('ExamService', ['getHistory'])}
            ]
        })
            .compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(HistoryComponent);
        component = fixture.componentInstance;
        examService = TestBed.inject(ExamService) as jasmine.SpyObj<ExamService>;
        fixture.detectChanges();
    });

    afterEach(() => {
        fixture.destroy();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should display the empty state when no sessions are available', () => {
        examService.getHistory.and.returnValue(of([]));
        fixture.detectChanges();
        const compiled = fixture.nativeElement;
        expect(compiled.querySelector('.history__empty')).toBeTruthy();
    });

    it('should display sessions when they are available', async () => {
        const mockSessions: ExamSessionSummary[] = [
            {
                id: '1',
                certificationId: 'Cert1',
                mode: 'ModeA',
                correctCount: 8,
                totalQuestions: 10,
                durationSeconds: 3600,
                percentage: 80,
                passed: true
            }
        ];
        examService.getHistory.and.returnValue(of(mockSessions));
        fixture.detectChanges();

        await fixture.whenStable();
        const compiled = fixture.nativeElement;
        expect(compiled.querySelector('.history__empty')).toBeFalsy();
        expect(compiled.querySelectorAll('.history-row').length).toBe(1);
    });

    it('should call examService.getHistory on init', () => {
        spyOn(examService, 'getHistory');
        component.ngOnInit();
        expect(examService.getHistory).toHaveBeenCalled();
    });

    it('should handle error when getHistory fails', async () => {
        examService.getHistory.and.returnValue(throwError('Server error'));
        fixture.detectChanges();

        await fixture.whenStable();
        const compiled = fixture.nativeElement;
        expect(compiled.querySelector('.history__empty')).toBeTruthy();
        expect(examService.getHistory).toHaveBeenCalled();
    });
});