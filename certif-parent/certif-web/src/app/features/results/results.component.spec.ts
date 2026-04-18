import {ComponentFixture, TestBed} from '@angular/core/testing';
import {ActivatedRoute} from '@angular/router';
import {of, throwError} from 'rxjs';
import {CommonModule} from '@angular/common';
import {ExamService} from '../../core/services/exam.service';
import {ResultsComponent} from './results.component';

describe('ResultsComponent', () => {
    let component: ResultsComponent;
    let fixture: ComponentFixture<ResultsComponent>;
    let examServiceSpy: jasmine.SpyObj<ExamService>;

    beforeEach(async () => {
        examServiceSpy = jasmine.createSpyObj('ExamService', ['getResults', 'exportPdf']);

        await TestBed.configureTestingModule({
            imports: [CommonModule],
            declarations: [ResultsComponent],
            providers: [
                {provide: ExamService, useValue: examServiceSpy},
                {provide: ActivatedRoute, useValue: {snapshot: {paramMap: {get: () => '123'}}}}
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
        it('should fetch and set results on successful getResults call', async () => {
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

            await fixture.whenStable();
            expect(component.result()).toEqual(mockResult);
        });

        it('should handle error on getResults call', async () => {
            examServiceSpy.getResults.and.returnValue(throwError(() => new Error('Failed to fetch results')));

            await fixture.whenStable();
            expect(component.result()).toBeNull();
        });
    });

    describe('exportPdf', () => {
        it('should export PDF on successful call to examService.exportPdf', async () => {
            const mockBlob = new Blob(['PDF content'], {type: 'application/pdf'});
            const id = '123';
            examServiceSpy.exportPdf.and.returnValue(of(mockBlob));

            await component.exportPdf();
            expect(examServiceSpy.exportPdf).toHaveBeenCalledWith(id);
        });

        it('should handle error on exportPdf call', async () => {
            const id = '123';
            examServiceSpy.exportPdf.and.returnValue(throwError(() => new Error('Failed to export PDF')));

            await component.exportPdf();
            expect(examServiceSpy.exportPdf).toHaveBeenCalledWith(id);
        });
    });

    describe('Edge Cases', () => {
        it('should handle empty sessionId from ActivatedRoute', async () => {
            TestBed.overrideProvider(ActivatedRoute, {useValue: {snapshot: {paramMap: {get: () => ''}}}}).reconfigureTestingModule();
            fixture.detectChanges();

            await component.ngOnInit();
            expect(examServiceSpy.getResults).not.toHaveBeenCalled();
        });

        it('should handle null results', async () => {
            examServiceSpy.getResults.and.returnValue(of(null));

            await component.ngOnInit();
            expect(component.result()).toBeNull();
        });
    });
});