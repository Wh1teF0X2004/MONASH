import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { DatabaseService } from 'src/app/services/database.service';

@Component({
  selector: 'app-add-event',
  templateUrl: './add-event.component.html',
  styleUrls: ['./add-event.component.css']
})
export class AddEventComponent {
  imageUrl: string = '../assets/images/cabbage_app_banner.jpg';

  constructor(private dbService: DatabaseService, private router: Router) { }

  onSubmit = async(form: any) => {

    let obj = {
      "name": form.value.name,
      "description": form.value.description,
      "startDateTime": form.value.startDateTime,
      "duration": form.value.duration,
      "isActive": Boolean(form.value.isActive),
      "imagePath": form.value.imagePath == "" ? "event_page.jpg" : form.value.imagePath,
      "capacity": form.value.capacity,
      "tickets": form.value.tickets,
      "categoryList": form.value.categoryIds
    }

    console.log(obj)

    this.dbService.addEvent(obj).subscribe({
      next: (result) => {
        // Successful response
        this.router.navigate(['/euan/event/list']);
      },
      error: (error) => {
        // Error handling
        console.error('Error:', error);
        this.router.navigate(['/invalid']);
      }
    })
  }
}   