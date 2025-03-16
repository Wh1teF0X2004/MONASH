import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { DatabaseService } from 'src/app/services/database.service';
import { DatePipe } from '../../../pipes/date.pipe'
import { DurationPipe } from 'src/app/pipes/duration.pipe'
import { UppercasePipe } from 'src/app/pipes/uppercase.pipe';

interface Event {
  id: string; 
  name: string;
  startDateTime: Date; 
  durationInMinutes: number; 
  isActive: boolean; 
  capacity: number; 
  ticketsAvailable: number; 
}

@Component({
  selector: 'app-display-category',
  templateUrl: './display-category.component.html',
  styleUrls: ['./display-category.component.css'],
  providers: [DatePipe, DurationPipe, UppercasePipe]
})
export class DisplayCategoryComponent {
  imageUrl: string = '../assets/images/cabbage_app_banner.jpg';
  
  id: string | null = ""; // Category Id
  objectId: string | null = ""; 
  name: string = ""
  image = ""
  description: string = ""
  eventsList: any[] = []
  createdAt = "" // Created Date Time

  eventsDB: any[] = []
  eventInCategory: any[] = []
  // eventInCategory: Event[] = [];

  constructor(private dbService: DatabaseService, private route: ActivatedRoute, private router: Router) {
    this.id = this.route.snapshot.paramMap.get('id');
    console.log(this.id)
  }

  ngOnInit() {
    this.dbService.getCategory().subscribe((data: any) => {
      if (data && data.length > 0) {
        const matchingCategory = data.find((category: any) => category.id === this.id);
        console.log("matching category")
        console.log(matchingCategory)
        if (matchingCategory) {
          this.objectId = matchingCategory._id
          this.id = matchingCategory.id
          this.image = matchingCategory.image
          this.name = matchingCategory.name
          this.description = matchingCategory.description
          this.createdAt = matchingCategory.createdAt
          this.eventsList = matchingCategory.eventsList
        } else {
          this.router.navigate(['/invalid']);
        }
      }
      else {
        this.router.navigate(['/invalid']);
      }
    })

    this.dbService.getEvents().subscribe((data: any) => {
      this.eventsDB = data
      // Filter events from eventsDB based on the eventsList
      this.eventInCategory = this.eventsDB.filter((event: any) => this.eventsList.includes(event.id));
      console.log("eventsDB")
      console.log(this.eventsDB)
      console.log("eventInCategory")
      console.log(this.eventInCategory)
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
