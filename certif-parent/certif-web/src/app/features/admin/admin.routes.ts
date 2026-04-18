import {Routes} from "@angular/router";
import {async, TestBed} from '@angular/core/testing';
import {JwtInterceptor} from "../../auth/jwt.interceptor";
import {AdminComponent} from "./admin.component";

describe('ADMIN_ROUTES', () => {
    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [AdminComponent],
            providers: [
                {provide: JwtInterceptor, useValue: {}}
            ]
        }).compileComponents();
    }));

    it('should load AdminComponent when path is empty', async(() => {
        const routes = TestBed.inject(Routes);
        expect(routes[0].loadComponent).toEqual(() => import("./admin.component").then(m => m.AdminComponent));
        expect(routes[0].canActivate).toEqual([JwtInterceptor]);
    }));
});