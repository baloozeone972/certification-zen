// certif-parent/certif-web/src/app/features/community/community.component.ts
import { Component, OnInit, inject, signal, ChangeDetectionStrategy } from "@angular/core";
import { CommonModule, DecimalPipe } from "@angular/common";
import { HttpClient } from "@angular/common/http";
import { RouterLink } from "@angular/router";
import { environment } from "../../../environments/environment";
import { map } from "rxjs";

interface LeaderboardEntry {
  rank: number;
  userId: string;
  displayName: string;
  certificationId: string;
  weeklyScore: number;
  totalExams: number;
  averageScore: number;
  isCurrentUser: boolean;
}

interface WeeklyChallenge {
  id: string;
  title: string;
  certificationId: string;
  description: string;
  endsAt: string;
  participantCount: number;
  myRank?: number;
  myScore?: number;
}

@Component({
  selector: "app-community",
  standalone: true,
  imports: [CommonModule, RouterLink, DecimalPipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="community container">
      <h1>🏆 Communauté</h1>

      <!-- Challenge de la semaine -->
      @if (challenge()) {
        <div class="card community__challenge">
          <div class="community__challenge-header">
            <span class="badge badge-warning">⚡ Challenge de la semaine</span>
            <span class="community__challenge-end">
              Se termine le {{ formatDate(challenge()!.endsAt) }}
            </span>
          </div>
          <h2>{{ challenge()!.title }}</h2>
          <p>{{ challenge()!.description }}</p>
          <div class="community__challenge-stats">
            <span>👥 {{ challenge()!.participantCount }} participants</span>
            @if (challenge()!.myRank) {
              <span>📊 Mon rang : #{{ challenge()!.myRank }}</span>
              <span>🎯 Mon score : {{ challenge()!.myScore | number:'1.0-1' }}%</span>
            }
          </div>
          <a [routerLink]="['/exam']"
             [queryParams]="{ certId: challenge()!.certificationId }"
             class="btn btn-primary">
            ⚡ Participer au challenge
          </a>
        </div>
      }

      <!-- Leaderboard -->
      <div class="card community__leaderboard" style="margin-top:1.5rem">
        <div class="community__leaderboard-header">
          <h2>📊 Classement de la semaine</h2>
          <div class="community__tabs">
            @for (cert of ["ocp21", "aws_saa", "docker", "cka"]; track cert) {
              <button class="community__tab"
                      [class.community__tab--active]="selectedCert() === cert"
                      (click)="loadLeaderboard(cert)">
                {{ cert.toUpperCase() }}
              </button>
            }
          </div>
        </div>

        @if (loading()) {
          <div class="community__loading">Chargement du classement...</div>
        } @else if (leaderboard().length === 0) {
          <div class="community__empty">
            <p>Aucune donnée pour cette certification cette semaine.</p>
            <a [routerLink]="['/exam']" [queryParams]="{ certId: selectedCert() }"
               class="btn btn-secondary">Passer un examen pour apparaître</a>
          </div>
        } @else {
          <div class="community__table-wrap">
            <table class="community__table">
              <thead>
                <tr>
                  <th>Rang</th>
                  <th>Participant</th>
                  <th>Score moyen</th>
                  <th>Examens</th>
                </tr>
              </thead>
              <tbody>
                @for (entry of leaderboard(); track entry.userId) {
                  <tr [class.community__row--me]="entry.isCurrentUser">
                    <td>
                      @switch (entry.rank) {
                        @case (1) { <span class="community__medal">🥇</span> }
                        @case (2) { <span class="community__medal">🥈</span> }
                        @case (3) { <span class="community__medal">🥉</span> }
                        @default  { <span class="community__rank">#{{ entry.rank }}</span> }
                      }
                    </td>
                    <td>
                      {{ entry.displayName }}
                      @if (entry.isCurrentUser) {
                        <span class="badge badge-info" style="margin-left:.5rem">Moi</span>
                      }
                    </td>
                    <td>
                      <span [class.text-success]="entry.averageScore >= 68"
                            [class.text-danger]="entry.averageScore < 68">
                        {{ entry.averageScore | number:'1.0-1' }}%
                      </span>
                    </td>
                    <td>{{ entry.totalExams }}</td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        }
      </div>
    </div>
  `,
  styles: [`
    .community { padding: 2rem 1rem; max-width: 900px; }
    h1 { font-size: 1.75rem; margin-bottom: 1.5rem; }
    .community__challenge-header { display: flex; align-items: center;
                                    justify-content: space-between; margin-bottom: .75rem; }
    .community__challenge-end { font-size: .85rem; color: var(--color-text-muted); }
    .community__challenge h2 { margin-bottom: .5rem; }
    .community__challenge p { color: var(--color-text-muted); margin-bottom: 1rem; }
    .community__challenge-stats { display: flex; gap: 1.5rem; margin-bottom: 1rem;
                                    font-size: .9rem; color: var(--color-text-muted); flex-wrap: wrap; }
    .community__leaderboard-header { display: flex; align-items: center;
                                      justify-content: space-between; flex-wrap: wrap;
                                      gap: 1rem; margin-bottom: 1rem; }
    .community__tabs { display: flex; gap: .5rem; flex-wrap: wrap; }
    .community__tab { padding: .35rem .75rem; border: 1px solid var(--color-border);
                       border-radius: var(--radius-md); background: none; cursor: pointer;
                       font-size: .8rem; font-weight: 600; }
    .community__tab--active { background: var(--color-secondary); color: white;
                                border-color: var(--color-secondary); }
    .community__loading, .community__empty { padding: 2rem; text-align: center;
                                              color: var(--color-text-muted); }
    .community__table-wrap { overflow-x: auto; }
    .community__table { width: 100%; border-collapse: collapse; }
    .community__table th, .community__table td {
      padding: .75rem 1rem; text-align: left;
      border-bottom: 1px solid var(--color-border); }
    .community__table th { font-weight: 700; font-size: .85rem; color: var(--color-text-muted); }
    .community__row--me { background: rgba(52, 152, 219, .08); font-weight: 600; }
    .community__medal { font-size: 1.4rem; }
    .community__rank { color: var(--color-text-muted); }
    .text-success { color: var(--color-success); font-weight: 600; }
    .text-danger  { color: var(--color-error);   font-weight: 600; }
  `]
})
export class CommunityComponent implements OnInit {
  private readonly http = inject(HttpClient);

  readonly leaderboard  = signal<LeaderboardEntry[]>([]);
  readonly challenge    = signal<WeeklyChallenge | null>(null);
  readonly selectedCert = signal("ocp21");
  readonly loading      = signal(false);

  ngOnInit(): void {
    this.loadLeaderboard("ocp21");
    this.http.get<{ data: WeeklyChallenge }>(`${environment.apiUrl}/community/challenge/ocp21`)
      .pipe(map(r => r.data))
      .subscribe({ next: c => this.challenge.set(c), error: () => {} });
  }

  loadLeaderboard(certId: string): void {
    this.selectedCert.set(certId);
    this.loading.set(true);
    this.http.get<{ data: LeaderboardEntry[] }>(
      `${environment.apiUrl}/community/leaderboard/${certId}`)
      .pipe(map(r => r.data))
      .subscribe({
        next: list => { this.leaderboard.set(list); this.loading.set(false); },
        error: () => { this.leaderboard.set([]); this.loading.set(false); }
      });
  }

  formatDate(iso: string): string {
    return new Date(iso).toLocaleDateString("fr-FR", { day: "numeric", month: "long" });
  }
}
