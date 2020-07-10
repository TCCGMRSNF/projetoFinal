const bcrypt = require('bcryptjs');
const helpers = {};
const faker = require('faker');
const pool = require('../database');

helpers.encryptPassword = async (password) => {
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(password, salt);
    return hash;
};

helpers.matchPassword = async (password, savedPassword) => {
    try {
        return await bcrypt.compare(password, savedPassword);
    } catch (e) {
        console.log(e);
    }
};

helpers.fakeUser = (locale) => {
    faker.locale = locale;
    const fakeUser = {
        nome: faker.name.findName(),
        email: faker.internet.email(),
        senha: '1234567890'
        //        website: faker.internet.url(),
        //        address: faker.address.streetAddress() + faker.address.city() + faker.address.country(),
        //        bio: faker.lorem.sentences(),
        //        image: faker.image.avatar()
    }
    return fakeUser;
}

/*
helpers.isAdm = (adm) => {
    return adm === 'Y';
};
*/

helpers.getQuesitos = async (evtId) => {
    const quesitos = await pool.query(
        'SELECT * FROM quesitos AS ques, evento_quesito AS eq WHERE eq.evt_id = ? AND eq.qst_id = ques.id'
        , [evtId]);
    return (quesitos);
}

helpers.getCandidatos = async (evtId) => {
    const candidatos = await pool.query(
        'SELECT * FROM evento_usuario AS eu WHERE eu.evt_id = ? AND eu.funcao = "2"'
        , [evtId]);
    return (candidatos);
}

helpers.getAvaliadores = async (evtId) => {
    const avaliadores = await pool.query(
        'SELECT * FROM evento_usuario AS eu WHERE eu.evt_id = ? AND eu.funcao = "1"'
        , [evtId]);
    return (avaliadores);
}

helpers.getEvento = async (evtId) => {
    const evento = await pool.query(
        'SELECT * FROM eventos WHERE id = ? limit 1', [evtId]);
    return (evento);
}

helpers.calcularScore = (aMed, nQues, nCasas) => {
    var score = 0;
    var cVar = '';
    var nMed = 0;
    for (var i = 0; i < nQues; i++) {
        cVar = 'aMed.m' + ('0' + i).slice(-2);
        nMed = eval(cVar)
        score += nMed;
    }
    score = score / nQues;
    score = score.toFixed(nCasas);    // Cálculo do Score Final
    return (score);
}

helpers.ajustarMedias = (aMed, nQues, nCasas) => {
    var cVar = '';
    for (var i = 0; i < nQues; i++) {
        cVar = 'aMed[0].m' + ('0' + i).slice(-2);
        eval(cVar + ' = parseFloat(' + cVar + ')');
    }
    return (aMed);
}

helpers.agregarNotas = async (sEvtId, resultados, quesitos, avaliadores) => {
    const aNt = await pool.query('SELECT * FROM notas WHERE evt_id = ? ORDER BY numero, avl_id', [sEvtId]);
    const nQues = quesitos.length;
    const nAvl = avaliadores.length;
    var nIdx = 0;

    resultados.forEach((res) => {
        res.notas = new Array(nQues * nAvl);
        avaliadores.forEach((avl, index1) => {
            quesitos.forEach((ques, index2) => {
                var sCampo = 'aNt[nIdx].nota0' + index2.toString();
                var indice = index2 * nAvl + index1;
                res.notas[indice] = eval(sCampo);
            });
            nIdx++;
        });
    });
    return (resultados);
}

helpers.agregarMedias = async (resultados, quesitos) => {
    resultados.forEach((res) => {
        res.medias = [];
        quesitos.forEach((ques, index) => {
            var cCampo = 'res.media0' + index.toString();
            res.medias[index] = eval(cCampo);
        });
    });
    return (resultados);
}



module.exports = helpers;