// certif-parent/certif-web/src/app/core/auth/auth.service.ts
import { Injectable, signal, computed, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { tap, catchError, EMPTY } from 'rxjs';
import { environment } from '../../../environments/environment';
import { User, TokenResponse } from '../models/user.models';
import { ApiResponse } from '../models/api.models';

const ACCESS_TOKEN_KEY  = 'certifapp_access';
const REFRESH_TOKEN_KEY = 'certifapp_refresh';

/**
 * Authentication service using Angular 18 Signals.
 *
 * Manages JWT tokens in localStorage, exposes reactive currentUser signal
 * and provides login/register/logout/refresh methods.
 */
@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly http   = inject(HttpClient);
  private readonly router = inject(Router);
  private readonly base   = `${environment.apiUrl}/auth`;

  // Reactive state — Angular 18 Signals
  readonly currentUser   = signal<User | null>(this.loadUserFromToken());
  readonly isAuthenticated = computed(() => this.currentUser() !== null);
  readonly isPro = computed(() => {
    const tier = this.currentUser()?.subscriptionTier;
    return tier === 'PRO' || tier === 'PACK';
  });
  readonly isAdmin = computed(() => this.currentUser()?.role === 'ADMIN');

  /** Register a new account and auto-login. */
  register(email: string, password: string, locale = 'fr', timezone = 'Europe/Paris') {
    return this.http.post<ApiResponse<TokenResponse>>(`${this.base}/register`,
      { email, password, locale, timezone })
      .pipe(tap(res => this.handleTokens(res.data)));
  }

  /** Authenticate with email/password. */
  login(email: string, password: string) {
    return this.http.post<ApiResponse<TokenResponse>>(`${this.base}/login`,
      { email, password })
      .pipe(tap(res => this.handleTokens(res.data)));
  }

  /** Refresh access token using stored refresh token. */
  refreshToken() {
    const refresh = localStorage.getItem(REFRESH_TOKEN_KEY);
    if (!refresh) return EMPTY;
    return this.http.post<ApiResponse<TokenResponse>>(`${this.base}/refresh`,
      { refreshToken: refresh })
      .pipe(
        tap(res => this.handleTokens(res.data)),
        catchError(() => { this.logout(); return EMPTY; })
      );
  }

  /** Clear tokens and navigate to home. */
  logout(): void {
    localStorage.removeItem(ACCESS_TOKEN_KEY);
    localStorage.removeItem(REFRESH_TOKEN_KEY);
    this.currentUser.set(null);
    this.router.navigate(['/']);
  }

  /** Returns the stored access token (used by AuthInterceptor). */
  getAccessToken(): string | null {
    return localStorage.getItem(ACCESS_TOKEN_KEY);
  }

  // ── Private ────────────────────────────────────────────────────────────────

  private handleTokens(tokens: TokenResponse): void {
    localStorage.setItem(ACCESS_TOKEN_KEY,  tokens.accessToken);
    localStorage.setItem(REFRESH_TOKEN_KEY, tokens.refreshToken);
    this.currentUser.set(this.decodeUser(tokens.accessToken));
  }

  private loadUserFromToken(): User | null {
    const token = localStorage.getItem(ACCESS_TOKEN_KEY);
    if (!token) return null;
    try {
      return this.decodeUser(token);
    } catch {
      return null;
    }
  }

  private decodeUser(token: string): User | null {
    try {
      const payload = JSON.parse(atob(token.split('.')[1]));
      // Check expiry
      if (payload.exp && Date.now() / 1000 > payload.exp) return null;
      return {
        id:               payload.sub,
        email:            payload.email ?? '',
        role:             payload.role  ?? 'USER',
        subscriptionTier: payload.tier  ?? 'FREE',
        locale:           payload.locale ?? 'fr',
        timezone:         payload.timezone ?? 'Europe/Paris',
        createdAt:        ''
      };
    } catch {
      return null;
    }
  }
}
