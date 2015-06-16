var mysql = require('mysql');

// update with your mysql username/password below
var pool  = mysql.createPool({
  connectionLimit : 5,
  host            : '192.168.1.32',
  dbname		: 'base_de_datos',// 'prueba'
  user            : 'usuario',//'esp8266'
  password        : 'contrasenna'//pwd
});

var db = {};

db.onLoad = function(){
	// check for database and table
	// create if doesnt exist
	// create code
//CREATE DATABASE prueba;
//USE prueba
/*CREATE TABLE `dump` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	`location` VARCHAR(20) NOT NULL COLLATE 'utf8_bin',
	`temp` DECIMAL(4,2) NOT NULL,
	`hostname` VARCHAR(20) NOT NULL COLLATE 'utf8_spanish2_ci',
	PRIMARY KEY (`id`),
	INDEX `location` (`location`),
	INDEX `date` (`date`)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=4235;
*/
}

// this will create a pool connection or use an empty pool connection, run the query and run the callback function with returned rows from mysql
db.q = function(query,cb){
	pool.getConnection(function(err, connection) {
		if (!err) {
			connection.query(query, function(err, rows) {
				if (!err) { 
					if (typeof cb !== "undefined") { 
						cb(rows); 
					}
					connection.destroy(); // change to connection.release() if you have lots of sensors like 100
				} 
				else { console.log('MySQL:>>query error'); }
			})
		} else { console.log('MySQL:>>pool failed to get connection'); }
	});
}

module.exports = db;
