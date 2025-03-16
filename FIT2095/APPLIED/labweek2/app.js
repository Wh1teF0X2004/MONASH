let http = require('http');

http.createServer(function (request, response) {
    console.log('request ', request.url);
    response.writeHead(200); // its OK
    response.write('Lab Week 2');
    response.end();
}).listen(8080); // this is the port number
console.log('Server running at http://localhost:8080/');