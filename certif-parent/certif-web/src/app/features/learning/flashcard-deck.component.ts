// certif-parent/certif-web/src/app/features/learning/flashcard-deck.component.ts
import {ChangeDetectionStrategy, Component, computed, inject, OnInit, signal} from "@angular/core";
import {ActivatedRoute, RouterLink} from "@angular/router";
import {CommonModule} from "@angular/common";
import {LearningService} from "../../core/services/learning.service";
import {Flashcard} from "../../core/models/learning.models";
import {FlashcardSwipeComponent} from "../../shared/components/flashcard-swipe/flashcard-swipe.component";

@Component({
    selector: "app-flashcard-deck",
    standalone: true,
    imports: [CommonModule, RouterLink, FlashcardSwipeComponent],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <div class="deck container">
      <a routerLink="/learning" class="btn back-btn">← Retour</a>
      <h1>Flashcards — {{ certId }}</h1>

      @if (done()) {
        <div class="deck__done card">
          <h2>Session terminée ! 🎉</h2>
          <p>{{ reviewed() }} cartes révisées aujourd'hui.</p>
          <a routerLink="/learning" class="btn btn-primary">Retour aux révisions</a>
        </div>
      } @else if (current()) {
        <div class="deck__progress">
          {{ currentIndex() + 1 }} / {{ flashcards().length }} cartes
        </div>
        <app-flashcard-swipe [flashcard]="current()!" (rated)="onRated($event)" />
      } @else {
        <div class="deck__loading">Chargement des flashcards...</div>
      }
    </div>
  `,
    styles: [`
    .deck { padding: 2rem 1rem; max-width: 700px; }
    .deck h1 { font-size: 1.5rem; margin: 1rem 0; }
    .back-btn { margin-bottom: 1rem; }
    .deck__progress { text-align: center; color: var(--color-text-muted);
                       margin-bottom: 1.5rem; }
    .deck__done { text-align: center; padding: 3rem; }
    .deck__done h2 { margin-bottom: 1rem; }
    .deck__done p  { margin-bottom: 1.5rem; color: var(--color-text-muted); }
    .deck__loading { text-align: center; padding: 3rem; color: var(--color-text-muted); }
  `]
})
export class FlashcardDeckComponent implements OnInit {
    readonly certId = signal("");
    readonly flashcards = signal<Flashcard[]>([]);
    readonly currentIndex = signal(0);
    readonly reviewed = signal(0);
    readonly current = computed(() => this.flashcards()[this.currentIndex()] ?? null);
    readonly done = computed(() => this.currentIndex() >= this.flashcards().length && this.flashcards().length > 0);
    private readonly learningService = inject(LearningService);
    private readonly route = inject(ActivatedRoute);

    ngOnInit(): void {
        const certId = this.route.snapshot.paramMap.get("certId") ?? "";
        this.certId.set(certId);
        this.learningService.getFlashcardsDue(certId).subscribe(f => this.flashcards.set(f));
    }

    onRated(rating: number): void {
        const card = this.current();
        if (!card) return;
        this.learningService.reviewFlashcard(card.id, rating).subscribe();
        this.reviewed.update(n => n + 1);
        this.currentIndex.update(i => i + 1);
    }
}
