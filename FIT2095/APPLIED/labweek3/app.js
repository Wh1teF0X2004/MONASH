const express = require("express");
const path = require("path"); // Simplify directory
const Parcel = require('./models/parcel')

const print = console.log;
const VIEWS_PATH = path.join(__dirname, "/views/"); //Important

const PORT_NUMBER = 8080;

// let app = express();
// app.listen(PORT_NUMBER, function () {
//     print(`listening on port ${PORT_NUMBER}`);
// })

let app = express();
app.use(express.static("node_modules/bootstrap/dist/css"));
app.listen(PORT_NUMBER, function () {
	print(`listening on port ${PORT_NUMBER}`);
});

let newParcel = new Parcel('KiXiao', 'Melbourne');

app.get('/add/:no1/:no2', function (req, res) {// parameter
    fileName = VIEWS_PATH + "index.html";
    let number1 = parseInt(req.params.no1);
    let number2 = parseInt(req.params.no2);
    let result = number1 + number2;
    res.send(String(result));//does not accept number
});

app.get('/sub', function (req, res) {// query string
    let number1 = parseInt(req.query.no1);
    let number2 = parseInt(req.query.no2);
    let result = number1 - number2;
    res.send(result + "");// a different way to convert to strings
});

app.get('/info', function (req, res) {
    fileName = VIEWS_PATH + "info.html";
    res.sendFile(fileName);
});

// app.get("/", function (req, res) {
//     res.send(`<h2> HI </h2>
//     <span> ${name} </span>`)
// })

// Part II

let db = [];

app.get('/', function(req, res){
    res.sendFile(path.join(__dirname, "view", "index.html"));
})

app.get('/lab3', function(req, res){
    res.send(db);
})

app.get('*', function(req, res){
    res.send('404 ... NO SUCH ENDPOINT')
})

app.get('/addparcel', function(req, res){
    let sender = req.query.sender;
    let address = req.query.address;
    let newParcel = new Parcel(sender, address);
    db.push(newParcel);
    res.redirect('./lab3')
})

app.get('/deleteid/:id', function(req, res){
    let id = parseInt(req.params.id);
    for(i= 0 ; i <= db.length-1 ; ++i ){
        if(db[i].id===id){
            db.splice(i, 1);
            break;
        }
    }
    res.redirect('/lab3');
})