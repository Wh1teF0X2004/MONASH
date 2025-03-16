import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class DatabaseService {

  constructor() { }

  allComputers = { cpu: string, ram: number, id: string }[]  = []

  generateRandomid(){
    const allLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const allNumbers = '0123456789';

    let randomLetters = allLetters[Math.floor(Math.random() * allLetters.length)] + allLetters[Math.floor(Math.random() * allLetters.length)];
    let randomNumbers = allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)];

    const randomNewID = `C${randomLetters}-${randomNumbers}`;
    return randomNewID;
  }

  addComputer(data: { cpu: string; ram: number }) {
    const newComputer = {id: this.generateRandomid(), ...data}
    this.allComputers.push(newComputer)
  }

  listComputers(): any[] {
    return this.allComputers
  }

  deleteComputer(id: string) {
    this.allComputers = this.allComputers.filter(computer => computer.id !== id);
  }
}
