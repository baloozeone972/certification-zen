import {Routes} from '@angular/router';
import {TestBed} from '@angular/core/testing';
import {ProfileComponent} from './profile.component';

describe('PROFILE_ROUTES', () => {
    let routes: Routes;

    beforeEach(() => {
        TestBed.configureTestingModule({
            declarations: [ProfileComponent],
            providers: [
                {provide: ProfileComponent, useValue: new ProfileComponent()}
            ]
        });
        routes = TestBed.inject(Routes);
    });

    it('should have a route with path "" and loadComponent for ProfileComponent', () => {
        expect(routes).toContain({
            path: '',
            loadComponent: jasmine.any(Function)
        });
    });

    it('loadComponent should correctly import and return ProfileComponent', async () => {
        const component = await routes[0].loadComponent();
        expect(component.name).toBe('ProfileComponent');
    });

    it('should handle error cases when importing ProfileComponent fails', async () => {
        spyOn(routes[0], 'loadComponent').and.throwError(new Error('Failed to load component'));

        try {
            await routes[0].loadComponent();
            fail('Expected an error to be thrown');
        } catch (error) {
            expect(error.message).toBe('Failed to load component');
        }
    });
});