import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddComputerComponent } from './add-computer.component';

describe('AddComputerComponent', () => {
  let component: AddComputerComponent;
  let fixture: ComponentFixture<AddComputerComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AddComputerComponent]
    });
    fixture = TestBed.createComponent(AddComputerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
