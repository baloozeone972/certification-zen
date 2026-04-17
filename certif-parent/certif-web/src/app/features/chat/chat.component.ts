// certif-parent/certif-web/src/app/features/chat/chat.component.ts
import {ChangeDetectionStrategy, Component, inject, signal} from "@angular/core";
import {CommonModule} from "@angular/common";
import {FormsModule} from "@angular/forms";
import {AiService} from "../../core/services/ai.service";

interface ChatMessage {
    role: "user" | "assistant";
    content: string;
}

@Component({
    selector: "app-chat",
    standalone: true,
    imports: [CommonModule, FormsModule],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <div class="chat">
      <div class="chat__header">
        <h1>🤖 Assistant IA</h1>
        <p>Posez vos questions sur vos certifications</p>
      </div>
      <div class="chat__messages" #messagesContainer>
        @for (msg of messages(); track $index) {
          <div class="chat-msg" [class.chat-msg--user]="msg.role === 'user'"
                                 [class.chat-msg--ai]="msg.role === 'assistant'">
            <div class="chat-msg__bubble">{{ msg.content }}</div>
          </div>
        }
        @if (loading()) {
          <div class="chat-msg chat-msg--ai">
            <div class="chat-msg__bubble chat-msg__bubble--typing">...</div>
          </div>
        }
      </div>
      <div class="chat__input">
        <textarea [(ngModel)]="inputText" placeholder="Posez votre question..."
                  (keydown.enter)="$event.shiftKey ? null : ($event.preventDefault(), send())"
                  rows="2"></textarea>
        <button class="btn btn-primary" [disabled]="!inputText().trim() || loading()"
                (click)="send()">Envoyer</button>
      </div>
    </div>
  `,
    styles: [`
    .chat { display: flex; flex-direction: column; height: calc(100vh - 60px); max-width: 800px; margin: 0 auto; }
    .chat__header { padding: 1.5rem; border-bottom: 1px solid var(--color-border);
                     background: var(--color-surface); }
    .chat__header h1 { font-size: 1.25rem; margin-bottom: .25rem; }
    .chat__header p  { font-size: .875rem; color: var(--color-text-muted); }
    .chat__messages { flex: 1; overflow-y: auto; padding: 1.5rem; display: flex;
                       flex-direction: column; gap: 1rem; }
    .chat-msg { display: flex; }
    .chat-msg--user  { justify-content: flex-end; }
    .chat-msg--ai    { justify-content: flex-start; }
    .chat-msg__bubble { max-width: 75%; padding: .75rem 1rem; border-radius: var(--radius-md);
                         line-height: 1.6; white-space: pre-wrap; }
    .chat-msg--user  .chat-msg__bubble { background: var(--color-secondary); color: white; }
    .chat-msg--ai    .chat-msg__bubble { background: var(--color-surface);
                                           border: 1px solid var(--color-border); }
    .chat-msg__bubble--typing { font-style: italic; color: var(--color-text-muted); }
    .chat__input { padding: 1rem; border-top: 1px solid var(--color-border);
                    background: var(--color-surface); display: flex; gap: .75rem; }
    .chat__input textarea { flex: 1; border: 1px solid var(--color-border);
                              border-radius: var(--radius-md); padding: .6rem .75rem;
                              resize: none; font-family: var(--font-sans); font-size: .95rem; }
  `]
})
export class ChatComponent {
    readonly messages = signal<ChatMessage[]>([{
        role: "assistant",
        content: "Bonjour ! Je suis votre assistant CertifApp. Posez-moi des questions sur vos certifications Java, AWS, Kubernetes et bien d'autres."
    }]);
    readonly inputText = signal("");
    readonly loading = signal(false);
    private readonly aiService = inject(AiService);

    send(): void {
        const text = this.inputText().trim();
        if (!text) return;

        this.messages.update(m => [...m, {role: "user", content: text}]);
        this.inputText.set("");
        this.loading.set(true);

        this.aiService.chat(text).subscribe({
            next: res => {
                this.messages.update(m => [...m, {role: "assistant", content: res.message}]);
                this.loading.set(false);
            },
            error: () => {
                this.messages.update(m => [...m, {
                    role: "assistant",
                    content: "Désolé, une erreur s'est produite. Veuillez réessayer."
                }]);
                this.loading.set(false);
            }
        });
    }
}
