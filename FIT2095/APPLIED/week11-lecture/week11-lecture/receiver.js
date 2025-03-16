var admin = require("firebase-admin");

var serviceAccount = require("./your-service-account-here.json");

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount),
	databaseURL: "https://your-database-url-here",
});

let db = admin.database(); // db is my database
let refFIT2095 = db.ref("/posts/fit2095"); // posts is my table
let refFIT2081 = db.ref("/posts/fit2081"); // posts is my table

refFIT2095.on("child_added", function (snapshot) {
	console.log("FIT2095");
	console.log(snapshot.val());
});
refFIT2081.on("child_added", function (snapshot) {
	console.log("FIT2081");

	console.log(snapshot.val());
});
