const express = require("express");
let router = express.Router();
const app = express();
const path = require("path");
let Animal = require("../models/Animal");

global.__basedir = __dirname;
app.listen(8080);

// app.use("/", router);