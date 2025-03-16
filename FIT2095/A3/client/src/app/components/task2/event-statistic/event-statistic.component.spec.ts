import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EventStatisticComponent } from './event-statistic.component';

describe('EventStatisticComponent', () => {
  let component: EventStatisticComponent;
  let fixture: ComponentFixture<EventStatisticComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [EventStatisticComponent]
    });
    fixture = TestBed.createComponent(EventStatisticComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
