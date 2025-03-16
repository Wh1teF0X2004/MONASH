import { Component } from "@angular/core";
import { io } from "socket.io-client";

interface BroadcastMessage {
  name: string;
  message: string;
}

@Component({
  selector: "app-root",
  templateUrl: "./app.component.html",
  styleUrls: ["./app.component.css"],
})
export class AppComponent {
  title = "broadcast-app";
  message: string = "";
  messages: BroadcastMessage[] = [];

  socket: any;

  constructor() {
    this.socket = io();

    this.socket.on("message", (data: BroadcastMessage) => {
      this.messages.push(data);
    });
  }

  sendMessage() {
    if (this.message.trim() !== "") {
      const broadcastMessage = {
        name: "",
        message: this.message,
      };
      this.messages.push(broadcastMessage);
      this.socket.emit("message", broadcastMessage);
      this.message = "";
    }
  }
}
