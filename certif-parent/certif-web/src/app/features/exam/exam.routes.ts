// certif-parent/certif-web/src/app/features/exam/exam.routes.ts
import {Routes} from "@angular/router";

export const EXAM_ROUTES: Routes = [
    {
        path: "",
        loadComponent: () => import("./exam-setup.component").then(m => m.ExamSetupComponent)
    },
    {
        path: "session/:sessionId",
        loadComponent: () => import("./exam-engine.component").then(m => m.ExamEngineComponent)
    }
];
