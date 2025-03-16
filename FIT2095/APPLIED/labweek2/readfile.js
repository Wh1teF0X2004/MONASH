let fs = require("fs");  // import the fs (File System) library

function readFile(fileName) {
	fs.readFile(fileName, function (error, content) { // lets try reading the file
		if (error) {
			// if an error occurred while reading the file such as file not found
			console.log("Sorry we got an error");
		} else {
			// there is no error
			console.log(content.toString());
		}
	});
}

readFile("./data.txt"); // call the function 