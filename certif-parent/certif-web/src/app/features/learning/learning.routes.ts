import {Routes} from "@angular/router";

export const LEARNING_ROUTES: Routes = [
    {path: "", loadComponent: () => import("./learning-dashboard.component").then(m => m.LearningDashboardComponent)},
    {
        path: "flashcards/:certId",
        loadComponent: () => import("./flashcard-deck.component").then(m => m.FlashcardDeckComponent)
    }
];
