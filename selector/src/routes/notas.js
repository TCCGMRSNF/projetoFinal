const express = require('express');
const router = express.Router();
const helpers = require('../lib/helpers');

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.post('/gravar/:evtId/:quesId/:canId', isLoggedIn, async (req, res) => {
    const { evtId, quesId, canId} = req.params;
    const nCanNota = req.body.inputNota;
    const sAvlId = req.user.id.toString();
    const sEvtId = evtId.toString();
    const sCanId = canId.toString();
    const cNota = 'nota' + ('0'+quesId).slice(-2);

    var evento = await pool.query(
        'UPDATE notas SET ' + cNota + ' = ? WHERE evt_id = ? AND avl_id = ? AND cdt_id = ?', [nCanNota, sEvtId, sAvlId, sCanId]);

    backURL=req.header('Referer') || '/';
    res.redirect(backURL);
    //res.status(200);
});

router.get('/grid/:evtId', isLoggedIn, async (req, res) => {
    const { evtId } = req.params;
    const sAvlId = req.user.id.toString();
    const sEvtId = evtId.toString();

    const quesitos = await helpers.getQuesitos(evtId);
    const candidatos = await helpers.getCandidatos(evtId);
    
    console.log(quesitos, candidatos, '=============================');





    backURL=req.header('Referer') || '/';
    res.redirect(backURL);
    //res.status(200);
});

/*
async function getQuesitos(evtId) {
    const quesitos = await pool.query(
        'SELECT * FROM quesitos AS ques, evento_quesito AS eq WHERE eq.evt_id = ? AND eq.qst_id = ques.id'
        , [evtId]);
    return (quesitos);
}
*/








module.exports = router;
