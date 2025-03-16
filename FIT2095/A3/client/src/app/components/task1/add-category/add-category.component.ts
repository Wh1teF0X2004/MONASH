import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { DatabaseService } from 'src/app/services/database.service';

@Component({
  selector: 'app-add-category',
  templateUrl: './add-category.component.html',
  styleUrls: ['./add-category.component.css']
})
export class AddCategoryComponent {
  imageUrl: string = '../assets/images/cabbage_app_banner.jpg';

  constructor(private dbService: DatabaseService, private router: Router) {}

  // let catObj = {
  //   "name": this.name,
  //   "description": this.description,
  //   "image": this.image == "" ? "category_page.jpg" : this.image,
  //   "createdAt":  Date.now,
  //   "eventsList": []
  // }

  // addNewCategory(){
  //   console.log(catObj)

  //   this.dbService.addCategory(catObj).subscribe(() => {
  //     this.router.navigate(['/33085625/category/list'])
  //   })
  // }

  onSubmit = async(form: any) => {
    let obj = {
      "name": form.value.name,
      "description": form.value.description,
      "image": form.value.image == "" ? "/category_page.jpg" : form.value.image,
      "createdAt":  new Date(Date.now()),
      "eventsList": []
    }

    console.log(obj)

    this.dbService.addCategory(obj).subscribe({
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
