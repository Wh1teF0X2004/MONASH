import { Component } from '@angular/core';
import { Router } from "@angular/router";
import { DatabaseService } from 'src/app/services/database.service';

@Component({
  selector: 'app-add-computer',
  templateUrl: './add-computer.component.html',
  styleUrls: ['./add-computer.component.css']
})
export class AddComputerComponent {
  cpu: string = "";
  ram: number = 0;
  id: string = "";

  constructor(private dbService: DatabaseService, private router: Router){}

  saveComputer(){
    let computerObj = {
      cpu: String(this.cpu),
      ram :Number(this.ram),
      id: String(this.id)
    };

    this.dbService.addComputer(computerObj);
    this.router.navigate(["/list-computer"]);
  }
  
}
