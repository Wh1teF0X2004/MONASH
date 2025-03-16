let express = require("express");
let ejs = require("ejs");
const mongodb = require("mongodb");
let path = require("path");

let app = express();
const PORT_NUMBER = 8081;

app.listen(PORT_NUMBER, () => {
  console.log(`Listening on port ${PORT_NUMBER}`);
});

app.use(express.urlencoded({ extended: true }));
app.use(express.static("public/imgs"));
app.use(express.static("public/css"));

// Configure Express for EJS
app.engine("html", require("ejs").renderFile);
app.set("view engine", "html");

//Configure MongoDB
const MongoClient = mongodb.MongoClient;
// Connection URL
const url = "mongodb://localhost:27017/";

let db;
//Connect to mongoDB server
MongoClient.connect(url, { useNewUrlParser: true }, function (err, client) {
  if (err) {
    console.log("Err  ", err);
  } else {
    console.log("Connected successfully to server");
    db = client.db("fit2095parcels");
  }
});

app.get("/", function (req, res) {
  res.sendFile(path.join(__dirname, "views/index.html"));
});

// Task 1
app.get("/addparcel", function (req, res) {
  res.sendFile(path.join(__dirname, "views/newparcel.html"));
});

app.post("/newparcel", function (req, res) {
  let parcel = req.body;
  if (
    parcel.sender.length < 3 ||
    parcel.address.length < 3 ||
    parseFloat(parcel.weight) < 0
  ) {
    res.sendFile(path.join(__dirname, "views/invaliddata.html"));
  } else {
    db.collection("parcels").insertOne(parcel);
    res.redirect("/");
  }
});

app.get("/getparcels", function (req, res) {
  db.collection("parcels")
    .find({})
    .toArray(function (err, data) {
      res.render("listparcels", { parcels: data });
    });
});

app.get("/delparcel", function (req, res) {
  res.sendFile(path.join(__dirname, "views", "delbyid.html"));
});

app.post("/deleteparcel", function (req, res) {
  let id = req.body.id;
  db.collection("parcels").deleteOne({ _id: mongodb.ObjectId(id) });
  res.redirect("/getparcels");
});

app.get("/udpateparcel", function (req, res) {
  res.sendFile(path.join(__dirname, "views", "updateparcel.html"));
});

app.post("/updateparcel", function (req, res) {
  let parcel = req.body;
  db.collection("parcels").updateOne(
    { _id: mongodb.ObjectId(parcel.id) },
    {
      $set: {
        sender: parcel.sender,
        address: parcel.address,
        weight: parcel.weight,
        fragile: parcel.fragile,
      },
    }
  );
  res.redirect("/getparcels");
});

//Task 4
app.get("/gettotalweight", function (req, res) {
  res.send(getWeight());
});

app.get("*", function (req, res) {
  res.sendFile(path.join(__dirname, "views/404.html"));
});

function getWeight() {
  let totalWeight = 0;
  for (let i = 0; i < db.length; i++) {
    totalWeight += db[i].weight;
  }
  return `The total weight is ${totalWeight}`;
}
