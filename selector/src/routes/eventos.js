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

    var evento = await pool.query(
        'SELECT * FROM eventos WHERE id = ? limit 1', [sId]);

    const avaliadores = await pool.query(
        'SELECT * FROM usuarios WHERE id IN(SELECT usr_id FROM evento_usuario WHERE evt_id = ? and funcao = "1")'
        , [sId]);

    /*
            var candidatos = await pool.query(
                'SELECT * FROM usuarios WHERE id IN(SELECT usr_id FROM evento_usuario WHERE evt_id = ? and funcao = "2")'
                , [sId]);
    */

    var candidatos = await pool.query(
        'SELECT * FROM evento_usuario AS eu, usuarios AS us, notas AS nt WHERE eu.evt_id = ? AND eu.funcao = "2" AND eu.usr_id = us.id AND (nt.cdt_id=eu.usr_id AND nt.evt_id = ? AND nt.avl_id = ?)'
        , [sId, sId, sAvl]);

        const quesitos = await getQuesitos(sId);
    
        candidatos = criaNotas(candidatos, evento[0].qtd_ques);

    const rota = 'eventos/eventos_' + funcao.toString() + '_A';


    console.log(candidatos);
    console.log(quesitos);
    console.log(evento);
    //   console.log('Notas---------------------');
    //   console.log(notas);


    res.render(rota, { funcao, evento: evento[0], quesitos, avaliadores, candidatos });
});

function criaNotas(candidatos, nQues) {
    candidatos.forEach((can) => {
        can.notas = [];
        for (var i = 0; i < nQues; i++) {
            var cVar = 'can.nota' + ('0'+i).slice(-2);
            console.log(cVar);
            can.notas[i] = eval(cVar);
        }
    
    });
    return (candidatos);




}

async function getQuesitos(evtId) {
    const quesitos = await pool.query(
        'SELECT * FROM quesitos AS ques, evento_quesito AS eq WHERE eq.evt_id = ? AND eq.qst_id = ques.id'
        , [evtId]);
    return (quesitos);
}















function preparaGridNotas(candidatos, quesitos, notas) {
    //    var xNotas = [];

    candidatos.forEach((can) => {
        can.notas = [];
        quesitos.forEach((ques) => {
            can.notas.push(-1);
        });
    });

    // Inserir as notas no candidato e quesito correto ----------
    notas.forEach((nt, index) => {

        var i_qst = quesitos.findIndex((ques, index, array) => ques.id === nt.qst_id);
        console.log('Ind Quesito: ', i_qst);

        var i_can = candidatos.findIndex((cand, index, array) => cand.id === nt.cdt_id);
        console.log('Ind Candidato: ', i_can);

        console.log(candidatos[i_can].notas);
        console.log('Nota: ', nt.nota);
        candidatos[i_can].notas[i_qst] = nt.nota;
        //            candidatos[i_can].notas[i_qst] = nt.nota;

    });
    console.log(candidatos);

    // Return da função -------------------
    return (candidatos);
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
// Códigos não utilizados

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

    //    candidatos = preparaGridNotas(candidatos, quesitos, notas);


/*
    const notas = await pool.query(
        'SELECT * FROM notas WHERE evt_id = ? AND avl_id = ?'
        , [sId, sAvl]);
*/





/*
router.get('/:funcao', isLoggedIn, async (req, res) => {
    const { funcao } = req.params;
    const links = await pool.query('SELECT * FROM links WHERE id = ?', [id]);
    console.log(links[0]);
    res.render('links/edit', {link: links[0]});
});
*/


module.exports = router;
