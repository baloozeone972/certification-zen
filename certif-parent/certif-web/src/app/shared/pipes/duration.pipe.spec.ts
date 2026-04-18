import { DurationPipe } from './duration.pipe';

describe('DurationPipe', () => {
  let pipe: DurationPipe;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [DurationPipe]
    });
    pipe = TestBed.inject(DurationPipe);
  });

  it('should return "--" for null input', () => {
    expect(pipe.transform(null)).toBe("--");
  });

  it('should return "--" for undefined input', () => {
    expect(pipe.transform(undefined)).toBe("--");
  });

  it('should return "0h01m00s" for 60 seconds', () => {
    expect(pipe.transform(60)).toBe("0h01m00s");
  });

  it('should return "3600s" for 3600 seconds', () => {
    expect(pipe.transform(3600)).toBe("3600s");
  });

  it('should return "59:59" for 3599 seconds', () => {
    expect(pipe.transform(3599)).toBe("59:59");
  });

  it('should return "1h00m00s" for 3600 seconds with leading zero in hours', () => {
    expect(pipe.transform(3600)).toBe("1h00m00s");
  });
});
