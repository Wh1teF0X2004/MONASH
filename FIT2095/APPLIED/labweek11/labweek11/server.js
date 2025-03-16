const express = require("express");
const http = require("http");
const socketIo = require("socket.io");
const { Translate } = require("@google-cloud/translate").v2; 

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

const PORT = process.env.PORT || 8080;

// Initialize Google Translate
const translate = new Translate();

app.use(express.static(__dirname + "/public"));

io.on("connection", (socket) => {
  console.log("A user connected");

  socket.on("message", async (data) => {
    try {
      const translation = await translateText(data.message, "en"); 
      const translatedMessage = {
        name: data.name,
        message: translation,
      };
      io.emit("message", translatedMessage);
    } catch (err) {
      console.error("Translation error:", err);
    }
  });

  socket.on("disconnect", () => {
    console.log("User disconnected");
  });
});

async function translateMyText(text, targetLanguage) {
  const [translation] = await translate.translate(text, targetLanguage);
  return translation;
}

async function translateText(text, target) {
	let translation = await translate.translate(text, target);
	console.log(translation);
}

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
