const mongoose = require("mongoose");
const express = require("express");

const medicineRouter = require("./routes/medicine-routes");
const prescriptionRouter = require("./routes/prescription-routes");

const app = express();
app.listen(8080);

app.use(express.json());

const url = "mongodb://127.0.0.1:27017/chemist-app";

async function connect(url) {
	await mongoose.connect(url);
	return "Connected Successfully";
}

app.use("/med", medicineRouter);
app.use("/pres", prescriptionRouter);

connect(url)
	.then(console.log)
	.catch((err) => console.log(err));