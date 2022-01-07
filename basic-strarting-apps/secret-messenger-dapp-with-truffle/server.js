const express = require('express');
const path = require('path');

const app = express();
const port = process.env.PORT || 3000;


app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res){
  res.sendFile(__dirname + '/public/index.html');
});
app.use('/build/contracts', express.static('build/contracts'))

app.listen(port);
console.log('Server started at http://localhost:' + port);
