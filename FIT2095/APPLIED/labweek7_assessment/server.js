const mongoose = require("mongoose");
const express = require("express");

const cartRouter = require("./routes/cart-routes");
const itemRouter = require("./routes/item-routes");

const app = express();
app.listen(8080);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const url = "mongodb://127.0.0.1:27017/item-cart-app";

async function connect(url) {
	await mongoose.connect(url);
	return "Connected Successfully";
}

app.use("/cart", cartRouter);
app.use("/item", itemRouter);

connect(url)
	.then(console.log)
	.catch((err) => console.log(err));