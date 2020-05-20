const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/:funcao', isLoggedIn, async (req, res) => {
    const { funcao } = req.params;
    sFuncao = funcao.toString();
    console.log('H'+funcao+'H');
    const eventos = await pool.query(
        'SELECT * FROM eventos WHERE id IN(SELECT evt_id FROM evento_usuario WHERE usr_id = ? AND funcao = ?)'
        , [req.user.id, sFuncao]);
    console.log(eventos);
    res.render('eventos/eventos_list', { eventos });
});

/*
router.get('/:funcao', isLoggedIn, async (req, res) => {
    const { funcao } = req.params;
    const links = await pool.query('SELECT * FROM links WHERE id = ?', [id]);
    console.log(links[0]);
    res.render('links/edit', {link: links[0]});
});
*/


module.exports = router;
