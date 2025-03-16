import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { DatabaseService } from 'src/app/services/database.service';

@Component({
  selector: 'app-delete-event',
  templateUrl: './delete-event.component.html',
  styleUrls: ['./delete-event.component.css']
})
export class DeleteEventComponent {
  imageUrl: string = '../assets/images/cabbage_app_banner.jpg';
  eventId: string = "";

  constructor(private dbService: DatabaseService, private router: Router) { }

  deleteButton() {
    this.dbService.deleteEvent(this.eventId).subscribe({
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
