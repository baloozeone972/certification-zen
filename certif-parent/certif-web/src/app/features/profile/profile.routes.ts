import {Routes} from "@angular/router";
import {TestBed, async} from '@angular/core/testing';
import {ProfileComponent} from "./profile.component";
import {JwtInterceptor} from "../../interceptors/jwt.interceptor";

describe('PROFILE_ROUTES', () => {
    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [ProfileComponent],
            providers: [
                {provide: JwtInterceptor, useValue: {}}
            ]
        }).compileComponents();
    }));

    it('should have a route for the empty path', () => {
        const routes: Routes = TestBed.inject(Routes);
        const route = routes.find(r => r.path === '');
        expect(route).toBeTruthy();
        expect(route?.loadComponent).toEqual(() => import("./profile.component").then(m => m.ProfileComponent));
        expect(route?.canActivate).toEqual([JwtInterceptor]);
    });
});