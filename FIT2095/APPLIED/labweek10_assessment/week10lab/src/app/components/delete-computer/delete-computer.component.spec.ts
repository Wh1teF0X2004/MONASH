import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeleteComputerComponent } from './delete-computer.component';

describe('DeleteComputerComponent', () => {
  let component: DeleteComputerComponent;
  let fixture: ComponentFixture<DeleteComputerComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DeleteComputerComponent]
    });
    fixture = TestBed.createComponent(DeleteComputerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
