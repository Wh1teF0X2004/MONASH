const express = require("express");
const app = express();
const morgan = require("morgan");
const randString = require("randomstring");
const path = require("path");
const Product = require("./models/product");
const ejs = require("ejs");

// app.set("portNumber", 8081);
// global.serverName='FIT2095';

// app.listen(app.get("portNumber"), function () {
// 	console.log(`listening on ${app.get("portNumber")}`);
// });

app.use(express.static("images"));

app.use(express.urlencoded({ extended: true }));

app.engine("html", ejs.renderFile);
app.set("view engine", "html");

let db = [];
app.listen(8080);

app.get("/", function (req, res) {
	res.render("index", { unitCode: "FIT2099", no: db.length });
	// res.sendFile(path.join(__dirname, "views", "index.html"));
});

app.use(function (req, res, next) {
	req.unitCode = "FIT2095";
	req.requestId = Math.round(Math.random() * 1000);
	req.reqToken = randString.generate({
		length: 7,
		charset: "ABCDEF",
	});
	next();
});

app.use(morgan("short"));
app.get("/", function (req, res) {
	res.send(`The unit code is ${req.unitCode} and your ID is ${req.requestId} and your token is ${req.reqToken}`);
});

app.post("/products", function (req, res) {
	let reqBody = req.body;
	console.log(reqBody);
	let aProduct = new Product(reqBody.productName, reqBody.productCost, reqBody.productQuantity);
	db.push(aProduct);
	res.redirect("/products");
});

app.get("/products", function (req, res) {
	res.render("list-products", { products: db });
});

app.get("/addproduct", function (req, res) {
	res.sendFile(path.join(__dirname, "views", "newproduct.html"));
});

app.get("/delete-products", function (req, res) {
	res.sendFile(path.join(__dirname, "views", "delete-product.html"));
});

app.post("/delete-products", function (req, res) {
	let id = parseInt(req.body.id);
	for (let i = 0; i < db.length; i++) {
		if (db[i].id === id) {
			db.splice(i, 1);
			break;
		}
	}
	res.redirect("/products");
});

/**
 * URL Parameters
 * http://localhost:8080/products/123
 * app.get('/products/:id', function (req, res) {
 *    let id=req.params.id;
 * })
 */

/**
 * URL Query String
 * http://localhost:8080/products?id=123
 * app.get('/products', function (req, res) {
 *    let id=req.query.id;
 * })
 */

/**
 * Request Body
 * http://localhost:8080/products
 * app.post('/products', function (req, res) {
 *    let id=req.body.id;
 * })
 */
