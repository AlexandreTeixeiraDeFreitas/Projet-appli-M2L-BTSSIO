const mariadb = require('mariadb');

const pool = mariadb.createPool({
    connectionLimit: 10,
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'm2l',
    port: '3306',
    
});

module.exports = pool;