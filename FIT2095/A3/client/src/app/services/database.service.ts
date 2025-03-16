import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from "@angular/common/http";

const httpOptions = {
  headers: new HttpHeaders({ "Content-Type": "application/json" }),
};

@Injectable({
  providedIn: 'root'
})
export class DatabaseService {
  constructor(private http: HttpClient) { }

  // Task 1 Databse Functions  
  getCategory() {
    return this.http.get("/api/v1/category/33085625");
  }

  getCategoryByKeyword() {} // Not a requirement for A3

  addCategory(data: object){
    return this.http.post("/api/v1/category/33085625", data, httpOptions);
  }

  deleteCategory(id: string) {
    const body = {
      "id" : id
    }
    return this.http.delete("/api/v1/category/33085625", { body: body, ...httpOptions });
  }

  displayCategory() {}

  updateCategory(data: object) {
    return this.http.put("/api/v1/category/33085625", data, httpOptions);
  }
  
  // Task 2 Database Functions
  getEvents() {
    return this.http.get("/api/v1/event/euan");
  }

  getSoldEvents() {
    return this.http.get("/api/v1/event/euan");
  }

  addEvent(data: object) {
    return this.http.post("/api/v1/event/euan", data, httpOptions);
  }

  deleteEvent(eventId: string) {
    const body = {
      "eventId" : eventId
    }
    return this.http.delete("/api/v1/event/euan", { body: body, ...httpOptions });
  }

  updateEvent(data: object) {
    return this.http.put("/api/v1/event/euan", data, httpOptions);
  }

  // Operations 
  getOperations() {
    return this.http.get("/api/operation");
  }
}
