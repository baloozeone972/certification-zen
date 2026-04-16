// certif-parent/certif-web/src/app/core/models/user.models.ts

export type UserRole = 'USER' | 'ADMIN' | 'PARTNER';
export type SubscriptionTier = 'FREE' | 'PRO' | 'PACK';

export interface User {
  id: string;
  email: string;
  role: UserRole;
  subscriptionTier: SubscriptionTier;
  locale: string;
  timezone: string;
  createdAt: string;
}

export interface TokenResponse {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
  tokenType: string;
}

export interface UserPreferences {
  theme: 'light' | 'dark' | 'system';
  language: string;
  defaultMode: 'EXAM' | 'FREE' | 'REVISION';
  notificationsEnabled: boolean;
  lastCertificationId?: string;
  freeModeQuestionCount: number;
  freeModeDurationMin: number;
}
