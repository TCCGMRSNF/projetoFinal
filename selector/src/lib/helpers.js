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

helpers.agregarNotas = (sEvtId, resultados, quesitos, avaliadores) => {
    resultados.forEach((res) => {
        // var aNotas = [11,12,13,14,15,21,22,23,24,25,31,32,33,34,35];
        var aNotas = [];
        var sCanId = res.cdt_id.toString();
        quesitos.forEach((ques, index, arr) => {
            var sCampo = 'nota0' + index.toString();
            avaliadores.forEach(async (avl) => {
                var sAvlId = avl.usr_id.toString();

                /*                
                                var nNota = await pool.query(
                                    'SELECT ' + sCampo + ' AS nota FROM notas \
                                    WHERE evt_id = ? AND cdt_id = ? AND avl_id = ?', [sEvtId, sCanId, sAvlId]);
                
                                aNotas.push(nNota[0]9.9);
                                console.log(nNota[0].nota);
                */
                aNotas.push(sCampo);


            });
        });
        //       console.log(aNotas);
        res.notas = aNotas;
        console.log('Vetor: ', aNotas);

    });

    //console.log(resultados);
    //console.log(quesitos);
    //console.log(avaliadores);

    return (resultados);
}

helpers.agregarNotas1 = async (sEvtId, resultados, quesitos, avaliadores) => {
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
    console.log(aNt);
    return (resultados);
}

//            res.notas[index] = row.nota00;



helpers.agregarNotas2 = (sEvtId, resultados, quesitos, avaliadores) => {

    //const aNt = await pool.query('SELECT * FROM notas WHERE evt_id = ? limit 3', [sEvtId]);
    //const aNt1 = await pool.query('SELECT * FROM notas WHERE evt_id = ? limit 3', [sEvtId]);
    //const aNt2 = await pool.query('SELECT * FROM notas WHERE evt_id = ? limit 3', [sEvtId]);

    resultados.forEach(async (res) => {
        var sCanId = res.cdt_id.toString();
        res.notas = [];
        const rows = await pool.query('SELECT nota00 FROM notas WHERE evt_id = ? AND cdt_id = ?', [sEvtId, sCanId]);
        rows.forEach((row) => {
            res.notas.push(row.nota00);
            //            aXX.push(row.nota01);
        });

    });
    return (resultados);
}









/*
        var anotas = [];
        var sCanId = res.cdt_id;
        var rows = await pool.query(
            'SELECT * FROM notas WHERE evt_id = ? AND cdt_id = ?'
            , [sEvtId, sCanId]);

            res.teste = await res.cdt_id;
//        console.log(rows);

        rows.forEach((row) => {
            aXX.push(row.nota00);
            aXX.push(row.nota01);
        });


*/












module.exports = helpers;