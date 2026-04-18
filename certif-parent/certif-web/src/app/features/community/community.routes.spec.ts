import {TestBed} from '@angular/core/testing';
import {CommunityRoutes} from './community.routes';
import {RouterTestingModule} from '@angular/router/testing';

describe('CommunityRoutes', () => {
    let routes: Routes;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [RouterTestingModule],
            providers: []
        });
    });

    it('should be defined', () => {
        expect(CommunityRoutes).toBeDefined();
    });

    it('should have a route for the empty path', () => {
        expect(CommunityRoutes).toContain({path: '', loadComponent: jasmine.any(Function)});
    });

    it('should load the CommunityComponent when navigating to the empty path', async () => {
        const route = CommunityRoutes.find(route => route.path === '');
        const componentPromise = route.loadComponent();

        await expectAsync(componentPromise).toBeResolvedTo(jasmine.any(Function));
    });

    it('should handle error cases for loadComponent', () => {
        spyOn(console, 'error');

        const route = CommunityRoutes.find(route => route.path === '');
        const componentPromise = route.loadComponent();

        expectAsync(componentPromise).toBeRejected();
        expect(console.error).toHaveBeenCalled();
    });
});