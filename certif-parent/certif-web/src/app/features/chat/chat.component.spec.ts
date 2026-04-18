import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ChatComponent } from './chat.component';
import { AiService } from '../../core/services/ai.service';
import { signal } from '@angular/core';

describe('ChatComponent', () => {
  let component: ChatComponent;
  let fixture: ComponentFixture<ChatComponent>;
  let aiServiceSpy: jasmine.SpyObj<AiService>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ChatComponent ],
      providers: [
        { provide: AiService, useValue: jasmine.createSpyObj('AiService', ['chat']) }
      ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ChatComponent);
    component = fixture.componentInstance;
    aiServiceSpy = TestBed.inject(AiService) as jasmine.SpyObj<AiService>;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should add a message when sending a valid input', () => {
    component.inputText.set("What is AWS?");
    component.send();

    expect(aiServiceSpy.chat).toHaveBeenCalledWith("What is AWS?");
    expect(component.messages()).toEqual([
      { role: "assistant", content: "Bonjour ! Je suis votre assistant CertifApp. Posez-moi des questions sur vos certifications Java, AWS, Kubernetes et bien d'autres." },
      { role: "user", content: "What is AWS?" },
      { role: "assistant", content: "AWS stands for Amazon Web Services." }
    ]);
  });

  it('should not send an empty message', () => {
    component.inputText.set("");
    component.send();

    expect(aiServiceSpy.chat).not.toHaveBeenCalled();
    expect(component.messages()).toEqual([
      { role: "assistant", content: "Bonjour ! Je suis votre assistant CertifApp. Posez-moi des questions sur vos certifications Java, AWS, Kubernetes et bien d'autres." }
    ]);
  });

  it('should handle error when AI service fails', () => {
    aiServiceSpy.chat.and.returnValue(jasmine.createSpyObj('Observable', ['subscribe']).subscribe({ error: () => {} }));
    component.inputText.set("What is AWS?");
    component.send();

    expect(aiServiceSpy.chat).toHaveBeenCalledWith("What is AWS?");
    expect(component.messages()).toEqual([
      { role: "assistant", content: "Bonjour ! Je suis votre assistant CertifApp. Posez-moi des questions sur vos certifications Java, AWS, Kubernetes et bien d'autres." },
      { role: "user", content: "What is AWS?" },
      { role: "assistant", content: "Désolé, une erreur s'est produite. Veuillez réessayer." }
    ]);
  });
});
