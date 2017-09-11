var express= require('express');
var app = express();
var path = require('path');
var routes = require('./api/routes');

app.set('port', 4200);


//app.set('view engine', 'pug');
app.set('views', path.join(__dirname, 'public'));

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
    next();
});

app.set('views', path.join(__dirname, 'views'));

app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);

app.use(function(req, res, next){
    console.log(req.method, req.url);
    next();
});

app.use(express.static(path.join(__dirname, 'public')));
app.use('/', routes);

var server = app.listen(app.get('port'), function(){
    var port = server.address().port;
    console.log("Listening to Port " + port);
});

