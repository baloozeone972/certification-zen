import {Routes} from "@angular/router";

export const LEARNING_ROUTES: Routes = [
    {
        path: "",
        component: () => import("./learning-dashboard.component").then(m => m.LearningDashboardComponent),
        canActivate: [JwtInterceptor]
    },
    {
        path: "flashcards/:certId",
        component: () => import("./flashcard-deck.component").then(m => m.FlashcardDeckComponent),
        canActivate: [JwtInterceptor]
    }
];