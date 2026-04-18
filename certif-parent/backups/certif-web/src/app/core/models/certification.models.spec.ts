describe('Certification', () => {
    let certification: Certification;

    beforeEach(() => {
        certification = {
            id: '1',
            code: 'C1',
            name: 'Test Certification',
            totalQuestions: 50,
            examQuestionCount: 40,
            passingScore: 30,
            examDurationMin: 60,
            examType: 'MCQ',
            themes: [
                {id: 'T1', code: 'T1C', label: 'Theme 1', questionCount: 20},
                {id: 'T2', code: 'T2C', label: 'Theme 2', questionCount: 30}
            ],
            isActive: true
        };
    });

    it('should create an instance with default values', () => {
        const instance = {
            id: '',
            code: '',
            name: ''
        };
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

