const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/funcao/:funcao', isLoggedIn, async (req, res) => {
    const { funcao } = req.params;
    const eventos = await pool.query(
        'SELECT * FROM eventos WHERE id IN(SELECT evt_id FROM evento_usuario WHERE usr_id = ? AND funcao = ? ORDER BY ts_ini DESC)'
        , [req.user.id, funcao.toString()]);
    console.log(eventos);
    res.render('eventos/eventos_list', { eventos, funcao});
});

router.get('/:id/:funcao', isLoggedIn, async (req, res) => {
    const { id, funcao } = req.params;
//    const { id, funcao } = req.params;
    const eventos = await pool.query(
        'SELECT * FROM eventos WHERE id = ?', [id.toString()]);
    console.log(eventos);
    const menu = [false,false,false];
    menu[funcao] = true;
    snf[1] = false;
    console.log(snf);

    res.render('eventos/eventos_display', { eventos, menu0: menu[0], menu1: menu[1], menu2: menu[2], menu: true});
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
