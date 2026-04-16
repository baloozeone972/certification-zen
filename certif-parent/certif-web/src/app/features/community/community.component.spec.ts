```typescript
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { CommonModule } from '@angular/common';
import { CommunityComponent } from './community.component';

describe('CommunityComponent', () => {
  let component: CommunityComponent;
  let fixture: ComponentFixture<CommunityComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CommonModule],
      declarations: [ CommunityComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CommunityComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should have the correct selector', () => {
    const el: HTMLElement = fixture.debugElement.nativeElement;
    expect(el.tagName).toBe('APP-COMMUNITY');
  });

  it('should have the correct template structure', () => {
    const el: HTMLElement = fixture.debugElement.nativeElement;
    const h1: HTMLHeadingElement = el.querySelector('h1')!;
    const p: HTMLParagraphElement = el.querySelector('.placeholder__msg')!;

    expect(h1).toBeTruthy();
    expect(h1.textContent).toBe('Communauté');

    expect(p).toBeTruthy();
    expect(p.textContent).toContain('Cette section sera disponible prochainement.');
  });

  it('should have the correct styles', () => {
    const el: HTMLElement = fixture.debugElement.nativeElement;
    expect(el.style.padding).toBe('3rem 1rem');
    expect(el.querySelector('.placeholder__msg')!.style.color).toContain('--color-text-muted');
  });
});
```
