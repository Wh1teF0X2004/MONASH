const mongoose = require("mongoose");
const Car = require("./models/car");
const Fleet = require("./models/fleet");
const express = require("express");
const app = express();
app.listen(8080);

const url = "mongodb://localhost:27017/week6db";

app.use(express.json());

async function connect() {
	await mongoose.connect(url);
}
connect()
	.catch((err) => console.log(err))
	.then(processData);

let fleet;
async function processData() {
	console.log("Start processing data");
	fleet = await Fleet.findOne({ name: "fleet3" });
	// fleet = new Fleet({ name: "fleet3" });
	// let obj = await fleet.save();
	console.log(fleet);
}

app.post("/add-car", async (req, res) => {
	let obj = req.body;
	try {
		let aCar = new Car({ maker: obj.maker, model: obj.model, year: parseInt(obj.year) });
		await aCar.save();
		fleet.cars.push(aCar._id);
		await fleet.save();
	} catch (err) {
		// console.log(err);
	}
	console.log("The fleet is");
	res.redirect("fleet");
});

app.get("/cars", async (req, res) => {
	let cars = await Car.find({});
	res.json(cars);
});

app.get("/fleet", async (req, res) => {
	let fleet = await Fleet.find({}).populate("cars");
	res.json(fleet);
});

app.delete("/cars", async (req, res) => {
	let id = req.body.model;
	let aCar = await Car.findOne({ model: id });
	console.log(aCar._id);
	let index = fleet.cars.indexOf(aCar._id);
	console.log("index=" + index);
	fleet.cars.splice(index, 1);
	await Car.findOneAndDelete({ model: id });
	await fleet.save();
	res.redirect("/fleet");
});
