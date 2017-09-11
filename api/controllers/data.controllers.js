var pg = require('pg');
var config = {
    user:"daltix",
    database:"hive_db",
    password:"postgres",
    host:"localhost",
    port:"5432",
    max:10,
    idleTimeoutMillis:30000
};
var pool = new pg.Pool(config);

module.exports.getTableRemarkable = function(req,res){
    console.log("get the remarkable");
    pool.connect(function(err, client, done){
        if(err){
            return console.error('error fetching client from pool', err);
        }
        client.query("select * from remarkable_normalization_results", function(err,result){
            done();
            if(err){
                return console.error('error running query', err);
            }
            var queryResult = [];
            for (i=0; i<20; i++) {
                thisRow = result.rows[i];
                queryResult.push(thisRow);
            }
            res
                .status(200)
                //.render('remarkable', {value: JSON.stringify(queryResult)});
                .render('viewtest1.html');

            console.log("done");
        });
    });
};

module.exports.getTableMetrics = function(req,res){
    console.log("get the metrics");
    pool.connect(function(err, client, done){
        if(err){
            return console.error('error fetching client from pool', err);
        }
        client.query("select * from metrics", function(err,result){
            done();
            if(err){
                return console.error('error running query', err);
            }
            var queryResult = [];

            for (i=0; i<20; i++) {
                thisRow = result.rows[i];
                queryResult.push(thisRow);
            }
            res
                .status(200)
                .render('metrics', {value: JSON.stringify(queryResult)});

            console.log("done");
        });
    });
};