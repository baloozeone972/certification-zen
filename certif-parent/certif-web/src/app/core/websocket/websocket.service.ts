// certif-parent/certif-web/src/app/core/websocket/websocket.service.ts
import {inject, Injectable, OnDestroy} from "@angular/core";
import {Client, StompSubscription} from "@stomp/stompjs";
import SockJS from "sockjs-client";
import {Subject} from "rxjs";
import {environment} from "../../../environments/environment";
import {AuthService} from "../auth/auth.service";

/**
 * WebSocket STOMP service for real-time features.
 * Used for: challenge live leaderboard, study group chat.
 */
@Injectable({providedIn: "root"})
export class WebSocketService implements OnDestroy {
    private readonly authService = inject(AuthService);
    private client: Client | null = null;
    private subscriptions: StompSubscription[] = [];

    /** Connect to the WebSocket server. */
    connect(): void {
        if (this.client?.active) return;

        this.client = new Client({
            webSocketFactory: () => new SockJS(environment.wsUrl),
            connectHeaders: {
                Authorization: `Bearer ${this.authService.getAccessToken() ?? ""}`
            },
            reconnectDelay: 5000
        });

        this.client.activate();
    }

    /** Subscribe to a STOMP topic and return an Observable. */
    subscribe<T>(topic: string): Subject<T> {
        const subject = new Subject<T>();
        this.client?.subscribe(topic, msg => {
            try {
                subject.next(JSON.parse(msg.body));
            } catch { /* ignore malformed messages */
            }
        });
        return subject;
    }

    /** Send a message to a STOMP destination. */
    send(destination: string, body: unknown): void {
        this.client?.publish({
            destination,
            body: JSON.stringify(body)
        });
    }

    disconnect(): void {
        this.subscriptions.forEach(s => s.unsubscribe());
        this.client?.deactivate();
    }

    ngOnDestroy(): void {
        this.disconnect();
    }
}
