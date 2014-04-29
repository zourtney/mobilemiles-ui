// var http = require("http");

// http.createServer(function(request, response) {
//   response.writeHead(200, {"Content-Type": "text/plain"});
//   response.write("Hello World");
//   response.end();

//   console.log("I am working");
// }).listen(process.env.PORT || 8888);

var express = require('express');
var app = express();

app.use(express.static(__dirname + '/dist'));

app.listen(process.env.PORT || 3000);