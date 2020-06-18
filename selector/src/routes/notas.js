const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.post('/:evtId/:quesId/:canId', isLoggedIn, async (req, res) => {
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

module.exports = router;
