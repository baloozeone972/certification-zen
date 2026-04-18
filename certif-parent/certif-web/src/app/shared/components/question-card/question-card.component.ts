import { ComponentFixture, TestBed, async } from '@angular/core/testing';
import { QuestionCardComponent } from './question-card.component';
import { QuestionService } from '../services/question.service';

describe('QuestionCardComponent', () => {
  let component: QuestionCardComponent;
  let fixture: ComponentFixture<QuestionCardComponent>;
  let questionServiceMock: jasmine.SpyObj<QuestionService>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ QuestionCardComponent ],
      providers: [
        { provide: QuestionService, useValue: jasmine.createSpyObj('QuestionService', ['getQuestion']) }
      ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(QuestionCardComponent);
    component = fixture.componentInstance;
    questionServiceMock = TestBed.inject(QuestionService) as jasmine.SpyObj<QuestionService>;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should display question when loaded', async(() => {
    const mockQuestion = { id: 1, text: 'What is the capital of France?' };
    questionServiceMock.getQuestion.and.returnValue(mockQuestion);

    fixture.detectChanges();
    tick();

    expect(component.question).toEqual(mockQuestion);
  }));

  it('should emit answer event when submitted', async(() => {
    const mockQuestion = { id: 1, text: 'What is the capital of France?' };
    const mockAnswer = 'Paris';
    questionServiceMock.getQuestion.and.returnValue(mockQuestion);

    fixture.detectChanges();
    tick();

    const answerEvent = new EventEmitter<string>();
    spyOn(component.answer, 'emit').and.callFake(() => answerEvent.emit(mockAnswer));

    const inputElement = fixture.debugElement.query(By.css('input')).nativeElement;
    inputElement.value = mockAnswer;
    inputElement.dispatchEvent(new Event('input'));

    const submitButton = fixture.debugElement.query(By.css('button')).nativeElement;
    submitButton.click();

    expect(component.answer.emit).toHaveBeenCalledWith(mockAnswer);
  }));
});