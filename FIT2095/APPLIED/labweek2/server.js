/*
var http = require("http"); 
var fs = require("fs"); // file system lib to read a file

http.createServer(function (req, res) {
		fs.readFile("./views/index.html", function (error, content) {
			if (error) {
				// if an error (not null) occurred while reading the file such as file not found
				console.log("Sorry we got an error");
			} else {
				// there is no error
				res.end(content); // send the content of the file (either index or info) to the client
			}
		});
	}).listen(8080); // this is the port number
*/

var http = require("http");
var fs = require("fs");

http.createServer(function (req, res) {
		const url = new URL(req.url, `http://${req.headers.host}`);
		switch (url.pathname) {
			case "/": //if a request like http://localhost:8080 arrives (no pathname)
				fileName = "./views/index.html";
				break;
			case "/info": //if a request like http://localhost:8080/info arrives
				fileName = "./views/info.html";
				break;
			case "/add": // if a request like http://localhost:8080/add?x=3&y=8 arrives
				q = url.searchParams; // get the list of parameters in the query string (i.e. x & y)
				x = parseInt(q.get("x")); // get the value of x
				y = parseInt(q.get("y")); // get the value of y
				result = x + y; // do the arithmetic operation
				msg = `The result of ${x} + ${y} is ${result}`; // build the response using JS template
				res.end(msg); // send it back to the client
				return; // end this callback
				break;
			case "/sub": // if a request like http://localhost:8080/sub?x=13&y=5 arrives
				q = url.searchParams;
				x = parseInt(q.get("x"));
				y = parseInt(q.get("y"));
				result = x - y;
				msg = `The result of ${x} - ${y} is ${result}`;
				res.end(msg);
				return;
				break;
			default:
				return; // if a request with unknown pathname arrives, simply ignore it.
		}
		fs.readFile(fileName, function (error, content) {
			if (error) {
				// if an error (not null) occurred while reading the file such as file not found
				console.log("Sorry we got an error");
			} else {
				// there is no error
				res.end(content); // send the content of the file (either index or info) to the client
			}
		});
	}).listen(8080); // this is the port
