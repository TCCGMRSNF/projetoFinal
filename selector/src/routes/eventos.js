const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/funcao/:funcao', isLoggedIn, async (req, res) => {
    const { funcao } = req.params;
    const eventos = await pool.query(
        'SELECT * FROM eventos WHERE id IN(SELECT evt_id FROM evento_usuario WHERE usr_id = ? AND funcao = ? ORDER BY ts_ini DESC)'
        , [req.user.id, funcao.toString()]);

    const rota = 'eventos/eventos_list_' + funcao.toString()
    console.log(eventos);
    console.log(funcao);
    res.render(rota, { eventos, funcao });
});



/*=====================================================================*/
router.get('/:funcao/:id', isLoggedIn, async (req, res) => {
    const { id, funcao } = req.params;
    const sId = id.toString();

    const evento = await pool.query(
        'SELECT * FROM eventos WHERE id = ? limit 1', [sId]);

    const quesitos = await pool.query(
        'SELECT * FROM quesitos WHERE id IN(SELECT qst_id FROM evento_quesito WHERE evt_id = ?)'
        , [sId]);

    const avaliadores = await pool.query(
        'SELECT * FROM usuarios WHERE id IN(SELECT usr_id FROM evento_usuario WHERE evt_id = ? and funcao = "1")'
        , [sId]);

    const candidatos = await pool.query(
        'SELECT * FROM usuarios WHERE id IN(SELECT usr_id FROM evento_usuario WHERE evt_id = ? and funcao = "2")'
        , [sId]);



    console.log(evento);
    console.log(sId);
    console.log(quesitos);
    console.log(avaliadores);
    console.log(candidatos);

    res.render('eventos/evento_display', { funcao, evento: evento[0], quesitos, avaliadores, candidatos });



});
/*=====================================================================*/


/*
router.get('/:funcao', isLoggedIn, async (req, res) => {
    const { funcao } = req.params;
    const links = await pool.query('SELECT * FROM links WHERE id = ?', [id]);
    console.log(links[0]);
    res.render('links/edit', {link: links[0]});
});
*/


module.exports = router;
