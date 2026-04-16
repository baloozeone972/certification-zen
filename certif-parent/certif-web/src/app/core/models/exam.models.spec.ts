```typescript
import { TestBed } from '@angular/core/testing';
import { ExamModelService } from './exam.models.service';

describe('ExamModelService', () => {
  let service: ExamModelService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ExamModelService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should create an instance', () => {
    expect(service).toBeTruthy();
  });
});
```
