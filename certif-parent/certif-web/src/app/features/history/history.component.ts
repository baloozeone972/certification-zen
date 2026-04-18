import { ComponentFixture, TestBed, async } from '@angular/core/testing';
import { HistoryComponent } from './history.component';
import { CommonModule, DecimalPipe } from '@angular/common';
import { RouterLink } from '@angular/router';
import { DurationPipe } from '../../shared/pipes/duration.pipe';
import { ExamService } from '../../core/services/exam.service';
import { of } from 'rxjs';
import { ExamSessionSummary } from '../../core/models/exam.models';

describe('HistoryComponent', () => {
  let component: HistoryComponent;
  let fixture: ComponentFixture<HistoryComponent>;
  let examServiceMock: jasmine.SpyObj<ExamService>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [HistoryComponent],
      imports: [CommonModule, RouterLink, DurationPipe, DecimalPipe],
      providers: [
        { provide: ExamService, useValue: jasmine.createSpyObj('ExamService', ['getHistory']) }
      ]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HistoryComponent);
    component = fixture.componentInstance;
    examServiceMock = TestBed.inject(ExamService) as jasmine.SpyObj<ExamService>;
  });

  it('should display empty message when no sessions', async(() => {
    examServiceMock.getHistory.and.returnValue(of([]));
    fixture.detectChanges();
    expect(fixture.nativeElement.querySelector('.history__empty')).toBeTruthy();
  }));

  it('should display sessions when available', async(() => {
    const sessions: ExamSessionSummary[] = [
      { id: 1, certificationId: 'CERT123', mode: 'Normal', correctCount: 5, totalQuestions: 10, percentage: 80, durationSeconds: 3600, passed: true }
    ];
    examServiceMock.getHistory.and.returnValue(of(sessions));
    fixture.detectChanges();
    expect(fixture.nativeElement.querySelector('.history-row')).toBeTruthy();
  }));

  it('should navigate to results when clicking on a session', async(() => {
    const sessions: ExamSessionSummary[] = [
      { id: 1, certificationId: 'CERT123', mode: 'Normal', correctCount: 5, totalQuestions: 10, percentage: 80, durationSeconds: 3600, passed: true }
    ];
    examServiceMock.getHistory.and.returnValue(of(sessions));
    fixture.detectChanges();
    const link = fixture.nativeElement.querySelector('a');
    expect(link).toBeTruthy();
    link.click();
    expect(component.routerLink).toEqual(['/results', 1]);
  }));
});