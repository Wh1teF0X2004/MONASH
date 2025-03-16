import { Component } from '@angular/core';
import { io } from 'socket.io-client';

@Component({
  selector: 'app-textspeech',
  templateUrl: './textspeech.component.html',
  styleUrls: ['./textspeech.component.css']
})
export class TextspeechComponent {
  text: String = "";
  thePath: String = "";
  fileCounter: number = 0;
  outputPath: String = "/server/audio_files/output"+this.fileCounter+".mp3";
  audioFileName: String = "output"+this.fileCounter+".mp3"
  isConverted: Boolean = false;
  
  socket: any;
  constructor() {
    this.socket = io();
  }

  ngOnInit() {
    this.listenText();
  }

  listenText(){
    this.socket.on("speech", (thePath: string) => {
      this.isConverted = true;
      console.log("path: " + thePath)
      this.thePath = thePath
    });
  }

  onSubmit(){
    console.log(this.text)
    this.isConverted = false;
    console.log("empty?"+this.thePath)
    // this.thePath = ""
    console.log("empty?"+this.thePath)
    this.socket.emit("onTextSpeech", this.text)
    // this.fileCounter += 1;
  }
}
