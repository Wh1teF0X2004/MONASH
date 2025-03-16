import { Component } from '@angular/core';
import { DatabaseService } from 'src/app/services/database.service';

interface opsObj {
  addCount: number,
  updateCount: number,
  deleteCount: number
}

@Component({
  selector: 'app-event-statistic',
  templateUrl: './event-statistic.component.html',
  styleUrls: ['./event-statistic.component.css']
})
export class EventStatisticComponent {

  statistic: opsObj = {
    addCount: 0,
    updateCount: 0,
    deleteCount: 0
  }

  constructor(private dbService: DatabaseService) { }

  ngOnInit() {
    this.dbService.getOperations().subscribe((data: any) => {
      console.log(data)
      this.statistic = data
    })
  }
}
