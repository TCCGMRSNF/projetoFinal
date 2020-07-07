const express = require('express');
const router = express.Router();
const helpers = require('../lib/helpers');

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

// Gravar nota do candidato para evento+quesito selecionado.
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

// Gerador de grid de notas zeradas. 
// Não gera nota se já possui nota lançada.
router.get('/grid/:evtId', isLoggedIn, async (req, res) => {
    const { evtId } = req.params;
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
                    numero: can.numero,
                    nota00: 0, nota01: 0, nota02: 0, nota03: 0, nota04: 0,
                    nota05: 0, nota06: 0, nota07: 0, nota08: 0, nota09: 0
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

// Cálculo de médias e escores
router.get('/scores/:evtId', isLoggedIn, async (req, res) => {
    const { evtId } = req.params;
    const sEvtId = evtId.toString();
    const quesitos = await helpers.getQuesitos(evtId);
    const candidatos = await helpers.getCandidatos(evtId);
    const evento = await helpers.getEvento(sEvtId);
    const nQuesitos = evento[0].qtd_ques;
    const nCasasMedia = evento[0].nota_decimais;
    const nCasasScore = evento[0].score_decimais;

    candidatos.forEach(async (can) => {
        var sCanId = can.usr_id.toString();
        var medias = await pool.query(
            'SELECT AVG(nota00) AS m00, AVG(nota01) AS m01, AVG(nota02) AS m02, \
                    AVG(nota03) AS m03, AVG(nota04) AS m04, AVG(nota05) AS m05, \
                    AVG(nota06) AS m06, AVG(nota07) AS m07, AVG(nota08) AS m08, \
                    AVG(nota09) AS m09 \
            FROM notas \
            WHERE evt_id = ? AND cdt_id = ?'
            , [sEvtId, sCanId]);

        medias = helpers.ajustarMedias(medias, nQuesitos, nCasasMedia);

        var aScore = {
            evt_id: evtId,
            cdt_id: can.usr_id,
            numero: can.numero,
            score: helpers.calcularScore(medias[0], nQuesitos, nCasasScore),
            media00: medias[0].m00, media01: medias[0].m01, media02: medias[0].m02,
            media03: medias[0].m03, media04: medias[0].m04, media05: medias[0].m05,
            media06: medias[0].m06, media07: medias[0].m07, media08: medias[0].m08,
            media09: medias[0].m09
        };

        // Verifica se existe registro de score para o candidato
        var rows = await pool.query(
            'SELECT evt_id FROM resultados \
            WHERE evt_id = ? AND cdt_id = ?'
            , [sEvtId, sCanId]);

        // Se o registro mão existe, é criado. Se existir, é atualizado.
        if (rows.length === 0) {
            await pool.query(
                'INSERT INTO resultados SET ?', [aScore]);
        } else {
            await pool.query(
                'UPDATE resultados SET ? \
                WHERE evt_id = ? AND cdt_id = ?', [aScore, sEvtId, sCanId]);
        };
    });

    backURL = req.header('Referer') || '/';
    res.redirect(backURL);
    //res.status(200);
});


//================================================
// Retorna Grid de Scores e Notas
router.get('/resultados/:evtId', isLoggedIn, async (req, res) => {
    const { evtId } = req.params;
    const sEvtId = evtId.toString();
    const quesitos = await helpers.getQuesitos(evtId);
    const evento = await helpers.getEvento(sEvtId);
    const avaliadores = await helpers.getAvaliadores(sEvtId);
    //const nQuesitos = evento[0].qtd_ques;


    var resultados = await pool.query(
        'SELECT evt_id, cdt_id, numero, score, nome, media00, media01, media02, \
                media03,  media04,  media05,  media06, media07, media09 \
        FROM resultados, usuarios \
        WHERE evt_id = ? AND resultados.cdt_id = usuarios.id \
        ORDER BY numero'
        , [sEvtId]);


    resultados = await helpers.agregarNotas1(sEvtId, resultados, quesitos, avaliadores);

    const rota = 'eventos/eventos_0_A';
    res.render(rota, { evento: evento[0], quesitos, avaliadores, resultados });
});






module.exports = router;
