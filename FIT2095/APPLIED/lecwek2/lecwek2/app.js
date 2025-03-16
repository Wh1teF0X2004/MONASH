function f1(){
	console.log("f1");
}

function f2(){
	console.log("f2");
}

setTimeout(f1, 10);
f2();
// Asynchronous because Node.js will not wait and proceed to run the next line of code 
// f1() before f2() will result in output is f1 f2
// setTimeout will result in output f2 f1 

const http = require("http");
const fs = require("fs");

http
	.createServer(function (request, response) {
		let fileName = "";
		console.log("We got a request from" + request.url);

		switch (request.url) {
			case "/":
				fileName = "./views/index.html";
				break;
			case "/schedule":
				fileName = "./views/schedule.html";
				break;
			case "/students":
				fileName = "./views/students.html";
				break;
		}
		if (fileName !== "") {
			fs.readFile(fileName, function (err, data) {
				response.write(data);
				response.end();
			});
		}
	})
	.listen(5963);

/**
 * http://localhost:5963
 * index.html
 */

/**
 * http://localhost:5963/students
 * students.html
 */

/**
 * http://localhost:5963/schedule
 * schedule.html
 */

// http://localhost:5963/students
// http://localhost:5963/students/enrol
// http://localhost:5963/students/del
// http://localhost:5963/students/units
