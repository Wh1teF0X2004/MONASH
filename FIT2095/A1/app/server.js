// For Importing dependencies 
const express = require("express");

// For initialising express app
const app = express();
const port = 5000;

// Middleware
app.use(express.static("node_modules/bootstrap/dist/css"));
app.use(express.static("public/styles"));
app.use(express.static("public/images"));
// EJS
app.engine("html", require("ejs").renderFile);
app.set("view engine", "html");
// Parsing request
app.use(express.urlencoded({ extended: true }));

// Starting Server
app.listen(port, () => {
    console.log(`server has started on port ${port}`);
});

// Routes 
const viewsRoutes = require("./controllers/views")
const categoryRoutes = require("./controllers/category")
const eventRoutes = require("./controllers/event")

// Attaching to app
app.use("/", viewsRoutes)
app.use("/33085625/category", categoryRoutes)
app.use("/euan/event/", eventRoutes)
