// labweek8_assessment

const mongoose = require("mongoose");
const express = require("express");

const weatherRouter = require("./routes/weather_routes");

const app = express();
app.listen(8080);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const url = "mongodb://127.0.0.1:27017/weather-app";

async function connect(url) {
	await mongoose.connect(url);
	return "Connected Successfully";
}

app.use("/weather", weatherRouter);

connect(url)
	.then(console.log)
	.catch((err) => console.log(err));