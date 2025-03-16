import { Component } from '@angular/core';
import { DatabaseService } from 'src/app/services/database.service';
import { DatePipe } from '../../../pipes/date.pipe'
import { Router } from '@angular/router';

@Component({
  selector: 'app-update-event',
  templateUrl: './update-event.component.html',
  styleUrls: ['./update-event.component.css'],
  providers: [DatePipe]
})
export class UpdateEventComponent {
  imageUrl: string = '../assets/images/cabbage_app_banner.jpg';
  eventsDB: any[] = []
  eventId: string = ""
  eventNameUpdate: String = ""
  eventNameCapacity: Number = 0

  constructor(private dbService: DatabaseService, private router: Router) { }

  onClick() {
    console.log(this.eventsDB)
  }

  selectEventButton(id: string) {
    this.eventId = id
  }

  updateButton() {
    const obj = {
      eventId: this.eventId,
      newName: this.eventNameUpdate,
      newCapacity: this.eventNameCapacity
    }

    this.dbService.updateEvent(obj).subscribe({
      next: (result) => {
        // Successful response
        this.dbService.getEvents().subscribe((data: any) => {
          this.eventsDB = data
        })
      },
      error: (error) => {
        // Error handling
        console.error('Error:', error);
        this.router.navigate(['/invalid']);
      }
    })
  }

  ngOnInit() {
    this.dbService.getEvents().subscribe((data: any) => {
      this.eventsDB = data
    })
    console.log(this.eventsDB)
  }
}
