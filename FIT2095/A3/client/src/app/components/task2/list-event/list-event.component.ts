import { Component } from '@angular/core'
import { DatabaseService } from 'src/app/services/database.service'
import { DatePipe } from '../../../pipes/date.pipe'
import { DurationPipe } from 'src/app/pipes/duration.pipe'

@Component({
  selector: 'app-list-event',
  templateUrl: './list-event.component.html',
  styleUrls: ['./list-event.component.css'],
  providers: [DatePipe, DurationPipe]
})
export class ListEventComponent {
  imageUrl: string = '../assets/images/cabbage_app_banner.jpg'
  eventsDB: any[] = []

  constructor(private dbService: DatabaseService) { }

  onClick() {
    console.log(this.eventsDB)
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

  onDelete(eventId: string) {
    this.dbService.deleteEvent(eventId).subscribe(() => {
      this.dbService.getEvents().subscribe((data: any) => {
        this.eventsDB = data
      })
    })
  }

  ngOnInit() {
    this.dbService.getEvents().subscribe((data: any) => {
      this.eventsDB = data
    })
    console.log(this.eventsDB)
  }
}
