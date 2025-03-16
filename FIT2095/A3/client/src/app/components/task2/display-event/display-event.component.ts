import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { DatabaseService } from 'src/app/services/database.service';
import { DatePipe } from '../../../pipes/date.pipe'
import { DurationPipe } from 'src/app/pipes/duration.pipe'

@Component({
  selector: 'app-display-event',
  templateUrl: './display-event.component.html',
  styleUrls: ['./display-event.component.css'],
  providers: [DatePipe, DurationPipe]
})
export class DisplayEventComponent {
  objectId: string | null = ""; 
  eventId: string | null = ""; 
  name: string = ""
  image = ""
  description = ""
  startDateTime = ""
  durationInMinutes = 0
  capacity = 0
  ticketsAvailable = 0
  categoryList = []
  isActive = false
  createdAt = ""

  constructor(private dbService: DatabaseService, private route: ActivatedRoute, private router: Router) {
    this.eventId = this.route.snapshot.paramMap.get('id');
  }

  ngOnInit() {
    this.dbService.getEvents().subscribe((data: any) => {
      if (data && data.length > 0) {
        const matchingEvent = data.find((event: any) => event.id === this.eventId);
        console.log("matching event")
        console.log(matchingEvent)
        if (matchingEvent) {
          this.objectId = matchingEvent._id
          this.image = matchingEvent.imagePath
          this.name = matchingEvent.name
          this.description = matchingEvent.description
          this.startDateTime = matchingEvent.startDateTime
          this.durationInMinutes = matchingEvent.durationInMinutes
          this.capacity = matchingEvent.capacity
          this.ticketsAvailable = matchingEvent.ticketsAvailable
          this.categoryList = matchingEvent.categoryList
          this.isActive = matchingEvent.isActive
          this.createdAt = matchingEvent.createdAt
        } else {
          this.router.navigate(['/invalid']);
        }
      }
      else {
        this.router.navigate(['/invalid']);
      }
    })
  }

  calculateEndTime(startDateTime: string, duration: number) {
    const start = new Date(startDateTime);
    const end = new Date(start.getTime() + duration * 60000);

    const year = end.getFullYear();
    const month = (end.getMonth() + 1).toString().padStart(2, '0');
    const day = end.getDate().toString().padStart(2, '0');
    const hours = end.getHours().toString().padStart(2, '0');
    const minutes = end.getMinutes().toString().padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}`;
  }

}
