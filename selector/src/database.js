const mysql = require('mysql');
const { promisify } = require('util');
const { database } = require('./keys');


mysql.createPool(database);

const pool = mysql.createPool(database);

pool.getConnection((err, connection) => {
    // Manipulação de erros de conexão
    /*
    if(err) throw err;
    else {
        console.log(rows);
    }
*/
    if (err) {
        console.error('Erro na conexão do banco de dados!');

        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('>> Erro: Sem conexão com o banco de dados!');
        }
        if (err.code === 'ER_CON_COUNT_ERROR') {
            console.error('>> Erro: Excesso de conexões com o banco de dados!');
        }
        if (err.code === 'ECONNREFUSED') {
            console.error('>> Erro: Conexão com o banco de dados foi recusada!');
        }
    }

    // Conexão Ok
    if (connection) {
        connection.release();
        console.log('Banco de dados está conectado!');
    }
    return;
    });

// Promisify Pool Querys
pool.query = promisify(pool.query);

module.exports = pool;
