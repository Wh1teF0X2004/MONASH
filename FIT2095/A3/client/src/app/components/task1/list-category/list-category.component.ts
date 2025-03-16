import { Component } from '@angular/core';
import { DatabaseService } from 'src/app/services/database.service';
import { DatePipe } from '../../../pipes/date.pipe'
import { DurationPipe } from 'src/app/pipes/duration.pipe'
import { UppercasePipe } from 'src/app/pipes/uppercase.pipe';

@Component({
  selector: 'app-list-category',
  templateUrl: './list-category.component.html',
  styleUrls: ['./list-category.component.css'],
  providers: [DatePipe, DurationPipe, UppercasePipe]
})

export class ListCategoryComponent {
  imageUrl: string = '../assets/images/cabbage_app_banner.jpg';
  categoryDB: any[] = [];

  constructor(private dbService: DatabaseService) { }

  onClick() {
    console.log(this.categoryDB)
  }

  onDelete(id: string) {
    this.dbService.deleteCategory(id).subscribe(() => {
      this.dbService.getCategory().subscribe((data: any) => {
        this.categoryDB = data
      })
    })
  }

  ngOnInit() {
    this.dbService.getCategory().subscribe((data: any) => {
      this.categoryDB = data;
    });
    console.log(this.categoryDB)
  }
}
