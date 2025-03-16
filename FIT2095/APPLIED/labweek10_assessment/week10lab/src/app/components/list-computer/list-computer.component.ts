import { Component } from '@angular/core';
import { DatabaseService } from 'src/app/services/database.service';
import { Router } from "@angular/router";

@Component({
  selector: 'app-list-computer',
  templateUrl: './list-computer.component.html',
  styleUrls: ['./list-computer.component.css']
})
export class ListComputerComponent {
  allComputer: any[] = [];

  constructor(private dbService: DatabaseService, private router: Router){}

  ngOnInit(){
    this.allComputer = this.dbService.listComputers();
  }
}
