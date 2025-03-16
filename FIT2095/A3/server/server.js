/**
 * @author Euan Lim 33045984 <elim0062@student.monash.edu> 
 * @author Foo Kai Yan 33085625 <kfoo0012@student.monash.edu>
 * Represents the main server file
 */

const express = require("express");
const mongoose = require("mongoose");
const url = "mongodb://127.0.0.1:27017/event-management-app"
const { Translate } = require("@google-cloud/translate").v2;
const translate = new Translate();

/**
 * App Instance
 */
const app = express();
const port = 5000;
let path = require("path");
app.use(express.json());

// Socket app server
const server = require('http').Server(app);
const io = require("socket.io")(server);
const fs = require("fs"); // text-to-speech

// Imports the Google Cloud client library
const textToSpeech = require("@google-cloud/text-to-speech");
const textToSpeechClient = new textToSpeech.TextToSpeechClient();

/**
 * For the initial operation
 */
const operation = require("./models/operation_schema");
const category = require('./models/category_schema');
const event = require('./models/event_schema');

/**
 * Starting Server
 */
app.use("/", express.static(path.join(__dirname, "../client/dist/client")));
// app.use("/", express.static(path.join(__dirname, "../client/dist/client/audio_files")));
app.use(express.static(path.join(__dirname, "../client/src/assets/audio_files")));
app.use(express.urlencoded({ extended: true }));
server.listen(port, () => {
    console.log(`server has started on port ${port}`);
});

/**
 * Connect to database
 */
async function connect() {
  await mongoose.connect(url);
}

/**
 * API Router   
 */
const api_category = require("./api_routes/category_api")
const api_event = require("./api_routes/event_api")

/**
 * A2 new Middleware functions 
 */
app.use("/api/v1/category/33085625", api_category)
app.use("/api/v1/event/euan", api_event)

// Operation
app.use("/api/operation", async (req, res) => {
    try {
        const ops = await operation.findOne({});
        const categoryCount = await category.countDocuments({});
        const eventCount = await event.countDocuments({});
        
        console.log(ops);
        console.log(categoryCount);
        console.log(eventCount);
        
        res.json({"ops": ops, "categoryCount": categoryCount, "eventCount": eventCount});
        // res.json(categoryCount);
        // res.json(eventCount); 
    } catch (error) {
        console.error(error);
        res.status(400).send("Unavailable");
    }
})

// Specify the file name and path 
const outputDirectory = '/audio_files/output.mp3'
// Combine the directory and file name to create the full file path
const filePath = path.join(__dirname, outputDirectory);
let fileCounter = 0;
let frontEndFilePath = "";

// SOCKET CODE
io.on("connection", socket => {
    console.log("new connection made from client with ID=" + socket.id);

    socket.on("translate", async data => {
        myObj = {
            ...data, 
            translation: await translateMyText(data.text, data.lang)
        }
        console.log(myObj)
        io.sockets.emit("onTranslate",myObj);
    });

    socket.on("onTextSpeech", async (text) => {
        // Construct the request
        const request = {
            input: { text: text },
            // Select the language and SSML Voice Gender
            voice: { languageCode: "en-US", ssmlGender: "NEUTRAL" },
            // Select the type of audio encoding
            audioConfig: { audioEncoding: "MP3" },
        };
        
        // Performs the Text-to-Speech request
        textToSpeechClient.synthesizeSpeech(request, (err, response) => {
            if (err) {
                console.error("ERROR:", err);
                return;
            }
            
            const filename = "output"+fileCounter
            frontEndFilePath = "../client/src/assets/audio_files/output"+ fileCounter +".mp3";

            fs.writeFile(frontEndFilePath, response.audioContent, "binary", err => {
                if (err) {
                    console.error("ERROR:", err);
                    return;
                }
                console.log("Counter: " + fileCounter);
                console.log("Audio content written to file: output"+fileCounter+".mp3");
                io.sockets.emit("speech", `${filename}.mp3`);
                fileCounter++;
            });
        });
    })
});

async function translateMyText(text, target) {
	let translation = await translate.translate(text, target);
    console.log(translation)
    return translation[0]
}

connect(url)
.then(() => {
    //console.log
    return operation.findOne({});
})
// This is for creating the initial Counter entry 
.then((counter) => {
    if (!counter) {
        const initialCounter = new operation({
            addCount: 0,
            updateCount: 0,
            deleteCount: 0
        }); 
    
        return initialCounter.save();
    } 
    else {
        counter.addCount = 0;
        counter.updateCount = 0;
        counter.deleteCount = 0;

        return counter.save();
        }
})
.catch((err) => console.log(err));