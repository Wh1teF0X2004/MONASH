import { Component } from '@angular/core';
import { DatabaseService } from 'src/app/services/database.service';

interface operationObj {
  categoryCount: number,
  eventCount: number
}

@Component({
  selector: 'app-category-stats',
  templateUrl: './category-stats.component.html',
  styleUrls: ['./category-stats.component.css']
})
export class CategoryStatsComponent {
  statistic: operationObj = {
    categoryCount: 0,
    eventCount: 0
  }

  constructor(private dbService: DatabaseService) { }

  ngOnInit() {
    this.dbService.getOperations().subscribe((data: any) => {
      console.log(data)
      this.statistic = data
    })
  }
}
