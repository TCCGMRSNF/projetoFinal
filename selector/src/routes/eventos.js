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
    const sAvl = req.user.id.toString();

    const evento = await pool.query(
        'SELECT * FROM eventos WHERE id = ? limit 1', [sId]);

    const quesitos = await pool.query(
        'SELECT * FROM quesitos WHERE id IN(SELECT qst_id FROM evento_quesito WHERE evt_id = ?)'
        , [sId]);

    const avaliadores = await pool.query(
        'SELECT * FROM usuarios WHERE id IN(SELECT usr_id FROM evento_usuario WHERE evt_id = ? and funcao = "1")'
        , [sId]);

    var candidatos = await pool.query(
        'SELECT * FROM usuarios WHERE id IN(SELECT usr_id FROM evento_usuario WHERE evt_id = ? and funcao = "2")'
        , [sId]);

    const rota = 'eventos/eventos_' + funcao.toString() + '_A';


/*
    for (i = 0; i < candidatos.length; i++) {
        var sCand = candidatos[i].id.toString();
        var ret = fillArrayNotas(sId, sAvl, sCand, quesitos);  
        console.log(candidatos[i].id, candidatos[i].nome, ret);
        candidatos[i].notas = ret;
//        console.log(candidatos[i]);
    }

*/

//    fillArrayNotas(sId, sAvl, quesitos, candidatos)

    /* 
        console.log(evento);
        console.log(sId);
        console.log(quesitos);
        console.log(avaliadores);
        console.log(req.user);
    */


   const aNotas = await pool.query(
    'SELECT * FROM notas WHERE evt_id = ? AND avl_id = ?'
    , [sId, sAvl]);

    console.log(candidatos);
    console.log('Notas---------------------');
    console.log(aNotas);


    res.render(rota, { funcao, evento: evento[0], quesitos, avaliadores, candidatos });



});

async function arrayNotas(idEvt, idAvl) {

// Return da função -------------------
    return (aNotas);
}









function fillArrayNotas(idEvt, idAvl, idCand, quesitos) {
        var aNotas = [];
        quesitos.map(async (ques, index) => {
            var nt = -1;   //ques.id;
            
            var sqlNota = await pool.query(
                'SELECT * FROM notas WHERE evt_id = ? AND qst_id = ? AND avl_id = ? AND cdt_id = ? limit 1'
                , [idEvt, ques.id.toString(), idAvl, idCand]);

            console.log(idEvt, ques.id.toString(), idAvl, idCand, sqlNota)                


            if (sqlNota.length > 0) {
                nt = sqlNota[0].nota;
            }

            aNotas.push(nt);
        });

    // Return da função -------------------
        return (aNotas);
}




//----------------------------------------------------------------
function xyz(idEvt, idAvl, quesitos, candidatos) {

    candidatos.forEach(async (cand) => {
        var aNotas = [];

        var xNotas = quesitos.forEach(async (ques) => {
            var sqlNota = await pool.query(
                'SELECT * FROM notas WHERE evt_id = ? AND qst_id = ? AND avl_id = ? AND cdt_id = ? limit 1'
                , [idEvt, ques.id.toString(), idAvl, cand.id.toString()]);

            console.log(idEvt, ques.id.toString(), idAvl, cand.id.toString(), sqlNota);

            var vlr = -1;
            if (sqlNota.length > 0) {
                vlr = sqlNota[0].nota;
            }

            aNotas.push(vlr);
            console.log(aNotas);
            return (aNotas);
        });

        cand.notas = xNotas;
        console.log(xNotas);

    });





    return (candidatos);
}



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
