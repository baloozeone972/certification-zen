// certif-parent/certif-web/src/app/core/models/learning.models.ts

export interface Flashcard {
    id: string;
    frontText: string;
    backText: string;
    codeExample?: string;
    nextReviewDate: string;
    easeFactor: number;
    intervalDays: number;
    repetitions: number;
}

export interface SM2Progress {
    flashcardId: string;
    nextReviewDate: string;
    intervalDays: number;
    easeFactor: number;
    repetitions: number;
}

export interface Course {
    id: string;
    certificationId: string;
    themeCode: string;
    title: string;
    contentMarkdown: string;
    contentHtml: string;
    aiStatus: string;
}

export interface AdaptivePlan {
    userId: string;
    certificationId: string;
    dueTodayCount: number;
    weakThemes: string[];
    predictedScore?: number;
    recommendedExamDate?: string;
}
