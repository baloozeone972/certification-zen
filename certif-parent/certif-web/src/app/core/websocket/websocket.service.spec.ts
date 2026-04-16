```typescript
import { TestBed } from '@angular/core/testing';
import { WebSocketService } from './websocket.service';
import { AuthService } from '../auth/auth.service';
import { Client, StompSubscription } from '@stomp/stompjs';
import SockJS from 'sockjs-client';
import { Subject } from 'rxjs';

describe('WebSocketService', () => {
  let service: WebSocketService;
  let authServiceMock: AuthService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        WebSocketService,
        { provide: AuthService, useValue: { getAccessToken: () => 'token' } }
      ]
    });
    service = TestBed.inject(WebSocketService);
    authServiceMock = TestBed.inject(AuthService);
  });

  it('should connect to the WebSocket server', () => {
    const clientSpy = spyOn(service as any, 'client', 'get').and.returnValue({
      active: false,
      activate: jasmine.createSpy()
    });
    service.connect();
    expect(clientSpy).toHaveBeenCalled();
    expect((service as any).client.activate).toHaveBeenCalled();
  });

  it('should not connect if already connected', () => {
    const clientSpy = spyOn(service as any, 'client', 'get').and.returnValue({
      active: true
    });
    service.connect();
    expect(clientSpy).toHaveBeenCalled();
    expect((service as any).client.activate).not.toHaveBeenCalled();
  });

  it('should subscribe to a STOMP topic and return an Observable', () => {
    const clientSpy = spyOn(service as any, 'client', 'get').and.returnValue({
      subscribe: jasmine.createSpy()
    });
    const subscription = service.subscribe<any>('/topic/test');
    expect(clientSpy).toHaveBeenCalled();
    expect((service as any).client.subscribe).toHaveBeenCalledWith('/topic/test', jasmine.any(Function));
  });

  it('should send a message to a STOMP destination', () => {
    const clientSpy = spyOn(service as any, 'client', 'get').and.returnValue({
      publish: jasmine.createSpy()
    });
    service.send('/destination/test', { key: 'value' });
    expect(clientSpy).toHaveBeenCalled();
    expect((service as any).client.publish).toHaveBeenCalledWith({
      destination: '/destination/test',
      body: JSON.stringify({ key: 'value' })
    });
  });

  it('should disconnect the client and clear subscriptions', () => {
    const clientSpy = spyOn(service as any, 'client', 'get').and.returnValue({
      deactivate: jasmine.createSpy(),
      forEach: (callback) => callback({ unsubscribe: jasmine.createSpy() })
    });
    service.disconnect();
    expect(clientSpy).toHaveBeenCalled();
    expect((service as any).client.deactivate).toHaveBeenCalled();
  });

  it('should clean up on ngOnDestroy', () => {
    const clientSpy = spyOn(service as any, 'client', 'get').and.returnValue({
      deactivate: jasmine.createSpy(),
      forEach: (callback) => callback({ unsubscribe: jasmine.createSpy() })
    });
    service.ngOnDestroy();
    expect(clientSpy).toHaveBeenCalled();
    expect((service as any).client.deactivate).toHaveBeenCalled();
  });

  it('should handle malformed messages in subscribe', () => {
    const clientSpy = spyOn(service as any, 'client', 'get').and.returnValue({
      subscribe: (topic, callback) => callback({ body: '{' })
    });
    const subscription = service.subscribe<any>('/topic/test');
    expect(clientSpy).toHaveBeenCalled();
    expect(subscription.observers.length).toBe(0);
  });

  it('should handle error when subscribing', () => {
    const clientSpy = spyOn(service as any, 'client', 'get').and.returnValue({
      subscribe: (topic, callback) => callback({ body: null })
    });
    const subscription = service.subscribe<any>('/topic/test');
    expect(clientSpy).toHaveBeenCalled();
    expect(subscription.observers.length).toBe(0);
  });
});
```
