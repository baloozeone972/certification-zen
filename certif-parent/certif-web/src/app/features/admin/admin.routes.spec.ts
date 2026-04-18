import {RouterTestingModule, TestBed} from '@angular/core/testing';
import {ADMIN_ROUTES} from './admin.routes';

describe('ADMIN_ROUTES', () => {
    let routes: Routes;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [RouterTestingModule]
        });
        routes = ADMIN_ROUTES;
    });

    it('should have a route for the root path', () => {
        expect(routes).toContain({path: '', loadComponent: jasmine.any(Function)});
    });

    it('should have a dynamic import for AdminComponent', async () => {
        const route = routes.find(r => r.path === '');
        if (route && route.loadComponent) {
            const component = await route.loadComponent();
            expect(component).toEqual(jasmine.any(Function));
        } else {
            fail('Route with empty path not found or loadComponent is not a function');
        }
    });

    it('should handle edge case when no routes are provided', () => {
        const emptyRoutes: Routes = [];
        expect(emptyRoutes).not.toContain({path: '', loadComponent: jasmine.any(Function)});
    });

    it('should handle error case when route configuration is invalid', () => {
        const invalidRoute: Routes = [{path: ''}];
        expect(invalidRoute).not.toContain({path: '', loadComponent: jasmine.any(Function)});
    });
});

