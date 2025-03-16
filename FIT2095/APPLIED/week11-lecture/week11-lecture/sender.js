var admin = require("firebase-admin");

var serviceAccount = require("./your-service-account-here.json");

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount),
	databaseURL: "https://your-database-url-here",
});

let db = admin.database(); // db is my database
// let ref = db.ref("/posts/fit2095"); // posts is my table
let ref = db.ref("/posts/fit2081"); // posts is my table

ref.push().set({
	id: Math.floor(Math.random() + 1000),
	name: "678",
	age: 11,
	address: "New York",
});
