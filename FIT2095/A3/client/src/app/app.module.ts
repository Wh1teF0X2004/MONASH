import { NgModule, isDevMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';
import { InvalidDataComponent } from './components/invalid-data/invalid-data.component';
import { DatabaseService } from './services/database.service';
import { ServiceWorkerModule } from '@angular/service-worker';
import { AddEventComponent } from './components/task2/add-event/add-event.component';
import { ListEventComponent } from './components/task2/list-event/list-event.component';
import { DeleteEventComponent } from './components/task2/delete-event/delete-event.component';
import { DisplayEventComponent } from './components/task2/display-event/display-event.component';
import { UpdateEventComponent } from './components/task2/update-event/update-event.component';
import { RouterModule, Routes } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { LandingPageComponent } from './components/landing-page/landing-page.component';
import { DisplayCategoryComponent } from './components/task1/display-category/display-category.component';
import { AddCategoryComponent } from './components/task1/add-category/add-category.component';
import { DeleteCategoryComponent } from './components/task1/delete-category/delete-category.component';
import { ListCategoryComponent } from './components/task1/list-category/list-category.component';
import { DatePipe } from './pipes/date.pipe';
import { DurationPipe } from './pipes/duration.pipe';
import { UpdateCategoryComponent } from './components/task1/update-category/update-category.component';
import { TranslatorComponent } from './components/task2/translator/translator.component';
import { UppercasePipe } from './pipes/uppercase.pipe';
import { TextspeechComponent } from './components/task1/textspeech/textspeech.component';
import { EventStatisticComponent } from './components/task2/event-statistic/event-statistic.component';
import { LanguagePipe } from './pipes/language.pipe';
import { CategoryStatsComponent } from './components/task1/category-stats/category-stats.component';

const appRoutes: Routes = [
  { path: 'euan/event/add', component: AddEventComponent },
  { path: 'euan/event/delete', component: DeleteEventComponent },
  { path: 'euan/event/list', component: ListEventComponent },
  { path: 'euan/event/update', component: UpdateEventComponent },
  { path: 'euan/event/detail/:id', component: DisplayEventComponent },
  { path: 'euan/event/translator', component: TranslatorComponent},
  { path: 'euan/event/statistics', component: EventStatisticComponent},
  { path: '33085625/category/add', component: AddCategoryComponent }, 
  { path: '33085625/category/delete', component: DeleteCategoryComponent },
  { path: '33085625/category/list', component: ListCategoryComponent },
  { path: '33085625/category/display/:id', component: DisplayCategoryComponent },
  { path: '33085625/category/update', component: UpdateCategoryComponent },
  { path: '33085625/category/textspeech', component: TextspeechComponent },
  { path: '33085625/category/stats', component: CategoryStatsComponent },
  { path: 'invalid', component: InvalidDataComponent },
  { path: '', component: LandingPageComponent },
  { path: '**', component: PageNotFoundComponent },
];

@NgModule({
  declarations: [
    AppComponent,
    PageNotFoundComponent,
    InvalidDataComponent,
    AddEventComponent,
    ListEventComponent,
    DeleteEventComponent,
    DisplayEventComponent,
    UpdateEventComponent,
    LandingPageComponent,
    DisplayCategoryComponent,
    AddCategoryComponent,
    DeleteCategoryComponent,
    ListCategoryComponent,
    DatePipe,
    DurationPipe,
    UpdateCategoryComponent,
    TranslatorComponent,
    UppercasePipe,
    TextspeechComponent,
    EventStatisticComponent,
    LanguagePipe,
    CategoryStatsComponent
  ],
  imports: [
    RouterModule.forRoot(appRoutes, { useHash: false }),
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    ServiceWorkerModule.register('ngsw-worker.js', {
      enabled: !isDevMode(),
      // Register the ServiceWorker as soon as the application is stable
      // or after 30 seconds (whichever comes first).
      registrationStrategy: 'registerWhenStable:30000'
    })
    //, HttpClientModule
  ],
  providers: [DatabaseService],
  bootstrap: [AppComponent]
})
export class AppModule { }
