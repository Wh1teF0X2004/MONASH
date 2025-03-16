let express = require("express");
let path = require("path");
const app = express();
const ejs = require("ejs");
let Patients = require("./models/patients");
const VIEWS_PATH = path.join(__dirname, "/views/"); //Important
const PORT_NUMBER = 8080;

let db = [];
app.use(express.json());

app.use(express.urlencoded({ extended: true }));
app.engine("html", ejs.renderFile);
app.set("view engine", "html");

app.listen(8080);

// Home page
app.get("/", function (req, res) {
	res.sendFile(path.join(__dirname, "views", "index.html"));
});

// Add 
app.get("/add-patients", function (req, res) {
	res.sendFile(path.join(__dirname, "views", "add-patients.html"));
});

app.post("/add-patients", function (req, res) {
	let patientName = req.body.patientName;
    let medicineName = req.body.medicineName;
    let dose = req.body.dose;

    const allNumbers = '0123456789';
    randomID = allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)] + allNumbers[Math.floor(Math.random() * allNumbers.length)]

    let newPatients = new Patients(randomID, patientName, medicineName, dose);
    db.push(newPatients);
    res.redirect("/patients");
});


// List 
app.get("/list-patients", function (req, res) {
    res.sendFile(path.join(VIEWS_PATH, "list-client.html"));
    res.redirect("/patients");
});

app.get("/patients", function (req, res) {
	res.render("list-patients", { db : db });
});




