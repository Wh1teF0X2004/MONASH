import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'week10lab';

  computer_cpu: string = "";
  computer_ram: number = 0;
  computer_id: string = "";
}
