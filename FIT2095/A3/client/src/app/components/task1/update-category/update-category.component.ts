import { Component } from '@angular/core';
import { DatabaseService } from 'src/app/services/database.service';
import { DatePipe } from '../../../pipes/date.pipe'
import { Router } from '@angular/router';

@Component({
  selector: 'app-update-category',
  templateUrl: './update-category.component.html',
  styleUrls: ['./update-category.component.css'],
  providers: [DatePipe]
})
export class UpdateCategoryComponent {
  imageUrl: string = '../assets/images/cabbage_app_banner.jpg';
  categoryDB: any[] = []
  id: string = ""
  newCategoryName: string = ""
  newCategoryDescription: string = ""

  constructor(private dbService: DatabaseService, private router: Router) {}

  onClick() {
    console.log(this.categoryDB)
  }

  selectCategoryButton(id: string) {
    this.id = id
  }

  updateButton() {
    const obj = {
      id: this.id,
      name: this.newCategoryName,
      description: this.newCategoryDescription
    }

    this.dbService.updateCategory(obj).subscribe({
      next: (result) => {
        // Successful response
        console.log(obj)
        this.dbService.getCategory().subscribe((data: any) => {
          this.categoryDB = data
        })
      },
      error: (error) => {
        // Error handling
        console.log(obj)
        console.error('Error:', error);
        this.router.navigate(['/invalid']);
      }
    })
  }

  ngOnInit() {
    this.dbService.getCategory().subscribe((data: any) => {
      this.categoryDB = data
    })
    console.log(this.categoryDB)
  }
}
