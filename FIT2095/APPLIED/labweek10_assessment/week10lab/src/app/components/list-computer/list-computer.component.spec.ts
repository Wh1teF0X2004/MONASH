import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListComputerComponent } from './list-computer.component';

describe('ListComputerComponent', () => {
  let component: ListComputerComponent;
  let fixture: ComponentFixture<ListComputerComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ListComputerComponent]
    });
    fixture = TestBed.createComponent(ListComputerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
