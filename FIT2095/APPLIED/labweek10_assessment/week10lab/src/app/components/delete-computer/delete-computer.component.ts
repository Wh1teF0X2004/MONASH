import { Component } from '@angular/core';
import { DatabaseService } from 'src/app/services/database.service';
import { Router } from "@angular/router";

@Component({
  selector: 'app-delete-computer',
  templateUrl: './delete-computer.component.html',
  styleUrls: ['./delete-computer.component.css']
})
export class DeleteComputerComponent {
  allComputer: any[] = [];

  constructor(private dbService: DatabaseService, private router: Router){}

  onGetComputers() {
    return this.dbService.listComputers()
  }

  ngOnInit() {
    this.onGetComputers();
  }

  onDeleteComputer(computer: any) {
    this.dbService.deleteComputer(computer._id)
    this.router.navigate(["/list-computer"]);
  }
}
