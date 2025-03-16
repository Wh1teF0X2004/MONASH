import { Component } from '@angular/core';
import { io } from 'socket.io-client';
import { DatePipe } from '../../../pipes/date.pipe'
import { DurationPipe } from 'src/app/pipes/duration.pipe'
import { LanguagePipe } from 'src/app/pipes/language.pipe';

interface translatorInstance {
  text: string
  lang: string
  translation: string
}

@Component({
  selector: 'app-translator',
  templateUrl: './translator.component.html',
  styleUrls: ['./translator.component.css'],
  providers: [DatePipe, DurationPipe, LanguagePipe]
})
export class TranslatorComponent {
  translations: translatorInstance[] = []
  
  text = ""
  lang = ""

  socket: any;
  constructor() {
    this.socket = io();
  }

  ngOnInit() {
    this.listenTranslate();
  }

  listenTranslate() {
    this.socket.on("onTranslate", (data: translatorInstance) => {
      console.log(data)
      this.translations.push(data)
    });
  }

  sendTranslate() {
    const myObj: translatorInstance = {
      text: this.text,
      lang: this.lang,
      translation: ""
    }

    console.log(myObj)

    this.text = ""
    this.lang = ""

    this.socket.emit("translate", myObj)
  }

  onClick() {
    console.log(this.translations)
  }
  
}
