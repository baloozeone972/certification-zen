import { TestBed } from '@angular/core/testing';
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

    it('should return "0h00m00s" for 0 seconds', () => {
        expect(pipe.transform(0)).toBe("0h00m00s");
    });

    it('should return "1h00m00s" for 3600 seconds', () => {
        expect(pipe.transform(3600)).toBe("1h00m00s");
    });

    it('should return "01:00" for 60 seconds', () => {
        expect(pipe.transform(60)).toBe("01:00");
    });

    it('should return "00:30" for 30 seconds', () => {
        expect(pipe.transform(30)).toBe("00:30");
    });
});