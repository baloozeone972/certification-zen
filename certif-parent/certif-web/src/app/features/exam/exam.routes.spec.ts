import {TestBed} from '@angular/core/testing';
import {RouterModule, Routes} from '@angular/router';

describe('ExamRoutes', () => {
    let routes: Routes;

    beforeEach(() => {
        TestBed.configureTestingModule({
            providers: [
                {
                    provide: RouterModule,
                    useValue: {forRoot: () => ({})}
                }
            ]
        });
        routes = TestBed.inject(RouterModule).routes as Routes;
    });

    it('should contain the root route', () => {
        const route = routes.find(r => r.path === '');
        expect(route).toBeTruthy();
        expect(route.loadComponent).toBeDefined();
    });

    it('should contain the session route', () => {
        const route = routes.find(r => r.path === 'session/:sessionId');
        expect(route).toBeTruthy();
        expect(route.loadComponent).toBeDefined();
    });

    it('should not allow empty path for session route', () => {
        const route = routes.find(r => r.path === 'session/');
        expect(route).toBeFalsy();
    });

    it('should not allow missing sessionId in session route', () => {
        const route = routes.find(r => r.path === 'session');
        expect(route).toBeFalsy();
    });

    it('should handle invalid path', () => {
        const route = routes.find(r => r.path === 'invalid-path');
        expect(route).toBeFalsy();
    });
});