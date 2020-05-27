const { format, register } = require('timeago.js');

const helpers = {};

helpers.bcMenu = (index) => {

    var bloco = '';
    const op = ['Coordenador', 'Avaliador', 'Candidato'];
    const p = 'Perfil';
    const fix = '<li class="breadcrumb-item';
    const end = '</a></li>';

    if (!index) {
        bloco += fix + ' active" aria-current="page">' + p + end;
        bloco += fix + '"><a href="/eventos/funcao/0">' + op[0] + end;
        bloco += fix + '"><a href="/eventos/funcao/1">' + op[1] + end;
        bloco += fix + '"><a href="/eventos/funcao/2">' + op[2] + end;
    
    };

    if (index == 0) {
        bloco += fix + '"><a href="/profile">' + p + end;
        bloco += fix + ' active" aria-current="page">' + op[0] + end;
        bloco += fix + '"><a href="/eventos/funcao/1">' + op[1] + end;
        bloco += fix + '"><a href="/eventos/funcao/2">' + op[2] + end;
    };

    if (index == 1) {
        bloco += fix + '"><a href="/profile">' + p + end;
        bloco += fix + '"><a href="/eventos/funcao/0">' + op[0] + end;
        bloco += fix + ' active" aria-current="page">' + op[1] + end;
        bloco += fix + '"><a href="/eventos/funcao/2">' + op[2] + end;
    };

    if (index == 2) {
        bloco += fix + '"><a href="/profile">' + p + end;
        bloco += fix + '"><a href="/eventos/funcao/0">' + op[0] + end;
        bloco += fix + '"><a href="/eventos/funcao/1">' + op[1] + end;
        bloco += fix + ' active" aria-current="page">' + op[2] + end;
    };

    return (bloco);
};


helpers.fDataHora = (isoDate, separator) => {
    const time = isoDate.toTimeString().slice(0, 5);
    const date = ('0' + isoDate.getDate()).slice(-2) + separator +
        ('0' + isoDate.getMonth()).slice(-2) + separator +
        isoDate.getFullYear();
    return (date + ' ' + time);
};



helpers.timeago = (timestamp) => {
    register('pt_BR', default_1);
    return format(timestamp, 'pt_BR');
};


// Locale pt_BR
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function default_1(number, index) {
    return [
        ['agora mesmo', 'agora'],
        ['há %s segundos', 'em %s segundos'],
        ['há um minuto', 'em um minuto'],
        ['há %s minutos', 'em %s minutos'],
        ['há uma hora', 'em uma hora'],
        ['há %s horas', 'em %s horas'],
        ['há um dia', 'em um dia'],
        ['há %s dias', 'em %s dias'],
        ['há uma semana', 'em uma semana'],
        ['há %s semanas', 'em %s semanas'],
        ['há um mês', 'em um mês'],
        ['há %s meses', 'em %s meses'],
        ['há um ano', 'em um ano'],
        ['há %s anos', 'em %s anos'],
    ][index];
}
exports.default = default_1;
//# sourceMappingURL=pt_BR.js.map





module.exports = helpers;
