const express = require("express");
const app = express();
const path = require("path");
const Car = require("./models/car");
const router = require("./controllers/cars");

global.__basedir = __dirname;
app.listen(8080);

app.use("/", router);

/** URL Parameters
 * http://localhost:8080/add/BMW/X7/2023
 */

/** Query String
 * http://localhost:8080/add?maker=BMW&model=X7&year=2023
 */

/** HTTP verbs/ HTTP methods
 * GET: get data from backend
 * POST: send data to backend
 * PUT: to send data to update existing data
 * DELETE: delete data from backend
 */
