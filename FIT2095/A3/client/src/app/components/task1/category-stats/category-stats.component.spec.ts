import { ComponentFixture, TestBed } from '@angular/core/testing';
import { CategoryStatsComponent } from './category-stats.component';

describe('CategoryStatsComponent', () => {
  let component: CategoryStatsComponent;
  let fixture: ComponentFixture<CategoryStatsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CategoryStatsComponent]
    });
    fixture = TestBed.createComponent(CategoryStatsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
