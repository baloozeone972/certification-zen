// certif-parent/certif-web/src/app/core/models/exam.models.ts

export type ExamMode = 'EXAM' | 'FREE' | 'REVISION';

export interface QuestionOption {
    id: string;
    label: string;
    text: string;
}

export interface Question {
    id: string;
    statement: string;
    options: QuestionOption[];
    themeCode: string;
    difficulty: 'easy' | 'medium' | 'hard';
}

export interface ExamSession {
    id: string;
    certificationId: string;
    mode: ExamMode;
    questions: Question[];
    startedAt: string;
    durationSeconds: number;
    timerEnabled: boolean;
}

export interface UserAnswer {
    questionId: string;
    selectedOptionId: string | null;
    isCorrect: boolean;
    isSkipped: boolean;
}

export interface ThemeStats {
    themeCode: string;
    themeLabel: string;
    correct: number;
    wrong: number;
    skipped: number;
    total: number;
    percentage: number;
}

export interface ExamResult {
    sessionId: string;
    certificationId: string;
    mode: ExamMode;
    startedAt: string;
    endedAt: string;
    durationSeconds: number;
    totalQuestions: number;
    correctCount: number;
    percentage: number;
    passed: boolean;
    themeStats: ThemeStats[];
    wrongQuestions: QuestionWithResult[];
}

export interface QuestionWithResult extends Question {
    correctOptionId: string;
    selectedOptionId: string | null;
    isCorrect: boolean;
    isSkipped: boolean;
    explanationOriginal: string;
    explanationEnriched?: string;
}

export interface ExamSessionSummary {
    id: string;
    certificationId: string;
    mode: ExamMode;
    startedAt: string;
    durationSeconds: number;
    totalQuestions: number;
    correctCount: number;
    percentage: number;
    passed: boolean;
}
