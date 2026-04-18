import { ComponentFixture, TestBed, async, fakeAsync, tick } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { CommonModule, DecimalPipe } from '@angular/common';
import { ResultsComponent } from './results.component';
import { ExamService } from '../../core/services/exam.service';
import { ExamResult } from '../../core/models/exam.models';
import { ScoreWidgetComponent } from '../../shared/components/score-widget/score-widget.component';
import { DurationPipe } from '../../shared/pipes/duration.pipe';

describe('ResultsComponent', () => {
    let component: ResultsComponent;
    let fixture: ComponentFixture<ResultsComponent>;
    let examServiceMock: Partial<ExamService>;

    beforeEach(async(() => {
        examServiceMock = {
            getResults: jest.fn(),
            exportPdf: jest.fn()
        };

        TestBed.configureTestingModule({
            imports: [RouterTestingModule, CommonModule],
            declarations: [ResultsComponent, ScoreWidgetComponent],
            providers: [
                { provide: ExamService, useValue: examServiceMock },
                DecimalPipe,
                DurationPipe
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(ResultsComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should display loading message when result is null', () => {
        expect(fixture.nativeElement.querySelector('.results__hero')).toBeFalsy();
        expect(fixture.nativeElement.querySelector('p').textContent).toContain('Chargement des résultats...');
    });

    it('should display results when result is available', fakeAsync(() => {
        const mockResult: ExamResult = {
            sessionId: '123',
            passed: true,
            percentage: 75,
            correctCount: 10,
            totalQuestions: 20,
            durationSeconds: 60,
            themeStats: [
                { themeCode: '1', themeLabel: 'Theme 1', correct: 5, wrong: 2, percentage: 70 },
                { themeCode: '2', themeLabel: 'Theme 2', correct: 3, wrong: 1, percentage: 60 }
            ]
        };

        lenient().when(examServiceMock.getResults('123')).thenReturn(of(mockResult));

        component.ngOnInit();
        tick();

        fixture.detectChanges();

        expect(fixture.nativeElement.querySelector('.results__hero')).toBeTruthy();
        expect(fixture.nativeElement.querySelector('h1').textContent).toContain('Félicitations ! 🎉');
        expect(fixture.nativeElement.querySelector('.results__summary p').textContent).toContain('10 / 20 questions correctes');
        expect(fixture.nativeElement.querySelector('.theme-table tbody tr').length).toBe(2);
    }));

    it('should export PDF when exportPdf button is clicked', fakeAsync(() => {
        const mockResult: ExamResult = {
            sessionId: '123',
            passed: true,
            percentage: 75,
            correctCount: 10,
            totalQuestions: 20,
            durationSeconds: 60,
            themeStats: []
        };

        lenient().when(examServiceMock.getResults('123')).thenReturn(of(mockResult));
        lenient().when(examServiceMock.exportPdf('123')).thenReturn(of(new Blob()));

        component.ngOnInit();
        tick();

        fixture.detectChanges();

        const exportPdfButton = fixture.nativeElement.querySelector('button');
        expect(exportPdfButton).toBeTruthy();

        exportPdfButton.click();
        tick();

        expect(examServiceMock.exportPdf).toHaveBeenCalledWith('123');
    }));
});