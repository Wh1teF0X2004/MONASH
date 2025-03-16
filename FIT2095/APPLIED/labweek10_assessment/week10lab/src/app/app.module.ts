import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { AddComputerComponent } from './components/add-computer/add-computer.component';
import { ListComputerComponent } from './components/list-computer/list-computer.component';
import { DeleteComputerComponent } from './components/delete-computer/delete-computer.component';
import { RouterModule, Routes } from '@angular/router';
import { DatabaseService } from './services/database.service';
import { FormsModule } from '@angular/forms';

const routes: Routes = [
  { path: 'add-computer', component: AddComputerComponent},
  { path: 'list-computer', component: ListComputerComponent},
  { path: 'delete-computer', component: DeleteComputerComponent}
]

@NgModule({
  declarations: [
    AppComponent,
    AddComputerComponent,
    ListComputerComponent,
    DeleteComputerComponent
  ],
  imports: [
    BrowserModule, RouterModule.forRoot(routes), FormsModule
  ],
  providers: [DatabaseService],
  bootstrap: [AppComponent]
})
export class AppModule { }
