import {Routes} from "@angular/router";
import {CommunityComponent} from "./community.component";
import {JwtInterceptor} from "../../auth/jwt.interceptor";

export const COMMUNITY_ROUTES: Routes = [
    {
        path: "",
        component: CommunityComponent,
        canActivate: [JwtInterceptor]
    }
];