const mysql = require('mysql');
const express = require('express')
const app = express()

///////////////////////////////////////
///////////////////////////////////////

const connInfo = {
    host: "localhost",
    user: "root",
    password: "",
    database: "chinook",
};

const PORT = 5000;

///////////////////////////////////////
///////////////////////////////////////

app.get('/', function (req, res) {
    var conn = mysql.createConnection(connInfo);
    
    conn.connect(function(err) {
        if (err) {
            res.status(500).json({"msg":err.sqlMessage})
        } else {
            
            var sql = "SELECT art.Name AS art_name, alb.Title AS alb_title FROM album alb INNER JOIN artist art ON alb.ArtistId=art.ArtistId ORDER BY art_name ASC, alb_title ASC";
            var params = [];
            if ("artist_name" in req.query) {
                sql = "SELECT art.Name AS art_name, alb.Title AS alb_title FROM artist art INNER JOIN album alb ON art.ArtistId=alb.ArtistId WHERE art.Name LIKE ? ORDER BY art_name ASC, alb_title ASC";
                params.push(req.query["artist_name"]);
            }
            
            conn.query(sql, params, function(err, result, fields) {
                if (err) {
                    res.status(500).json({"msg":err.sqlMessage})
                } else {
                    // for local testing only
                    res.header("Access-Control-Allow-Origin", "*");
                    
                    res.json(result.map(function(currentValue, index, arr) {
                        return {"artist":currentValue["art_name"], "album":currentValue["alb_title"]};
                    }))
                }
            });
            
            conn.end()
        }
    });
});

app.use(function (req, res, next) {
    res.status(404).json({"msg":"Route not found"})
});

app.listen(PORT, function () {
    console.log('Listening on port %s', PORT)
});
