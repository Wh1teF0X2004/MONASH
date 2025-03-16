let express = require("express");
let router = express.Router();
let path = require("path");
let Car = require("../models/Car");

let db = [];
pathRoot = "/Users/nawfal/Monash/FIT2095-S1-2023/FIT2095-Lectures/week3/";
router.get("/", function (req, res) {
	res.sendFile(path.join(process.cwd(), "views", "index.html"));
});
``;
router.get("/cars", function (req, res) {
	res.send(db);
});

router.get("/add/:maker/:model/:year", function (req, res) {
	let maker = req.params.maker;
	let model = req.params.model;
	let year = parseInt(req.params.year);

	let aCar = new Car(maker, model, year);
	db.push(aCar);
	res.redirect("/cars");
});

router.get("/about", function (req, res) {
	res.sendFile(path.join(process.cwd(), "views", "about.html"));
});

//export this router
module.exports = router;
