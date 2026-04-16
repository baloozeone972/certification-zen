```typescript
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { of, throwError } from 'rxjs';
import { CommonModule, DecimalPipe } from '@angular/common';
import { ExamService } from '../../core/services/exam.service';
import { ScoreWidgetComponent } from '../../shared/components/score-widget/score-widget.component';
import { DurationPipe } from '../../shared/pipes/duration.pipe';
import { ResultsComponent } from './results.component';

describe('ResultsComponent', () => {
  let component: ResultsComponent;
  let fixture: ComponentFixture<ResultsComponent>;
  let examServiceSpy: jasmine.SpyObj<ExamService>;

  beforeEach(async () => {
    examServiceSpy = jasmine.createSpyObj('ExamService', ['getResults', 'exportPdf']);

    await TestBed.configureTestingModule({
      imports: [CommonModule, ResultsComponent],
      providers: [
        { provide: ExamService, useValue: examServiceSpy },
        { provide: ActivatedRoute, useValue: { snapshot: { paramMap: { get: () => '123' } } } }
      ]
    }).compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ResultsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  describe('ngOnInit', () => {
    it('should fetch and set results on successful getResults call', () => {
      const mockResult: ExamResult = {
        sessionId: '123',
        passed: true,
        percentage: 70,
        correctCount: 5,
        totalQuestions: 10,
        durationSeconds: 60,
        themeStats: []
      };
      examServiceSpy.getResults.and.returnValue(of(mockResult));

      component.ngOnInit();
      fixture.detectChanges();

      expect(component.result()).toEqual(mockResult);
    });

    it('should handle error on getResults call', () => {
      examServiceSpy.getResults.and.returnValue(throwError(() => new Error('Failed to fetch results')));

      component.ngOnInit();
      fixture.detectChanges();

      // Check for expected behavior in case of error
      expect(component.result()).toBeNull();
      // Additional checks can be added here based on the expected UI state or error handling logic
    });
  });

  describe('exportPdf', () => {
    it('should export PDF on successful call to examService.exportPdf', () => {
      const mockBlob = new Blob(['PDF content'], { type: 'application/pdf' });
      const id = '123';
      examServiceSpy.exportPdf.and.returnValue(of(mockBlob));

      component.exportPdf();
      fixture.detectChanges();

      expect(examServiceSpy.exportPdf).toHaveBeenCalledWith(id);
      // Check for expected behavior in case of successful export
    });

    it('should handle error on exportPdf call', () => {
      const id = '123';
      examServiceSpy.exportPdf.and.returnValue(throwError(() => new Error('Failed to export PDF')));

      component.exportPdf();
      fixture.detectChanges();

      // Check for expected behavior in case of error
      expect(examServiceSpy.exportPdf).toHaveBeenCalledWith(id);
      // Additional checks can be added here based on the expected UI state or error handling logic
    });
  });

  describe('Edge Cases', () => {
    it('should handle empty sessionId from ActivatedRoute', () => {
      TestBed.overrideProvider(ActivatedRoute, { useValue: { snapshot: { paramMap: { get: () => '' } } } }).reconfigureTestingModule();
      fixture.detectChanges();

      component.ngOnInit();
      expect(examServiceSpy.getResults).not.toHaveBeenCalled();
    });

    it('should handle null results', () => {
      examServiceSpy.getResults.and.returnValue(of(null));

      component.ngOnInit();
      expect(component.result()).toBeNull();
    });
  });
});
```
