const mongodb = require("mongodb");
const express = require("express");
const app = express();
app.listen(8080);

app.use(express.urlencoded({ extended: true }));

const MongoClient = mongodb.MongoClient;

// const url="http://localhost:8080"
// const url="ftp://localhost:8080"

// const url = "mongodb://89.150.1.66:27017";
const url = "mongodb://127.0.0.1:27017";  // Node 18+
//const url = "mongodb://localhost:27017";
const client = new MongoClient(url);
let db;
let collection;

async function connectDB() {
	await client.connect();
	db = client.db("fit2095");
	collection = db.collection("week5");
	// let result = await collection.insertOne({ name: "Tim", age: 57, address: "Perth" });

	return "Done";
}

app.get("/students", async function (req, res) {
	let filter = {};
	let result = await collection.find(filter).toArray();
	res.send(result);
});

app.post("/students", async function (req, res) {
	let aName = req.body.name;
	let anAge = req.body.age;
	let newStudentObj = {
		name: aName,
		age: anAge,
	};
	let result = await collection.insertOne(newStudentObj);
	res.redirect("/students");
});

app.get("/students/remove", async function (req, res) {
	let aName = req.query.name;
	let filter = {
		name: aName,
	};
	let result = await collection.deleteMany(filter);
	console.log(result);
	res.redirect("/students");
});

connectDB().then(console.log);
