const express = require('express');
const router = express.Router();
const helpers = require('../lib/helpers');

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.post('/gravar/:evtId/:quesId/:canId', isLoggedIn, async (req, res) => {
    const { evtId, quesId, canId } = req.params;
    const nCanNota = req.body.inputNota;
    const sAvlId = req.user.id.toString();
    const sEvtId = evtId.toString();
    const sCanId = canId.toString();
    const cNota = 'nota' + ('0' + quesId).slice(-2);

    var evento = await pool.query(
        'UPDATE notas SET ' + cNota + ' = ? WHERE evt_id = ? AND avl_id = ? AND cdt_id = ?', [nCanNota, sEvtId, sAvlId, sCanId]);

    backURL = req.header('Referer') || '/';
    res.redirect(backURL);
    //res.status(200);
});

router.get('/grid/:evtId', isLoggedIn, async (req, res) => {
    const { evtId } = req.params;
    //    const sAvlId = req.user.id.toString();
    const sEvtId = evtId.toString();
    const quesitos = await helpers.getQuesitos(evtId);
    const candidatos = await helpers.getCandidatos(evtId);
    const avaliadores = await helpers.getAvaliadores(evtId);

    candidatos.forEach((can) => {
        var sCanId = can.usr_id.toString();
        avaliadores.forEach(async (aval) => {
            var sAvlId = aval.usr_id.toString();
            var rows = await pool.query(
                'SELECT * FROM notas WHERE evt_id = ? AND avl_id = ? AND cdt_id = ?'
                , [sEvtId, sAvlId, sCanId]);

            if (rows.length === 0) {
                var aNota = {
                    evt_id: evtId,
                    avl_id: aval.usr_id,
                    cdt_id: can.usr_id,
                    nota00: 0, nota01: 0, nota02:0, nota03: 0, nota04: 0,
                    nota05: 0, nota06: 0, nota07:0, nota08: 0, nota09: 0
                };
                await pool.query(
                   'INSERT INTO notas SET ?', [aNota]);
            };
        });
    });
    backURL = req.header('Referer') || '/';
    res.redirect(backURL);
    //res.status(200);
});



module.exports = router;
