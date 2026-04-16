// certif-parent/certif-web/src/app/core/models/certification.models.ts

export interface Certification {
  id: string;
  code: string;
  name: string;
  description?: string;
  totalQuestions: number;
  examQuestionCount: number;
  passingScore: number;
  examDurationMin: number;
  examType: 'MCQ' | 'PRACTICAL' | 'MIXED';
  themes?: CertificationTheme[];
  isActive: boolean;
}

export interface CertificationTheme {
  id: string;
  code: string;
  label: string;
  questionCount: number;
  weightPercent?: number;
}
