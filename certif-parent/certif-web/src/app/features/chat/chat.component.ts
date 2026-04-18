import {async, ComponentFixture, TestBed} from '@angular/core/testing';
import {ChatComponent} from './chat.component';
import {AiService} from '../../core/services/ai.service';

class MockAiService {
    chat(text: string) {
        return new Promise<{ message: string }>((resolve, reject) => {
            if (text === "error") {
                reject();
            } else {
                resolve({message: `Answer to ${text}`});
            }
        });
    }
}

describe('ChatComponent', () => {
    let component: ChatComponent;
    let fixture: ComponentFixture<ChatComponent>;
    let aiService: AiService;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [ChatComponent],
            providers: [
                {provide: AiService, useClass: MockAiService}
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(ChatComponent);
        component = fixture.componentInstance;
        aiService = TestBed.inject(AiService);
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should add user message and call aiService.chat on send', async(() => {
        component.inputText.set("test");
        component.send();
        fixture.detectChanges();

        expect(component.messages()).toContain({role: "user", content: "test"});
        expect(aiService.chat).toHaveBeenCalledWith("test");
    }));

    it('should handle error from aiService.chat', async(() => {
        component.inputText.set("error");
        component.send();
        fixture.detectChanges();

        expect(component.messages()).toContain({
            role: "assistant",
            content: "Désolé, une erreur s'est produite. Veuillez réessayer."
        });
    }));

    it('should clear inputText after sending', async(() => {
        component.inputText.set("test");
        component.send();
        fixture.detectChanges();

        expect(component.inputText()).toBe("");
    }));

    it('should set loading to true and false during chat', async(() => {
        component.inputText.set("test");
        component.send();
        fixture.detectChanges();

        expect(component.loading()).toBe(true);
        aiService.chat("test").then(() => {
            fixture.detectChanges();
            expect(component.loading()).toBe(false);
        });
    }));
});