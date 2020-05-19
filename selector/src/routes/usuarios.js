const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

// Criado por SNF
router.get('/', async (req, res) => {
    const usuarios = await pool.query('SELECT * FROM usuarios');
    //console.log(links);
    bread = '1';
    res.render('usuarios/list_grid', { usuarios, bread } );
});

module.exports = router;
