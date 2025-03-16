let express = require("express");
let router = express.Router();
let path = require("path");
const app = express();
const ejs = require("ejs");
let Animal = require("./models/animals");
const VIEWS_PATH = path.join(__dirname, "/views/"); //Important
const PORT_NUMBER = 8080;

let db = [];
app.listen(8080);

// Home page
app.get("/", function (req, res) {
	res.sendFile(path.join(__dirname, "views", "index.html"));
});

// Add Animal
app.get("/animals/add", function (req, res) {
	let animalName = req.query.name;
    let quantity = req.query.no;

    const allNumbers = '0123456789';
    randomNumbers = allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)];

    let newAnimal = new Animal(randomNumbers, animalName, quantity);
    db.push(newAnimal);
    res.send(db);
    // res.redirect("/animals");
});



// List Animals
app.get("/animals", function (req, res) {
	res.send(db);
});