import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TextspeechComponent } from './textspeech.component';

describe('TextspeechComponent', () => {
  let component: TextspeechComponent;
  let fixture: ComponentFixture<TextspeechComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [TextspeechComponent]
    });
    fixture = TestBed.createComponent(TextspeechComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
