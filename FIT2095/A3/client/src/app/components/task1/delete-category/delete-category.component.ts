import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { DatabaseService } from 'src/app/services/database.service';

@Component({
  selector: 'app-delete-category',
  templateUrl: './delete-category.component.html',
  styleUrls: ['./delete-category.component.css']
})
export class DeleteCategoryComponent {
  imageUrl: string = '../assets/images/cabbage_app_banner.jpg';
  id: string = "";

  constructor(private dbService: DatabaseService, private router: Router) {}

  deleteButton() {
    this.dbService.deleteCategory(this.id).subscribe({
      next: (result) => {
        // Successful response
        this.router.navigate(['/33085625/category/list']);
      },
      error: (error) => {
        // Error handling
        console.error('Error:', error);
        this.router.navigate(['/invalid']);
      }
    })
  }
}
